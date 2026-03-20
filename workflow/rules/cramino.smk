__author__ = "Padraic Corcoran"
__copyright__ = "Copyright 2025, Padraic Corcoran"
__email__ = "padraic.corcoran@scilifelab.uu.se"
__license__ = "GPL-3"


rule cramino:
    input:
        bam="alignment/minimap2_align/{sample}_{type}.bam",
    output:
        txt=temp("qc/cramino/{sample}_{type}.txt"),
        arrow=temp("qc/cramino/{sample}_{type}.arrow"),
    params:
        extra=config.get("cramino", {}).get("extra", ""),
    log:
        "qc/cramino/{sample}_{type}.output.log",
    benchmark:
        repeat("qc/cramino/{sample}_{type}.output.benchmark.tsv", config.get("cramino", {}).get("benchmark_repeats", 1))
    threads: config.get("cramino", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("cramino", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("cramino", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("cramino", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("cramino", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("cramino", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("cramino", {}).get("container", config["default_container"])
    message:
        "{rule}: extreact read statistics from {input.bam}"
    shell:
        "cramino "
        "--arrow {output.arrow} "
        "--threads {threads} "
        "{params.extra} "
        "{input.bam}  > {output.txt} 2> {log}"
