__author__ = "Nina Hollfelder, Julia Höglund"
__copyright__ = "Copyright 2021, Nina Hollfelder, Julia Höglund"
__email__ = "nina.hollfelder@scilifelab.uu.se, julia.hoglund@scilifelab.uu.se"
__license__ = "GPL-3"


import os


rule somalier_ungrouped_extract:
    input:
        sites=config.get("somalier_ungrouped_extract", {}).get("sites", ""),
        fasta=config.get("reference", {}).get("fasta", ""),
        fai=config.get("reference", {}).get("fasta", "") + ".fai",
        bam=lambda wildcards: get_input_aligned_bam(wildcards, config)[0],
        bai=lambda wildcards: get_input_aligned_bam(wildcards, config)[1],
    output:
        somalier=temp("qc/somalier_ungrouped_extract/{sample}_{type}.somalier"),
    params:
        extra=config.get("somalier_ungrouped_extract", {}).get("extra", ""),
        fasta_abs=lambda wildcards, input: os.path.abspath(input.fasta),
        sites_abs=lambda wildcards, input: os.path.abspath(input.sites),
        sample_name=lambda wildcards: f"{wildcards.sample}_{wildcards.type}",
    log:
        "qc/somalier_ungrouped_extract/{sample}_{type}.somalier.log",
    benchmark:
        repeat(
            "qc/somalier_ungrouped_extract/{sample}_{type}.somalier.benchmark.tsv",
            config.get("somalier_ungrouped_extract", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_ungrouped_extract", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_ungrouped_extract", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_ungrouped_extract", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_ungrouped_extract", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_ungrouped_extract", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_ungrouped_extract", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_ungrouped_extract", {}).get("container", config["default_container"])
    message:
        "{rule}: extract sites for somalier in sample {wildcards.sample}_{wildcards.type}.bam"
    shell:
        """
        # Create a temp directory for this specific job to avoid race conditions and handle renaming
        tmpdir=$(mktemp -d -p $(dirname {output.somalier}))
        SOMALIER_SAMPLE_NAME={params.sample_name} somalier extract {params.extra} -s {params.sites_abs} -f {params.fasta_abs} -d $tmpdir {input.bam} 2> {log}
        generated_file=$(find $tmpdir -name "*.somalier" -type f | head -n1)

        if [ -f "$generated_file" ]; then
            mv "$generated_file" {output.somalier}
        else
            echo "Error: No somalier output file found in temp directory $tmpdir" >&2
            rm -rf $tmpdir
            exit 1
        fi

        # Clean up
        rm -rf $tmpdir
        """


rule somalier_ungrouped_mqc:
    input:
        samples="qc/somalier_ungrouped/somalier_relate.samples.tsv",
    output:
        mqc="qc/somalier_ungrouped/somalier_samples_mqc.tsv",
    params:
        mqc_config=lambda wildcards: os.path.abspath(config.get("somalier_ungrouped_mqc", {}).get("mqc_config", "")),
    log:
        "qc/somalier_ungrouped_mqc/somalier_samples_mqc.log",
    benchmark:
        repeat(
            "qc/somalier_ungrouped_mqc/somalier_samples_mqc.benchmark.tsv",
            config.get("somalier_ungrouped_mqc", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_ungrouped_mqc", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_ungrouped_mqc", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_ungrouped_mqc", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_ungrouped_mqc", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_ungrouped_mqc", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_ungrouped_mqc", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_ungrouped_mqc", {}).get("container", config["default_container"])
    message:
        "{rule}: creating custom input for somalier to MultiQC general stats"
    script:
        "../scripts/somalier_mqc_config.py"


rule somalier_ungrouped_relate:
    input:
        samples=get_somalier_relate_samples,
    output:
        pairs="qc/somalier_ungrouped/somalier_relate.pairs.tsv",
        samples="qc/somalier_ungrouped/somalier_relate.samples.tsv",
        html="qc/somalier_ungrouped/somalier_relate.html",
    params:
        extra=config.get("somalier_ungrouped_relate", {}).get("extra", ""),
        outname=lambda wildcards, output: output.pairs.replace(".pairs.tsv", ""),
    log:
        "qc/somalier_ungrouped_relate/somalier_relate.log",
    benchmark:
        repeat(
            "qc/somalier_ungrouped_relate/somalier_relate.benchmark.tsv",
            config.get("somalier_ungrouped_relate", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_ungrouped_relate", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_ungrouped_relate", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_ungrouped_relate", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_ungrouped_relate", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_ungrouped_relate", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_ungrouped_relate", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_ungrouped_relate", {}).get("container", config["default_container"])
    message:
        "{rule}: Running somalier relate for ungrouped samples"
    shell:
        "somalier relate {params.extra} -o {params.outname} {input.samples} 2> {log}"
