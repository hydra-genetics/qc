# vim: syntax=python tabstop=4 expandtab
# coding: utf-8

__author__ = "Jonas Almlöf"
__copyright__ = "Copyright 2021, Jonas Almlöf"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


rule picard_insert_size:
    input:
        bam="alignment/merge_bam/{sample}_{type}.bam",
    output:
        txt=temp("qc/picard_insert_size/{sample}_{type}.insert_size_metrics.txt"),
        pdf=temp("qc/picard_insert_size/{sample}_{type}.insert_size_histogram.pdf"),
    params:
        extra=config.get("picard_insert_size", {}).get("extra", ""),
    log:
        "qc/picard_insert_size/{sample}_{type}.log",
    benchmark:
        repeat(
            "qc/picard_insert_size/{sample}_{type}.benchmark.tsv",
            config.get("picard_insert_size", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("picard_insert_size", {}).get("threads", config["default_resources"]["threads"])
    resources:
        threads=config.get("picard_insert_size", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_insert_size", {}).get("time", config["default_resources"]["time"]),
        mem_mb=config.get("picard_insert_size", {}).get("mem_mb", 1024),
    container:
        config.get("picard_insert_size", {}).get("container", config["default_container"])
    conda:
        "../envs/picard_insert_size.yaml"
    message:
        "{rule}: Calculate qc using picard: qc/{rule}/{wildcards.sample}_{wildcards.type}"
    wrapper:
        "0.79.0/bio/picard/collectinsertsizemetrics"
