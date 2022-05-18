__author__ = "Martin Rippin"
__copyright__ = "Copyright 2022, Martin Rippin"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule fastqc:
    input:
        fastq=lambda wildcards: get_fastq_file(units, wildcards, wildcards.read),
    output:
        html=temp("qc/fastqc/{sample}_{type}_{flowcell}_{lane}_{barcode}_{read}_fastqc.html"),
        zip=temp("qc/fastqc/{sample}_{type}_{flowcell}_{lane}_{barcode}_{read}_fastqc.zip"),
    log:
        "qc/fastqc/{sample}_{type}_{flowcell}_{lane}_{barcode}_{read}_fastqc.html.log",
    benchmark:
        repeat(
            "qc/fastqc/{sample}_{type}_{flowcell}_{lane}_{barcode}_{read}_fastqc.html.benchmark.tsv",
            config.get("fastqc", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("fastqc", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("fastqc", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("fastqc", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("fastqc", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("fastqc", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("fastqc", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("fastqc", {}).get("container", config["default_container"])
    conda:
        "../envs/fastqc.yaml"
    message:
        "{rule}: sequencing run stats for {input.fastq}"
    wrapper:
        "v1.3.1/bio/fastqc"
