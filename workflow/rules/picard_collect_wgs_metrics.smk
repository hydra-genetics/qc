__author__ = "Martin Rippin"
__copyright__ = "Copyright 2021, Martin Rippin"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule picard_collect_wgs_metrics:
    input:
        bam="alignment/merge_bam/{sample}_{type}.bam",
        ref=config["reference"]["fasta"],
        interval=config["reference"]["wgs_intervals"],
    output:
        metrics=temp("qc/picard_collect_wgs_metrics/{sample}_{type}.txt"),
    params:
        extra=config.get("picard_collect_wgs_metrics", {}).get("extra", ""),
    log:
        "qc/picard_collect_wgs_metrics/{sample}_{type}.log",
    benchmark:
        repeat(
            "qc/picard_collect_wgs_metrics/{sample}_{type}.benchmark.tsv",
            config.get("picard_collect_wgs_metrics", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("picard_collect_wgs_metrics", {}).get("threads", config["default_resources"]["threads"])
    resources:
        threads=config.get("picard_collect_wgs_metrics", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_collect_wgs_metrics", {}).get("time", config["default_resources"]["time"]),
        mem_mb=config.get("picard_collect_wgs_metrics", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("picard_collect_wgs_metrics", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("picard_collect_wgs_metrics", {}).get("partition", config["default_resources"]["partition"]),
    container:
        config.get("picard_collect_wgs_metrics", {}).get("container", config["default_container"])
    conda:
        "../envs/picard_collect_wgs_metrics.yaml"
    message:
        "{rule}: collect WGS metrics using picard: qc/{rule}/{wildcards.sample}_{wildcards.type}"
    shell:
        "(picard CollectWgsMetrics "
        "I={input.bam} "
        "O={output.metrics} "
        "R={input.ref} "
        "INTERVALS={input.interval} "
        "{params.extra}) &> {log}"
