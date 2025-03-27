__author__ = "Jonas A"
__copyright__ = "Copyright 2021, Jonas A"
__email__ = "jonas.almlof@igp.uu.se"
__license__ = "GPL-3"

import pandas as pd

from hydra_genetics.utils.resources import load_resources
from hydra_genetics.utils.samples import *
from hydra_genetics.utils.units import *
from snakemake.utils import validate
from snakemake.utils import min_version

min_version("7.8.0")

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
    sample="|".join(samples.index),
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


def compile_output_list(wildcards):
    platform = units.platform.iloc[0]
    types = set([u.type for u in units.itertuples()])
    output_files = []
    if platform not in ["ONT", "PACBIO"]:
        for qc_type, value in config.get("multiqc", {}).get("reports", {}).items():
            if not set(value.get("included_unit_types", [])).isdisjoint(types):
                output_files.append("qc/multiqc/multiqc_{}.html".format(qc_type))
    files = {
        "qc/gatk_calculate_contamination": ["contamination.table"],
        # "qc/verifybamid2": ["selfSM", "ancestry"],
    }
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
        "qc/nanoplot": ["NanoPlot-report.html", "NanoStats.txt"],
    }

    output_files += [
        f"{prefix}/{sample}_{unit_type}_{suffix}"
        for prefix in files.keys()
        for sample in get_samples(samples)
        for platform in units.loc[(sample,)].platform
        if platform in ["ONT", "PACBIO"]
        for unit_type in get_unit_types(units, sample)
        for suffix in files[prefix]
    ]

    return output_files
