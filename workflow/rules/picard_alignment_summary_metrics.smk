# vim: syntax=python tabstop=4 expandtab
# coding: utf-8

__author__ = "Jonas Almlöf"
__copyright__ = "Copyright 2021, Jonas Almlöf"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


rule picard_alignment_summary_metrics:
    input:
        bam="alignment/merge_bam/{sample}_{type}.bam",
        ref=config["reference"]["fasta"],
    output:
        metrics=temp("qc/picard_alignment_summary_metrics/{sample}_{type}.alignment_summary_metrics.txt"),
    params:
        extra=config.get("picard_alignment_summary_metrics", {}).get("extra", ""),
    log:
        "qc/picard_alignment_summary_metrics/{sample}_{type}.log",
    benchmark:
        repeat(
            "qc/picard_alignment_summary_metrics/{sample}_{type}.benchmark.tsv",
            config.get("picard_alignment_summary_metrics", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("picard_alignment_summary_metrics", {}).get("threads", config["default_resources"]["threads"])
    resources:
        threads=config.get("picard_alignment_summary_metrics", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_alignment_summary_metrics", {}).get("time", config["default_resources"]["time"]),
        mem_mb=config.get("picard_alignment_summary_metrics", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
    container:
        config.get("picard_alignment_summary_metrics", {}).get("container", config["default_container"])
    conda:
        "../envs/picard_alignment_summary_metrics.yaml"
    message:
        "{rule}: Calculate qc using picard: qc/{rule}/{wildcards.sample}_{wildcards.type}"
    wrapper:
        "0.79.0/bio/picard/collectalignmentsummarymetrics"
