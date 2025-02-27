__author__ = "Padraic Corcoran"
__copyright__ = "Copyright 2025, Padraic Corcoran"
__email__ = "padraic.corcoran@scilifelab.uu.se"
__license__ = "GPL-3"


rule nanoplot:
    input:
        arrow="qc/cramino/{sample}_{type}.arrow",
    output:
        report=temp("qc/nanoplot/{sample}_{type}_NanoPlot-report.html"),
        stats=temp("qc/nanoplot/{sample}_{type}_NanoStats.txt"),
    params:
        extra=config.get("nanoplot", {}).get("extra", ""),
        outdir=lambda wildcards: f"qc/nanoplot/{wildcards.sample}_{wildcards.type}",
    log:
        "qc/nanoplot/{sample}_{type}_Nanoplot.log",
    benchmark:
        repeat("qc/nanoplot/{sample}_{type}_Nanoplot.benchmark.tsv", config.get("nanoplot", {}).get("benchmark_repeats", 1))
    threads: config.get("nanoplot", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("nanoplot", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("nanoplot", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("nanoplot", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("nanoplot", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("nanoplot", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("nanoplot", {}).get("container", config["default_container"])
    message:
        "{rule}: visualise and summarise reads in {input.arrow}"
    shell:
        "NanoPlot --arrow {input.arrow} "
        "-o {params.outdir} "
        "--threads {threads} "
        "{params.extra} "
        "--only-report &&"
        "cp {params.outdir}/NanoStats.txt {output.stats} &&"
        "cp {params.outdir}/NanoPlot-report.html {output.report} &> {log}"
