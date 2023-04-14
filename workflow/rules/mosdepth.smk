__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule mosdepth:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        bai="alignment/samtools_merge_bam/{sample}_{type}.bam.bai",
    output:
        bed=temp("qc/mosdepth/{sample}_{type}.regions.bed.gz"),
        csi=temp("qc/mosdepth/{sample}_{type}.regions.bed.gz.csi"),
        glob=temp("qc/mosdepth/{sample}_{type}.mosdepth.global.dist.txt"),
        region=temp("qc/mosdepth/{sample}_{type}.mosdepth.region.dist.txt"),
        summary=temp("qc/mosdepth/{sample}_{type}.mosdepth.summary.txt"),
    params:
        by=config.get("mosdepth", {}).get("by", ""),
        extra=config.get("mosdepth", {}).get("extra", ""),
    log:
        "qc/mosdepth/{sample}_{type}.mosdepth.summary.txt.log",
    benchmark:
        repeat(
            "qc/mosdepth/{sample}_{type}.mosdepth.summary.txt.benchmark.tsv",
            config.get("mosdepth", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("mosdepth", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("mosdepth", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("mosdepth", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("mosdepth", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("mosdepth", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("mosdepth", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("mosdepth", {}).get("container", config["default_container"])
    message:
        "{rule}: calculating coverage for {input.bam}"
    wrapper:
        "0.80.2/bio/mosdepth"


rule mosdepth_bed:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        bai="alignment/samtools_merge_bam/{sample}_{type}.bam.bai",
        bed=config.get("reference", {}).get("design_bed", ""),
    output:
        bed=temp("qc/mosdepth_bed/{sample}_{type}.regions.bed.gz"),
        bed_csi=temp("qc/mosdepth_bed/{sample}_{type}.regions.bed.gz.csi"),
        coverage=temp("qc/mosdepth_bed/{sample}_{type}.per-base.bed.gz"),
        coverage_csi=temp("qc/mosdepth_bed/{sample}_{type}.per-base.bed.gz.csi"),
        glob=temp("qc/mosdepth_bed/{sample}_{type}.mosdepth.global.dist.txt"),
        region=temp("qc/mosdepth_bed/{sample}_{type}.mosdepth.region.dist.txt"),
        summary=temp("qc/mosdepth_bed/{sample}_{type}.mosdepth.summary.txt"),
    params:
        extra=config.get("mosdepth_bed", {}).get("extra", ""),
    log:
        "qc/mosdepth_bed/{sample}_{type}.mosdepth.summary.txt.log",
    benchmark:
        repeat(
            "qc/mosdepth_bed/{sample}_{type}.mosdepth.summary.txt.benchmark.tsv",
            config.get("mosdepth_bed", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("mosdepth_bed", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("mosdepth_bed", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("mosdepth_bed", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("mosdepth_bed", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("mosdepth_bed", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("mosdepth_bed", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("mosdepth_bed", {}).get("container", config["default_container"])
    message:
        "{rule}: calculating coverage for {input.bam}"
    wrapper:
        "0.80.2/bio/mosdepth"
