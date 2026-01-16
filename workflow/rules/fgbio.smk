
rule fgbio_collect_duplex_seq_metrics:
    input:
        bam="alignment/fgbio_group_reads_by_umi/{sample}_{type}.umi.bam",
    output:
        family_sizes=temp("alignment/fgbio_collect_duplex_seq_metrics/{sample}_{type}.family_sizes.txt"),
        duplex_family_sizes=temp("alignment/fgbio_collect_duplex_seq_metrics/{sample}_{type}.duplex_family_sizes.txt"),
        duplex_yield_metrics=temp("alignment/fgbio_collect_duplex_seq_metrics/{sample}_{type}.duplex_yield_metrics.txt"),
        umi_counts=temp("alignment/fgbio_collect_duplex_seq_metrics/{sample}_{type}.umi_counts.txt"),
    params:
        intervals=lambda wildcards: (
            "--intervals %s" % config["reference"]["design_intervals"]
            if config.get("reference", {}).get("design_intervals")
            else ""
        ),
        description=lambda wildcards: "--description %s_%s" % (wildcards.sample, wildcards.type),
        extra=config.get("fgbio_collect_duplex_seq_metrics", {}).get("extra", ""),
    log:
        "alignment/fgbio_collect_duplex_seq_metrics/{sample}_{type}.log",
    benchmark:
        repeat(
            "alignment/fgbio_collect_duplex_seq_metrics/{sample}_{type}.benchmark.tsv",
            config.get("fgbio_collect_duplex_seq_metrics", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("fgbio_collect_duplex_seq_metrics", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("fgbio_collect_duplex_seq_metrics", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("fgbio_collect_duplex_seq_metrics", {}).get(
            "mem_per_cpu", config["default_resources"]["mem_per_cpu"]
        ),
        partition=config.get("fgbio_collect_duplex_seq_metrics", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("fgbio_collect_duplex_seq_metrics", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("fgbio_collect_duplex_seq_metrics", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("fgbio_collect_duplex_seq_metrics", {}).get("container", config["default_container"])
    message:
        "{rule}: collect duplex seq metrics for {input.bam}"
    shell:
        "(fgbio CollectDuplexSeqMetrics "
        "--input {input.bam} "
        "--output alignment/fgbio_collect_duplex_seq_metrics/{wildcards.sample}_{wildcards.type} "
        "{params.intervals} "
        "{params.description} "
        "{params.extra}) &> {log}"
