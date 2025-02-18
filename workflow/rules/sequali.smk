__author__ = "Padraic Corcoran"
__copyright__ = "Copyright 2024, Padraic Corcoran"
__email__ = "padraic.corcoran@scilifelab.uu.se"
__license__ = "GPL-3"


rule sequali:
    input:
        infile=lambda wildcards: get_bam_input(wildcards),
    output:
        html=temp("qc/sequali/{sample}_{type}_{processing_unit}_{barcode}.html"),
        json=temp("qc/sequali/{sample}_{type}_{processing_unit}_{barcode}.json"),
    params:
        extra=config.get("sequali", {}).get("extra", ""),
    log:
        "qc/sequali/{sample}_{type}_{processing_unit}_{barcode}.html.log",
    benchmark:
        repeat(
            "qc/sequali/{sample}_{type}_{processing_unit}_{barcode}.html.benchmark.tsv",
            config.get("sequali", {}).get("benchmark_repeats", 1)
        )
    threads: config.get("sequali", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("sequali", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("sequali", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("sequali", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("sequali", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("sequali", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("sequali", {}).get("container", config["default_container"])
    message:
        "{rule}: extract sequali qc stats from {input.infile}"
    shell:
        "sequali {input.infile} "
        "--json {output.json} "
        "--html {output.html} "
        "{params.extra} &> {log}"
