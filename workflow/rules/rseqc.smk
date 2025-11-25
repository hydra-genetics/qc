__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule rseqc_gene_body_coverage:
    input:
        bam="alignment/star/{sample}_{type}.bam",
        bai="alignment/star/{sample}_{type}.bam.bai",
        bed=config.get("rseqc_gene_body_coverage", {}).get("bed", ""),
    output:
        pdf=temp("qc/rseqc_gene_body_coverage/{sample}_{type}.geneBodyCoverage.curves.pdf"),
        rscrpt=temp("qc/rseqc_gene_body_coverage/{sample}_{type}.geneBodyCoverage.r"),
        txt=temp("qc/rseqc_gene_body_coverage/{sample}_{type}.geneBodyCoverage.txt"),
    params:
        extra=config.get("rseqc_gene_body_coverage", {}).get("extra", ""),
        prefix="qc/rseqc_gene_body_coverage/{sample}_{type}",
    log:
        "qc/rseqc_gene_body_coverage/{sample}_{type}.pdf.log",
    benchmark:
        repeat(
            "qc/rseqc_gene_body_coverage/{sample}_{type}.pdf.benchmark.tsv",
            config.get("rseqc_gene_body_coverage", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("rseqc_gene_body_coverage", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("rseqc_gene_body_coverage", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("rseqc_gene_body_coverage", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("rseqc_gene_body_coverage", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("rseqc_gene_body_coverage", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("rseqc_gene_body_coverage", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("rseqc_gene_body_coverage", {}).get("container", config["default_container"])
    message:
        "{rule}: calculating gene body coverage for {input.bam}"
    shell:
        "(geneBody_coverage.py "
        "-r {input.bed} "
        "-i {input.bam} "
        "-o {params.prefix}) &> {log}"


rule rseqc_inner_distance:
    input:
        bam="alignment/star/{sample}_{type}.bam",
        bai="alignment/star/{sample}_{type}.bam.bai",
        bed=config.get("rseqc_inner_distance", {}).get("bed", ""),
    output:
        freq=temp("qc/rseqc_inner_distance/{sample}_{type}.inner_distance_freq.txt"),
        plot=temp("qc/rseqc_inner_distance/{sample}_{type}.inner_distance_plot.pdf"),
        rscrpt=temp("qc/rseqc_inner_distance/{sample}_{type}.inner_distance_plot.r"),
        txt=temp("qc/rseqc_inner_distance/{sample}_{type}.inner_distance.txt"),
    params:
        extra=config.get("rseqc_inner_distance", {}).get("extra", ""),
        prefix="qc/rseqc_inner_distance/{sample}_{type}",
    log:
        "qc/rseqc_inner_distance/{sample}_{type}.txt.log",
    benchmark:
        repeat(
            "qc/rseqc_inner_distance/{sample}_{type}.txt.benchmark.tsv",
            config.get("rseqc_inner_distance", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("rseqc_inner_distance", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("rseqc_inner_distance", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("rseqc_inner_distance", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("rseqc_inner_distance", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("rseqc_inner_distance", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("rseqc_inner_distance", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("rseqc_inner_distance", {}).get("container", config["default_container"])
    message:
        "{rule}: calculating gene body coverage for {input.bam}"
    shell:
        "(inner_distance.py "
        "-r {input.bed} "
        "-i {input.bam} "
        "-o {params.prefix}) &> {log}"
