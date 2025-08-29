__author__ = "Jonas Almlöf"
__copyright__ = "Copyright 2021, Jonas Almlöf"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


rule samtools_stats:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
    output:
        stats=temp("qc/samtools_stats/{sample}_{type}.samtools-stats.txt"),
    params:
        extra=config.get("samtools_stats", {}).get("extra", ""),
    log:
        "qc/samtools_stats/{sample}_{type}.samtools-stats.txt.log",
    benchmark:
        repeat(
            "qc/samtools_stats/{sample}_{type}.samtools-stats.txt.benchmark.tsv",
            config.get("samtools_stats", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("samtools_stats", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("samtools_stats", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("samtools_stats", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("samtools_stats", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("samtools_stats", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("samtools_stats", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("samtools_stats", {}).get("container", config["default_container"])
    message:
        "{rule}: calculate qc using samtools for {input.bam}"
    wrapper:
        "v3.0.0/bio/samtools/stats"


rule samtools_idxstats:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        bai="alignment/samtools_merge_bam/{sample}_{type}.bam.bai",
    output:
        stats=temp("qc/samtools_idxstats/{sample}_{type}.samtools-idxstats.txt"),
    params:
        extra=config.get("samtools_idxstats", {}).get("extra", ""),
    log:
        "qc/samtools_idxstats/{sample}_{type}.samtools-idxstats.txt.log",
    benchmark:
        repeat(
            "qc/samtools_idxstats/{sample}_{type}.samtools-idxstats.txt.benchmark.tsv",
            config.get("samtools_idxstats", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("samtools_idxstats", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("samtools_idxstats", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("samtools_idxstats", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("samtools_idxstats", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("samtools_idxstats", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("samtools_idxstats", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("samtools_idxstats", {}).get("container", config["default_container"])
    message:
        "{rule}: calculate index qc using samtools for {input.bai}"
    wrapper:
        "v1.5.0/bio/samtools/idxstats"
