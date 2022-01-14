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

units = pandas.read_table(config["units"], dtype=str).set_index(["sample", "type", "run", "lane"], drop=False).sort_index()
validate(units, schema="../schemas/units.schema.yaml")


def get_run(units, wildcards):
    runs = set([u.run for u in get_units(units, wildcards)])
    if len(runs) > 1:
        raise ValueError("Sample type combination from different sequence runs")
    return runs.pop()


### Set wildcard constraints


wildcard_constraints:
    sample="|".join(samples.index),
    unit="N|T|R",


def compile_output_list(wildcards: snakemake.io.Wildcards):
    output = [
        "qc/fastqc/%s_%s_%s_fastqc.html" % (sample, t, read)
        for read in ["fastq1", "fastq2"]
        for sample in get_samples(samples)
        for t in get_unit_types(units, sample)
    ]
    output.append(
        [
            "qc/picard_duplication_metrics/%s_%s.duplication_metrics.txt" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    )
    output.append(
        [
            "qc/picard_alignment_summary_metrics/%s_%s.alignment_summary_metrics.txt" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    )
    output.append(
        [
            "qc/picard_collect_hs_metrics/%s_%s.HsMetrics.txt" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    )
    output.append(
        [
            "qc/picard_insert_size/%s_%s.insert_size_metrics.txt" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    )
    output.append(
        [
            "qc/picard_collect_gc_bias_metrics/%s_%s.gc_bias.summary_metrics" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    )
    output.append(
        [
            "qc/picard_collect_multiple_metrics/%s_%s.%s" % (sample, t, ext)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
            for ext in config.get("picard_collect_multiple_metrics", []).get("output_ext", [])
        ]
    )
    output.append(
        [
            "qc/picard_collect_wgs_metrics/%s_%s.txt" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    )
    output.append(
        [
            "qc/samtools_stats/%s_%s.samtools-stats.txt" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    )
    output.append(
        [
            "qc/hotspot_info/%s_%s.hotspot_info.tsv" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    )
    output.append(
        [
            "qc/mosdepth/%s_%s.mosdepth.summary.txt" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
        ]
    )
    output.append("qc/multiqc/MultiQC.html")
    return output
