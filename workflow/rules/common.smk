# vim: syntax=python tabstop=4 expandtab
# coding: utf-8

__author__ = "Jonas A"
__copyright__ = "Copyright 2021, Jonas A"
__email__ = "jonas.almlof@igp.uu.se"
__license__ = "GPL-3"

import pandas as pd
from snakemake.utils import validate
from snakemake.utils import min_version

from hydra_genetics.utils.resources import load_resources
from hydra_genetics.utils.samples import *
from hydra_genetics.utils.units import *

min_version("6.8.0")

### Set and validate config file


configfile: "config.yaml"


validate(config, schema="../schemas/config.schema.yaml")
config = load_resources(config, config["resources"])
validate(config, schema="../schemas/resources.schema.yaml")


### Read and validate samples file

samples = pd.read_table(config["samples"], dtype=str).set_index("sample", drop=False)
validate(samples, schema="../schemas/samples.schema.yaml")

### Read and validate units file

units = pandas.read_table(config["units"], dtype=str).set_index(["sample", "type", "flowcell", "lane"], drop=False).sort_index()
validate(units, schema="../schemas/units.schema.yaml")


def get_flowcell(units, wildcards):
    flowcells = set([u.flowcell for u in get_units(units, wildcards)])
    if len(flowcells) > 1:
        raise ValueError("Sample type combination from different sequence flowcells")
    return flowcells.pop()


### Set wildcard constraints


wildcard_constraints:
    sample="|".join(samples.index),
    unit="N|T|R",


def compile_output_list(wildcards):
    files = {
        "qc/picard_collect_duplication_metrics": [".duplication_metrics.txt"],
        "qc/picard_collect_alignment_summary_metrics": [".alignment_summary_metrics.txt"],
        "qc/picard_collect_hs_metrics": [".HsMetrics.txt"],
        "qc/picard_collect_insert_size_metrics": [".insert_size_metrics.txt"],
        "qc/picard_collect_gc_bias_metrics": [".gc_bias.summary_metrics"],
        "qc/picard_collect_wgs_metrics": [".txt"],
        "qc/samtools_stats": [".samtools-stats.txt"],
        "qc/hotspot_info": [".hotspot_info.tsv"],
        "qc/mosdepth": [".mosdepth.summary.txt"],
        "qc/mosdepth_bed": [".per-base.bed.gz"],
    }
    output_files = [
        "%s/%s_%s%s" % (prefix, sample, unit_type, suffix)
        for prefix in files.keys()
        for sample in get_samples(samples)
        for unit_type in get_unit_types(units, sample)
        for suffix in files[prefix]
    ]
    output_files.append(
        [
            "qc/fastqc/%s_%s_%s_fastqc.html" % (sample, t, read)
            for read in ["fastq1", "fastq2"]
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    )
    output_files.append(
        [
            "qc/picard_collect_multiple_metrics/%s_%s.%s" % (sample, t, ext)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
            for ext in config.get("picard_collect_multiple_metrics", []).get("output_ext", [])
        ]
    )
    output_files.append("qc/multiqc/MultiQC.html")
    return output_files
