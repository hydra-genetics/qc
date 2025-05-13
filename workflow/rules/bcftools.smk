__author__ = "Pádraic Corcoran"
__copyright__ = "Copyright 2025, Pádraic Corcoran"
__email__ = "padraic.corcoran@scilifelab.uu.se"
__license__ = "GPL-3"


rule bcftools_stats:
    input:
        vcf="snv_indels/deepvariant/{sample}_{type}.merged.vcf.gz",
    output:
        stats="qc/bcftools_stats/{sample}_{type}.stats.txt",
    params:
        extra=config.get("bcftools_stats", {}).get("extra", ""),
    log:
        "qc/bcftools_stats/{sample}_{type}.stats.txt.log",
    benchmark:
        repeat(
            "qc/bcftools_stats/{sample}_{type}.stats.txt.benchmark.tsv",
            config.get("bcftools_stats", {}).get("benchmark_repeats", 1)
        )
    threads: config.get("bcftools_stats", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("bcftools_stats", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("bcftools_stats", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("bcftools_stats", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("bcftools_stats", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("bcftools_stats", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("bcftools_stats", {}).get("container", config["default_container"])
    message:
        "{rule}: Calculate variant statistcs from {input.input1} using bcftools stats"
    wrapper:
        "v6.0.0/bio/bcftools/stats"
