__author__ = "Jonas A"
__copyright__ = "Copyright 2021, Jonas A"
__email__ = "jonas.almlof@igp.uu.se"
__license__ = "GPL-3"

import re

import pandas as pd

from hydra_genetics.utils.resources import load_resources
from hydra_genetics.utils.samples import *
from hydra_genetics.utils.units import *
from hydra_genetics.utils.misc import get_input_aligned_bam
from snakemake.utils import validate
from snakemake.utils import min_version

min_version("9.0.0")

### Set and validate config file

if not workflow.overwrite_configfiles:
    sys.exit("At least one config file must be passed using --configfile/--configfiles, by command line or a profile!")


validate(config, schema="../schemas/config.schema.yaml")
config = load_resources(config, config["resources"])
validate(config, schema="../schemas/resources.schema.yaml")


### Read and validate samples file

samples = pd.read_table(config["samples"], dtype=str).set_index("sample", drop=False)
validate(samples, schema="../schemas/samples.schema.yaml")

### Read and validate units file
units = pandas.read_table(config["units"], dtype=str)

if units.platform.iloc[0] in ["PACBIO", "ONT"]:
    units = units.set_index(["sample", "type", "processing_unit", "barcode"], drop=False).sort_index()
else:  # assume that the platform Illumina data with a lane and flowcell columns
    units = units.set_index(["sample", "type", "flowcell", "lane", "barcode"], drop=False).sort_index()
validate(units, schema="../schemas/units.schema.yaml")

### Set wildcard constraints


wildcard_constraints:
    barcode="[A-Z+-]+",
    sample="|".join(re.escape(s) for s in samples.index),
    type="N|T|R",


def get_flowcell(units, wildcards):
    flowcells = set([u.flowcell for u in get_units(units, wildcards)])
    if len(flowcells) > 1:
        raise ValueError("Sample type combination from different sequence flowcells")
    return flowcells.pop()


def get_bam_input(wildcards):
    unit = units.loc[(wildcards.sample, wildcards.type, wildcards.processing_unit, wildcards.barcode)]
    bam_file = unit["bam"]

    return bam_file


def get_fam_inputs(wildcards):
    """Gather all .fam files for all sample types."""
    # For trio analysis
    if config.get("somalier_trio_extract"):
        return [
            "qc/somalier_trio_create_ped/%s_%s.fam" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    # For matched analysis
    elif config.get("somalier_matched_extract"):
        return [
            "qc/somalier_matched_create_ped/%s_%s.fam" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    return []


def get_somalier_relate_samples(wildcards):
    """Gather all .somalier files for all sample types."""
    # For trio analysis
    if config.get("somalier_trio_extract"):
        return [
            "qc/somalier_trio_extract/%s_%s.somalier" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    # For matched analysis
    elif config.get("somalier_matched_extract"):
        return [
            "qc/somalier_matched_extract/%s_%s.somalier" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    # For ungrouped analysis
    elif config.get("somalier_ungrouped_extract"):
        return [
            "qc/somalier_ungrouped_extract/%s_%s.somalier" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    return []


def has_tn_pairs(samples_dict, units_dict):
    """Check if any samples have both T (tumor) and N (normal) types.

    Used to conditionally include the group file in somalier_relate for matched samples.
    """
    for sample in get_samples(samples_dict):
        types = set(get_unit_types(units_dict, sample))
        if "T" in types and "N" in types:
            return True
    return False


def has_trio_samples(samples_dict):
    """Check if samples file has trio information.

    Used to conditionally include the group file in somalier_trio_relate.
    Checks for presence of trio, father, and mother columns in samples.
    """
    required_cols = ["trio", "father", "mother"]

    # Check if required columns exist in the DataFrame
    if not all(col in samples_dict.columns for col in required_cols):
        return False

    # Check if any sample has non-empty trio information
    return any((samples_dict["trio"].notna()) & (samples_dict["trio"] != ".") & (samples_dict["trio"] != "0"))


def compile_output_list(wildcards):
    platform = units.platform.iloc[0]
    types = set([u.type for u in units.itertuples()])
    output_files = []
    for qc_type, value in config.get("multiqc", {}).get("reports", {}).items():
        if not set(value.get("included_unit_types", [])).isdisjoint(types):
            output_files.append("qc/multiqc/multiqc_{}.html".format(qc_type))

    files = {
        "qc/gatk_calculate_contamination": ["contamination.table"],
        # "qc/verifybamid2": ["selfSM", "ancestry"],
    }

    # Only include fgbio outputs if fgbio is configured
    if config.get("fgbio_collect_duplex_seq_metrics"):
        files["qc/fgbio_collect_duplex_seq_metrics"] = [
            "family_sizes.txt",
            "duplex_family_sizes.txt",
            "duplex_yield_metrics.txt",
            "umi_counts.txt",
        ]
        files["qc/fgbio_duplex_yield_summary"] = ["duplex_yield_summary.txt"]

    # Since it is not possible to create integration test without a large dataset verifybamid2  will not be subjected to integration
    # testing and we can not guarantee that it will work

    output_files += [
        "%s/%s_%s.%s" % (prefix, sample, unit_type, suffix)
        for prefix in files.keys()
        for sample in get_samples(samples)
        for platform in units.loc[(sample,)].platform
        if platform not in ["ONT", "PACBIO"]
        for unit_type in get_unit_types(units, sample)
        for suffix in files[prefix]
        if unit_type != "R"
    ]

    if platform not in ["ONT", "PACBIO"]:
        output_files += [
            "qc/peddy/peddy.peddy.ped",
            "qc/peddy/peddy.ped_check.csv",
            "qc/peddy/peddy.sex_check.csv",
            "qc/peddy/peddy.het_check.csv",
            "qc/peddy/peddy.html",
            "qc/peddy/peddy.vs.html",
            "qc/peddy/peddy.background_pca.json",
        ]

        # Somalier matched samples (T/N pairs)
        if config.get("somalier_matched_extract") and has_tn_pairs(samples, units):
            output_files += [
                "qc/somalier_matched/somalier_relate.pairs.tsv",
                "qc/somalier_matched/somalier_relate.samples.tsv",
                "qc/somalier_matched/somalier_relate.html",
                "qc/somalier_matched/somalier_samples_mqc.tsv",
                "qc/somalier_matched/TNmismatch.txt",
            ]

        # Somalier trio analysis (mutually exclusive with matched)
        elif config.get("somalier_trio_extract") and has_trio_samples(samples):
            output_files += [
                "qc/somalier_trio/somalier_relate.pairs.tsv",
                "qc/somalier_trio/somalier_relate.samples.tsv",
                "qc/somalier_trio/somalier_relate.html",
                "qc/somalier_trio/somalier_samples_mqc.tsv",
                "qc/somalier_trio/trio_validation.txt",
            ]

        # Somalier ungrouped module (for RNA or general relatedness checking)
        elif config.get("somalier_ungrouped_extract"):
            output_files += [
                "qc/somalier_ungrouped/somalier_relate.pairs.tsv",
                "qc/somalier_ungrouped/somalier_relate.samples.tsv",
                "qc/somalier_ungrouped/somalier_relate.html",
                "qc/somalier_ungrouped/somalier_samples_mqc.tsv",
            ]

    files = {
        "qc/sequali": ["html"],
    }

    output_files += [
        f"{prefix}/{sample}_{u.type}_{u.processing_unit}_{u.barcode}.{suffix}"
        for prefix in files.keys()
        for sample in get_samples(samples)
        for platform in units.loc[(sample,)].platform
        if platform in ["ONT", "PACBIO"]
        for u in units.loc[sample].dropna().itertuples()
        for suffix in files[prefix]
    ]

    files = {
        "qc/cramino": [".txt", ".arrow"],
        "qc/bcftools_stats": [".stats.txt"],
    }

    output_files += [
        f"{prefix}/{sample}_{unit_type}{suffix}"
        for prefix in files.keys()
        for sample in get_samples(samples)
        for platform in units.loc[(sample,)].platform
        if platform in ["ONT", "PACBIO"]
        for unit_type in get_unit_types(units, sample)
        for suffix in files[prefix]
    ]

    files = {
        "qc/nanoplot": [".html", ".txt"],
    }

    output_files += [
        f"{prefix}/{sample}_{unit_type}{suffix}"
        for prefix in files.keys()
        for sample in get_samples(samples)
        for platform in units.loc[(sample,)].platform
        if platform in ["ONT", "PACBIO"]
        for unit_type in get_unit_types(units, sample)
        for suffix in files[prefix]
    ]

    return output_files
