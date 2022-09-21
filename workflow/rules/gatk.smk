__author__ = "Jonas Almlöf"
__copyright__ = "Copyright 2022, Jonas Almlöf"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


rule gatk_get_pileup_summaries:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        sites=config.get("gatk_get_pileup_summaries", {}).get("sites", ""),
        variants=config.get("gatk_get_pileup_summaries", {}).get("variants", ""),
    output:
        pileups_table=temp("qc/gatk_get_pileup_summaries/{sample}_{type}.pileups.table"),
    params:
        extra=config.get("gatk_get_pileup_summaries", {}).get("extra", ""),
    log:
        "qc/gatk_get_pileup_summaries/{sample}_{type}.pileups.table.log",
    benchmark:
        repeat(
            "qc/gatk_get_pileup_summaries/{sample}_{type}.pileups.table.benchmark.tsv",
            config.get("gatk_get_pileup_summaries", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("gatk_get_pileup_summaries", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("gatk_get_pileup_summaries", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("gatk_get_pileup_summaries", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("gatk_get_pileup_summaries", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("gatk_get_pileup_summaries", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("gatk_get_pileup_summaries", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("gatk_get_pileup_summaries", {}).get("container", config["default_container"])
    conda:
        "../envs/gatk.yaml"
    message:
        "{rule}: generate pileup table fo contamination estimation using {input.bam}"
    shell:
        "gatk GetPileupSummaries "
        "-I {input.bam} "
        "-V {input.sites} "
        "-L {input.variants} "
        "-O {output.pileups_table}"


rule gatk_calculate_contamination:
    input:
        pileups_table="qc/gatk_get_pileup_summaries/{sample}_{type}.pileups.table",
    output:
        contamination_table=temp("qc/gatk_calculate_contamination/{sample}_{type}.contamination.table_mqc.tsv"),
    params:
        extra=config.get("gatk_calculate_contamination", {}).get("extra", ""),
    log:
        "qc/gatk_calculate_contamination/{sample}_{type}.contamination.table_mqc.tsv.log",
    benchmark:
        repeat(
            "qc/gatk_calculate_contamination/{sample}_{type}.contamination.table_mqc.tsv.benchmark.tsv",
            config.get("gatk_calculate_contamination", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("gatk_calculate_contamination", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("gatk_calculate_contamination", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("gatk_calculate_contamination", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("gatk_calculate_contamination", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("gatk_calculate_contamination", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("gatk_calculate_contamination", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("gatk_calculate_contamination", {}).get("container", config["default_container"])
    conda:
        "../envs/gatk.yaml"
    message:
        "{rule}: generate contamination table {output.contamination_table}"
    shell:
        "gatk CalculateContamination "
        "-I {input.pileups_table} "
        "-O {output.contamination_table}"
