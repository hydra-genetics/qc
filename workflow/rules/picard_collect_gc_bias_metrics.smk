__author__ = "Martin Rippin"
__copyright__ = "Copyright 2021, Martin Rippin"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule picard_collect_gc_bias_metrics:
    input:
        bam="alignment/merge_bam/{sample}_{type}.bam",
        ref=config["reference"]["fasta"],
    output:
        chart=temp("qc/picard_collect_gc_bias_metrics/{sample}_{type}.gc_bias.pdf"),
        metrics=temp("qc/picard_collect_gc_bias_metrics/{sample}_{type}.gc_bias.detail_metrics"),
        summary=temp("qc/picard_collect_gc_bias_metrics/{sample}_{type}.gc_bias.summary_metrics"),
    params:
        extra=config.get("picard_collect_gc_bias_metrics", {}).get("extra", ""),
    log:
        "qc/picard_collect_gc_bias_metrics/{sample}_{type}.log",
    benchmark:
        repeat(
            "qc/picard_collect_gc_bias_metrics/{sample}_{type}.benchmark.tsv",
            config.get("picard_collect_gc_bias_metrics", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("picard_collect_gc_bias_metrics", {}).get("threads", config["default_resources"]["threads"])
    resources:
        threads=config.get("picard_collect_gc_bias_metrics", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_collect_gc_bias_metrics", {}).get("time", config["default_resources"]["time"]),
        mem_mb=config.get("picard_collect_gc_bias_metrics", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("picard_collect_gc_bias_metrics", {}).get(
            "mem_per_cpu", config["default_resources"]["mem_per_cpu"]
        ),
        partition=config.get("picard_collect_gc_bias_metrics", {}).get("partition", config["default_resources"]["partition"]),
    container:
        config.get("picard_collect_gc_bias_metrics", {}).get("container", config["default_container"])
    conda:
        "../envs/picard_collect_gc_bias_metrics.yaml"
    message:
        "{rule}: Collect GC bias metrics using picard: qc/{rule}/{wildcards.sample}_{wildcards.type}"
    wrapper:
        "0.80.2/bio/picard/collectgcbiasmetrics"
