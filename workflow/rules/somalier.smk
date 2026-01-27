__author__ = "Nina Hollfelder, Julia Höglund"
__copyright__ = "Copyright 2021, Nina Hollfelder, Julia Höglund"
__email__ = "nina.hollfelder@scilifelab.uu.se, julia.hoglund@scilifelab.uu.se"
__license__ = "GPL-3"


import os


rule somalier_combine_fam:
    input:
        fam=get_fam_inputs,
    output:
        ped=temp("qc/somalier/somalier_all.ped") if needs_ped_file(samples, units, config) else temp(touch("qc/somalier/somalier_all.ped.skip")),
    log:
        "qc/somalier_combine_fam/somalier_all.ped.log",
    benchmark:
        repeat(
            "qc/somalier_combine_fam/somalier_all.ped.benchmark.tsv",
            config.get("somalier_combine_fam", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_combine_fam", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_combine_fam", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_combine_fam", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_combine_fam", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_combine_fam", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_combine_fam", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_combine_fam", {}).get("container", config["default_container"])
    message:
        "{rule}: creates combined somalier_all.ped for sex check"
    shell:
        """
        cat {input.fam} > {output.ped}
        """


rule somalier_create_groupfile:
    input:
        samples=config["samples"],
        units=config["units"],
    output:
        groups=temp("qc/somalier/somalier.groups"),
    log:
        "qc/somalier_create_groupfile/somalier.groups.log",
    benchmark:
        repeat(
            "qc/somalier_create_groupfile/somalier.groups.benchmark.tsv",
            config.get("somalier_create_groupfile", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_create_groupfile", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_create_groupfile", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_create_groupfile", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_create_groupfile", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_create_groupfile", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_create_groupfile", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_create_groupfile", {}).get("container", config["default_container"])
    message:
        "{rule}: Create group file for somalier input"
    shell:
        """
        for i in $( cut -f1 {input.samples} | tail -n+2 )
        do
        var=$(grep $i {input.units} | cut -f2 | uniq | tr "\\n" "," | sed "s/,$/\\n/")
        if [ $var == "N,T" ] || [ $var == "T,N" ]
        then echo ${{i}}_N,${{i}}_T
        fi
        done > {output.groups}
        """


rule somalier_create_ped:
    input:
        samples=config["samples"],
    output:
        fam=temp("qc/somalier_create_ped/{sample}_{type}.fam"),
    params:
        sample_type=lambda w: w.type,
    log:
        "qc/somalier_create_ped/{sample}_{type}.fam.log",
    benchmark:
        repeat(
            "qc/somalier_create_ped/{sample}_{type}.fam.benchmark.tsv",
            config.get("somalier_create_ped", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_create_ped", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_create_ped", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_create_ped", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_create_ped", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_create_ped", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_create_ped", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_create_ped", {}).get("container", config["default_container"])
    message:
        "{rule}: Create fam file for {wildcards.sample}_{wildcards.type}"
    script:
        "../scripts/somalier_create_ped.py"


rule somalier_extract:
    input:
        sites=config.get("somalier_extract", {}).get("sites", ""),
        fasta=config.get("reference", {}).get("fasta", ""),
        fai=config.get("reference", {}).get("fasta", "") + ".fai",
        bam=lambda wildcards: get_input_aligned_bam(wildcards, config)[0],
        bai=lambda wildcards: get_input_aligned_bam(wildcards, config)[1],
    output:
        somalier=temp("qc/somalier_extract/{sample}_{type}.somalier"),
    params:
        extra=config.get("somalier_extract", {}).get("extra", ""),
        fasta_abs=lambda wildcards, input: os.path.abspath(input.fasta),
        sites_abs=lambda wildcards, input: os.path.abspath(input.sites),
        sample_name=lambda wildcards: f"{wildcards.sample}_{wildcards.type}",
    log:
        "qc/somalier_extract/{sample}_{type}.somalier.log",
    benchmark:
        repeat(
            "qc/somalier_extract/{sample}_{type}.somalier.benchmark.tsv",
            config.get("somalier_extract", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_extract", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_extract", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_extract", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_extract", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_extract", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_extract", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_extract", {}).get("container", config["default_container"])
    message:
        "{rule}: extract sites for somalier in sample {wildcards.sample}_{wildcards.type}.bam"
    shell:
        """
        # Create a temp directory for this specific job to avoid race conditions and handle renaming
        tmpdir=$(mktemp -d -p $(dirname {output.somalier}))
        somalier extract {params.extra} -s {params.sites_abs} -f {params.fasta_abs} -d $tmpdir {input.bam} 2> {log}
        generated_file=$(ls $tmpdir/*.somalier | head -n1)

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


rule somalier_mqc:
    input:
        samples="qc/somalier/somalier_relate.samples.tsv",
    output:
        mqc="qc/somalier/somalier_samples_mqc.tsv",
    params:
        mqc_config=lambda wildcards: os.path.abspath(config.get("somalier_mqc", {}).get("mqc_config", "")),
    log:
        "qc/somalier_mqc/somalier_samples_mqc.log",
    benchmark:
        repeat(
            "qc/somalier_mqc/somalier_samples_mqc.benchmark.tsv",
            config.get("somalier_mqc", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_mqc", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_mqc", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_mqc", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_mqc", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_mqc", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_mqc", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_mqc", {}).get("container", config["default_container"])
    message:
        "{rule}: creating custom input for somalier to MultiQC general stats"
    script:
        "../scripts/somalier_mqc_config.py"


rule somalier_relate:
    input:
        samples=get_somalier_relate_samples,
        ped="qc/somalier/somalier_all.ped",
        group="qc/somalier/somalier.groups" if has_tn_pairs(samples, units) else [],
    output:
        pairs="qc/somalier/somalier_relate.pairs.tsv",
        samples="qc/somalier/somalier_relate.samples.tsv",
        html="qc/somalier/somalier_relate.html",
    params:
        extra=config.get("somalier_relate", {}).get("extra", ""),
        outname=lambda wildcards, output: output.pairs.replace(".pairs.tsv", ""),
        group_flag=lambda wildcards, input: f"-g {input.group}" if input.group else "",
    log:
        "qc/somalier_relate/somalier_relate.log",
    benchmark:
        repeat(
            "qc/somalier_relate/somalier_relate.benchmark.tsv",
            config.get("somalier_relate", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_relate", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_relate", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_relate", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_relate", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_relate", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_relate", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_relate", {}).get("container", config["default_container"])
    message:
        "{rule}: Running somalier relate"
    shell:
        "somalier relate {params.extra} --ped {input.ped} {params.group_flag} -o {params.outname} {input.samples} 2> {log}"


rule somalier_tn_test:
    input:
        pairs="qc/somalier/somalier_relate.pairs.tsv",
        group="qc/somalier/somalier.groups" if has_tn_pairs(samples, units) else [],
    output:
        tncheck="qc/somalier/TNmismatch.txt",
    params:
        threshold=config.get("somalier_tn_test", {}).get("threshold", 0.8),
    log:
        "qc/somalier_tn_test/TNmismatch.txt.log",
    benchmark:
        repeat(
            "qc/somalier_tn_test/TNmismatch.txt.benchmark.tsv",
            config.get("somalier_tn_test", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_tn_test", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_tn_test", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_tn_test", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_tn_test", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_tn_test", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_tn_test", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_tn_test", {}).get("container", config["default_container"])
    message:
        "{rule}: Validate T/N pairs have high relatedness (threshold={params.threshold})"
    script:
        "../scripts/somalier_tn_validate.py"
