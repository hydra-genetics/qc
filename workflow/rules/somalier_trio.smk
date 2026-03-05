__author__ = "Nina Hollfelder, Julia Höglund"
__copyright__ = "Copyright 2021, Nina Hollfelder, Julia Höglund"
__email__ = "nina.hollfelder@scilifelab.uu.se, julia.hoglund@scilifelab.uu.se"
__license__ = "GPL-3"


import os


rule somalier_trio_combine_fam:
    input:
        fam=get_fam_inputs,
    output:
        ped=temp("qc/somalier_trio/somalier_all.ped"),
    log:
        "qc/somalier_trio_combine_fam/somalier_all.ped.log",
    benchmark:
        repeat(
            "qc/somalier_trio_combine_fam/somalier_all.ped.benchmark.tsv",
            config.get("somalier_trio_combine_fam", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_trio_combine_fam", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_trio_combine_fam", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_trio_combine_fam", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_trio_combine_fam", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_trio_combine_fam", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_trio_combine_fam", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_trio_combine_fam", {}).get("container", config["default_container"])
    message:
        "{rule}: creates combined somalier_all.ped for trio analysis"
    shell:
        """
        cat {input.fam} > {output.ped} &> {log}
        """


rule somalier_trio_create_groupfile:
    input:
        samples=config["samples"],
    output:
        groups=temp("qc/somalier_trio/somalier.groups"),
    log:
        "qc/somalier_trio_create_groupfile/somalier.groups.log",
    benchmark:
        repeat(
            "qc/somalier_trio_create_groupfile/somalier.groups.benchmark.tsv",
            config.get("somalier_trio_create_groupfile", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_trio_create_groupfile", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_trio_create_groupfile", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_trio_create_groupfile", {}).get(
            "mem_per_cpu", config["default_resources"]["mem_per_cpu"]
        ),
        partition=config.get("somalier_trio_create_groupfile", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_trio_create_groupfile", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_trio_create_groupfile", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_trio_create_groupfile", {}).get("container", config["default_container"])
    message:
        "{rule}: Create trio group file for somalier input"
    script:
        "../scripts/somalier_trio_create_groupfile.py"


rule somalier_trio_create_ped:
    input:
        samples=config["samples"],
    output:
        fam=temp("qc/somalier_trio_create_ped/{sample}_{type}.fam"),
    params:
        sample_type=lambda w: w.type,
    log:
        "qc/somalier_trio_create_ped/{sample}_{type}.fam.log",
    benchmark:
        repeat(
            "qc/somalier_trio_create_ped/{sample}_{type}.fam.benchmark.tsv",
            config.get("somalier_trio_create_ped", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_trio_create_ped", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_trio_create_ped", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_trio_create_ped", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_trio_create_ped", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_trio_create_ped", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_trio_create_ped", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_trio_create_ped", {}).get("container", config["default_container"])
    message:
        "{rule}: Create fam file for {wildcards.sample}_{wildcards.type}"
    script:
        "../scripts/somalier_create_ped.py"


rule somalier_trio_extract:
    input:
        sites=config.get("somalier_trio_extract", {}).get("sites", ""),
        fasta=config.get("reference", {}).get("fasta", ""),
        fai=config.get("reference", {}).get("fasta", "") + ".fai",
        bam=lambda wildcards: get_input_aligned_bam(wildcards, config)[0],
        bai=lambda wildcards: get_input_aligned_bam(wildcards, config)[1],
    output:
        somalier=temp("qc/somalier_trio_extract/{sample}_{type}.somalier"),
    params:
        extra=config.get("somalier_trio_extract", {}).get("extra", ""),
        fasta_abs=lambda wildcards, input: os.path.abspath(input.fasta),
        sites_abs=lambda wildcards, input: (
            os.path.abspath(input.sites)
            if input.sites
            else (_ for _ in ()).throw(
                ValueError(
                    f"somalier_trio_extract: 'sites' parameter is required but empty. "
                    f"Please configure 'somalier_trio_extract.sites' in config.yaml"
                )
            )
        ),
        sample_name=lambda wildcards: f"{wildcards.sample}_{wildcards.type}",
    log:
        "qc/somalier_trio_extract/{sample}_{type}.somalier.log",
    benchmark:
        repeat(
            "qc/somalier_trio_extract/{sample}_{type}.somalier.benchmark.tsv",
            config.get("somalier_trio_extract", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_trio_extract", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_trio_extract", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_trio_extract", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_trio_extract", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_trio_extract", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_trio_extract", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_trio_extract", {}).get("container", config["default_container"])
    message:
        "{rule}: extract sites for somalier in sample {input.bam}"
    shell:
        """
        # Create a temp directory for this specific job to avoid race conditions and handle renaming
        tmpdir=$(mktemp -d -p "$(dirname "{output.somalier}")")
        somalier extract {params.extra} -s {params.sites_abs} -f {params.fasta_abs} -d "$tmpdir" {input.bam} &> {log}
        generated_file=$(find "$tmpdir" -maxdepth 1 -name '*.somalier' -print -quit)

        if [ -f "$generated_file" ]; then
            mv "$generated_file" "{output.somalier}"
        else
            echo "Error: No somalier output file found in temp directory $tmpdir" >&2
            rm -rf "$tmpdir"
            exit 1
        fi

        # Clean up
        rm -rf "$tmpdir"
        """


rule somalier_trio_mqc:
    input:
        samples="qc/somalier_trio/somalier_relate.samples.tsv",
    output:
        mqc="qc/somalier_trio/somalier_samples_mqc.tsv",
    params:
        mqc_config=lambda wildcards: (
            os.path.abspath(config["somalier_trio_mqc"]["mqc_config"])
            if config.get("somalier_trio_mqc", {}).get("mqc_config")
            else ""
        ),
    log:
        "qc/somalier_trio_mqc/somalier_samples_mqc.log",
    benchmark:
        repeat(
            "qc/somalier_trio_mqc/somalier_samples_mqc.benchmark.tsv",
            config.get("somalier_trio_mqc", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_trio_mqc", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_trio_mqc", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_trio_mqc", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_trio_mqc", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_trio_mqc", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_trio_mqc", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_trio_mqc", {}).get("container", config["default_container"])
    message:
        "{rule}: creating custom input for somalier trio to MultiQC general stats"
    script:
        "../scripts/somalier_mqc_config.py"


rule somalier_trio_relate:
    input:
        samples=get_somalier_relate_samples,
        ped="qc/somalier_trio/somalier_all.ped",
        group="qc/somalier_trio/somalier.groups" if has_trio_samples(samples) else [],
    output:
        pairs="qc/somalier_trio/somalier_relate.pairs.tsv",
        samples="qc/somalier_trio/somalier_relate.samples.tsv",
        html="qc/somalier_trio/somalier_relate.html",
    params:
        extra=config.get("somalier_trio_relate", {}).get("extra", ""),
        outname=lambda wildcards, output: output.pairs.replace(".pairs.tsv", ""),
        group_flag=lambda wildcards, input: f"-g {input.group}" if input.group else "",
    log:
        "qc/somalier_trio_relate/somalier_relate.log",
    benchmark:
        repeat(
            "qc/somalier_trio_relate/somalier_relate.benchmark.tsv",
            config.get("somalier_trio_relate", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_trio_relate", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_trio_relate", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_trio_relate", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_trio_relate", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_trio_relate", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_trio_relate", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_trio_relate", {}).get("container", config["default_container"])
    message:
        "{rule}: Running somalier relate for trio analysis with --infer"
    shell:
        "somalier relate {params.extra} --infer --ped {input.ped} {params.group_flag} -o {params.outname} {input.samples} &> {log}"


rule somalier_trio_validate:
    input:
        pairs="qc/somalier_trio/somalier_relate.pairs.tsv",
        ped="qc/somalier_trio/somalier_all.ped",
    output:
        validation="qc/somalier_trio/trio_validation.txt",
    params:
        threshold=config.get("somalier_trio_validate", {}).get("threshold", 0.4),
    log:
        "qc/somalier_trio_validate/trio_validation.txt.log",
    benchmark:
        repeat(
            "qc/somalier_trio_validate/trio_validation.txt.benchmark.tsv",
            config.get("somalier_trio_validate", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_trio_validate", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_trio_validate", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_trio_validate", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_trio_validate", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_trio_validate", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_trio_validate", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_trio_validate", {}).get("container", config["default_container"])
    message:
        "{rule}: Validate parent-child relationships in trios (threshold={params.threshold})"
    script:
        "../scripts/somalier_trio_validate.py"
