__author__ = "Jonas Almlöf"
__copyright__ = "Copyright 2021, Jonas Almlöf"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


rule samtools_stats:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
    output:
        temp("qc/samtools_stats/{sample}_{type}.samtools-stats.txt"),
    params:
        extra="%s -t %s"
        % (
            config.get("samtools_stats", {}).get("extra", ""),
            config.get("reference", {}).get("design_bed", ""),
        ),
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
    conda:
        "../envs/samtools.yaml"
    message:
        "{rule}: calculate qc using samtools for {input.bam}"
    wrapper:
        "0.79.0/bio/samtools/stats"
