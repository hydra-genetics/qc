__author__ = "Nina Hollfelder, Julia Höglund"
__copyright__ = "Copyright 2021, Nina Hollfelder, Julia Höglund"
__email__ = "nina.hollfelder@scilifelab.uu.se, julia.hoglund@scilifelab.uu.se"
__license__ = "GPL-3"

import os


rule somalier_create_ped_t:
    input:
        samples=config["samples"],
    output:
        fam=temp("qc/somalier_create_ped_t/{sample}_T.fam"),
    params:
        sample_type="T",
        extra=config.get("somalier_create_ped_t", {}).get("extra", ""),
    log:
        "qc/somalier_create_ped_t/{sample}_T.fam.log",
    benchmark:
        repeat(
            "qc/somalier_create_ped_t/{sample}_T.fam.benchmark.tsv",
            config.get("somalier_create_ped_t", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_create_ped_t", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_create_ped_t", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_create_ped_t", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_create_ped_t", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_create_ped_t", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_create_ped_t", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_create_ped_t", {}).get("container", config["default_container"])
    message:
        "{rule}: Create fam file for {wildcards.sample}_T"
    script:
        "../scripts/somalier_create_ped.py"


rule somalier_create_ped_n:
    input:
        samples=config["samples"],
    output:
        fam=temp("qc/somalier_create_ped_n/{sample}_N.fam"),
    params:
        sample_type="N",
        extra=config.get("somalier_create_ped_n", {}).get("extra", ""),
    log:
        "qc/somalier_create_ped_n/{sample}_N.fam.log",
    benchmark:
        repeat(
            "qc/somalier_create_ped_n/{sample}_N.fam.benchmark.tsv",
            config.get("somalier_create_ped_n", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("somalier_create_ped_n", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("somalier_create_ped_n", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("somalier_create_ped_n", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("somalier_create_ped_n", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("somalier_create_ped_n", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("somalier_create_ped_n", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_create_ped_n", {}).get("container", config["default_container"])
    message:
        "{rule}: Create fam file for {wildcards.sample}_N"
    script:
        "../scripts/somalier_create_ped.py"


rule somalier_combine_fam:
    input:
        fam=[
            "qc/somalier_create_ped_%s/%s_%s.fam" % (t.lower(), sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
            if t in ["N", "T"]
        ],
    output:
        ped=temp("qc/somalier/somalier_all.ped"),
    params:
        extra=config.get("somalier_combine_fam", {}).get("extra", ""),
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
    params:
        extra=config.get("somalier_create_groupfile", {}).get("extra", ""),
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
        done > {output}
        """


rule somalier_relate:
    input:
        samples=[
            "qc/somalier_extract/%s_%s.somalier" % (sample, t)
            for sample in get_samples(samples)
            for t in get_unit_types(units, sample)
            if t in ["N", "T"]
        ],
        ped="qc/somalier/somalier_all.ped",
        group="qc/somalier/somalier.groups",
    output:
        pairs="qc/somalier/somalier_relate.pairs.tsv",
        samples="qc/somalier/somalier_relate.samples.tsv",
        html="qc/somalier/somalier_relate.html",
    params:
        extra=config.get("somalier_relate", {}).get("extra", ""),
        outname=lambda wildcards, output: output.pairs.replace(".pairs.tsv", ""),
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
        "{rule}: Running somalier relate for inferring sex and checking T/N"
    shell:
        "somalier relate {params.extra} --ped {input.ped} -g {input.group} -o {params.outname} {input.samples}"


rule somalier_mqc:
    input:
        samples="qc/somalier/somalier_relate.samples.tsv",
    output:
        mqc="qc/somalier/somalier_samples_mqc.tsv",
    params:
        mqc_config=config.get("somalier_mqc", {}).get("mqc_config", ""),
        extra=config.get("somalier_mqc", {}).get("extra", ""),
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


rule somalier_extract:
    input:
        sites=config.get("somalier_extract", {}).get("sites", ""),
        fasta=config.get("reference", {}).get("fasta", ""),
        fai=config.get("reference", {}).get("fasta", "") + ".fai",
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        bai="alignment/samtools_merge_bam/{sample}_{type}.bam.bai",
    output:
        somalier=temp("qc/somalier_extract/{sample}_{type}.somalier"),
    params:
        extra=config.get("somalier_extract", {}).get("extra", ""),
        fasta_abs=lambda wildcards, input: os.path.abspath(input.fasta),
        sites_abs=lambda wildcards, input: os.path.abspath(input.sites),
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
        TEMP_DIR=$(mktemp -d "$(dirname {output.somalier})/somalier_tmp.XXXXXX")
        trap "rm -rf $TEMP_DIR" EXIT
        somalier extract {params.extra} -s {params.sites_abs} -f {params.fasta_abs} -d $TEMP_DIR {input.bam} 2>&1 | tee {log}
        generated_file=$(ls $TEMP_DIR/*.somalier 2>/dev/null | head -n1)
        mv "$generated_file" {output.somalier}
        """


rule somalier_tn_test:
    input:
        samples="qc/somalier/somalier_relate.samples.tsv",
    output:
        tncheck="qc/somalier/TNmismatch.txt",
    params:
        extra=config.get("somalier_tn_test", {}).get("extra", ""),
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
        "{rule}: extract matched T/N samples from somalier that are not from the same individual"
    shell:
        """
        awk -F"[\t_]" '$1==$3 && $5<=0.2 {{print $1}}' {input.samples} > {output.tncheck} 2> {log}
        """
