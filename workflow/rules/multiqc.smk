# vim: syntax=python tabstop=4 expandtab
# coding: utf-8

__author__ = "Patrik Smeds"
__copyright__ = "Copyright 2021, Patrik Smeds"
__email__ = "patrik.smeds@scilifelab.uu.se"
__license__ = "GPL-3"


rule multiqc:
    input:
        [
            file.format(sample=sample, type=u.type, lane=u.lane, run=u.flowcell)
            for file in config["multiqc"]["qc_files"]
            for sample in get_samples(samples)
            for u in units.loc[sample].dropna().itertuples()
        ],
    output:
        temp("qc/multiqc/MultiQC.html"),
        temp(directory("qc/multiqc/MultiQC_data")),
    params:
        "{} {}".format(
            config.get("multiqc", {}).get("extra", ""),
            " -c {}".format(config["multiqc"]["config"]) if "config" in config.get("multiqc", {}) else "",
        ),
    log:
        "qc/multiqc/multiqc.log",
    benchmark:
        repeat("qc/multiqc/multiqc.benchmark.tsv", config.get("multiqc", {}).get("benchmark_repeats", 1))
    threads: config.get("multiqc", {}).get("threads", config["default_resources"]["threads"])
    resources:
        threads=config.get("multiqc", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("multiqc", {}).get("time", config["default_resources"]["time"]),
        mem_mb=config.get("multiqc", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("multiqc", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("multiqc", {}).get("partition", config["default_resources"]["partition"]),
    container:
        config.get("multiqc", {}).get("container", config["default_container"])
    conda:
        "../envs/multiqc.yaml"
    message:
        "{rule}: Generate multiqc report qc/{rule}/MultiQC.html"
    wrapper:
        "0.72.0/bio/multiqc"
