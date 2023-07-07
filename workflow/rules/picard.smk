__author__ = "Jonas Almlöf, Martin Rippin"
__copyright__ = "Copyright 2021, Jonas Almlöf, Martin Rippin"
__email__ = "jonas.almlof@scilifelab.uu.se, martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule picard_collect_alignment_summary_metrics:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        bai="alignment/samtools_merge_bam/{sample}_{type}.bam.bai",
        ref=config.get("reference", {}).get("fasta", ""),
    output:
        metrics=temp("qc/picard_collect_alignment_summary_metrics/{sample}_{type}.alignment_summary_metrics.txt"),
    params:
        extra=config.get("picard_collect_alignment_summary_metrics", {}).get("extra", ""),
    log:
        "qc/picard_collect_alignment_summary_metrics/{sample}_{type}.alignment_summary_metrics.txt.log",
    benchmark:
        repeat(
            "qc/picard_collect_alignment_summary_metrics/{sample}_{type}.alignment_summary_metrics.txt.benchmark.tsv",
            config.get("picard_collect_alignment_summary_metrics", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("picard_collect_alignment_summary_metrics", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("picard_collect_alignment_summary_metrics", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("picard_collect_alignment_summary_metrics", {}).get(
            "mem_per_cpu", config["default_resources"]["mem_per_cpu"]
        ),
        partition=config.get("picard_collect_alignment_summary_metrics", {}).get(
            "partition", config["default_resources"]["partition"]
        ),
        threads=config.get("picard_collect_alignment_summary_metrics", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_collect_alignment_summary_metrics", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("picard_collect_alignment_summary_metrics", {}).get("container", config["default_container"])
    message:
        "{rule}: calculate alignment statistics using picard for {input.bam}"
    wrapper:
        "0.79.0/bio/picard/collectalignmentsummarymetrics"


rule picard_collect_duplication_metrics:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        bai="alignment/samtools_merge_bam/{sample}_{type}.bam.bai",
    output:
        metrics=temp("qc/picard_collect_duplication_metrics/{sample}_{type}.duplication_metrics.txt"),
    log:
        "qc/picard_collect_duplication_metrics/{sample}_{type}.duplication_metrics.txt.log",
    benchmark:
        repeat(
            "qc/picard_collect_duplication_metrics/{sample}_{type}.duplication_metrics.txt.benchmark.tsv",
            config.get("picard_collect_duplication_metrics", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("picard_collect_duplication_metrics", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("picard_collect_duplication_metrics", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("picard_collect_duplication_metrics", {}).get(
            "mem_per_cpu", config["default_resources"]["mem_per_cpu"]
        ),
        partition=config.get("picard_collect_duplication_metrics", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("picard_collect_duplication_metrics", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_collect_duplication_metrics", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("picard_collect_duplication_metrics", {}).get("container", config["default_container"])
    message:
        "{rule}: calculate duplication metrics using picard for {input.bam}"
    shell:
        "(picard CollectDuplicateMetrics "
        "INPUT={input.bam} "
        "M={output.metrics}) "
        "&> {log}"


rule picard_collect_gc_bias_metrics:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        bai="alignment/samtools_merge_bam/{sample}_{type}.bam.bai",
        ref=config.get("reference", {}).get("fasta", ""),
    output:
        chart=temp("qc/picard_collect_gc_bias_metrics/{sample}_{type}.gc_bias.pdf"),
        metrics=temp("qc/picard_collect_gc_bias_metrics/{sample}_{type}.gc_bias.detail_metrics"),
        summary=temp("qc/picard_collect_gc_bias_metrics/{sample}_{type}.gc_bias.summary_metrics"),
    params:
        extra=config.get("picard_collect_gc_bias_metrics", {}).get("extra", ""),
    log:
        "qc/picard_collect_gc_bias_metrics/{sample}_{type}.gc_bias.summary_metrics.log",
    benchmark:
        repeat(
            "qc/picard_collect_gc_bias_metrics/{sample}_{type}.gc_bias.summary_metrics.benchmark.tsv",
            config.get("picard_collect_gc_bias_metrics", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("picard_collect_gc_bias_metrics", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("picard_collect_gc_bias_metrics", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("picard_collect_gc_bias_metrics", {}).get(
            "mem_per_cpu", config["default_resources"]["mem_per_cpu"]
        ),
        partition=config.get("picard_collect_gc_bias_metrics", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("picard_collect_gc_bias_metrics", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_collect_gc_bias_metrics", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("picard_collect_gc_bias_metrics", {}).get("container", config["default_container"])
    message:
        "{rule}: calculate gc bias using picard for {input.bam}"
    wrapper:
        "0.80.2/bio/picard/collectgcbiasmetrics"


rule picard_collect_hs_metrics:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        bai="alignment/samtools_merge_bam/{sample}_{type}.bam.bai",
        bait_intervals=config.get("reference", {}).get("design_intervals", ""),
        reference=config.get("reference", {}).get("fasta", ""),
        target_intervals=config.get("reference", {}).get("design_intervals", ""),
    output:
        temp("qc/picard_collect_hs_metrics/{sample}_{type}.HsMetrics.txt"),
    params:
        extra=config.get("picard_collect_hs_metrics", {}).get("extra", "COVERAGE_CAP=5000"),
    log:
        "qc/picard_collect_hs_metrics/{sample}_{type}.HsMetrics.txt.log",
    benchmark:
        repeat(
            "qc/picard_collect_hs_metrics/{sample}_{type}.HsMetrics.txt.benchmark.tsv",
            config.get("picard_collect_hs_metrics", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("picard_collect_hs_metrics", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("picard_collect_hs_metrics", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("picard_collect_hs_metrics", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("picard_collect_hs_metrics", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("picard_collect_hs_metrics", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_collect_hs_metrics", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("picard_collect_hs_metrics", {}).get("container", config["default_container"])
    message:
        "{rule}: calculate hs metrics using picard for {input.bam}"
    wrapper:
        "0.79.0/bio/picard/collecthsmetrics"


rule picard_collect_insert_size_metrics:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
    output:
        pdf=temp("qc/picard_collect_insert_size_metrics/{sample}_{type}.insert_size_histogram.pdf"),
        txt=temp("qc/picard_collect_insert_size_metrics/{sample}_{type}.insert_size_metrics.txt"),
    params:
        extra=config.get("picard_collect_insert_size_metrics", {}).get("extra", ""),
    log:
        "qc/picard_collect_insert_size_metrics/{sample}_{type}.insert_size_metrics.txt.log",
    benchmark:
        repeat(
            "qc/picard_collect_insert_size_metrics/{sample}_{type}.insert_size_metrics.txt.benchmark.tsv",
            config.get("picard_collect_insert_size_metrics", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("picard_collect_insert_size_metrics", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("picard_collect_insert_size_metrics", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("picard_collect_insert_size_metrics", {}).get(
            "mem_per_cpu", config["default_resources"]["mem_per_cpu"]
        ),
        partition=config.get("picard_collect_insert_size_metrics", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("picard_collect_insert_size_metrics", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_collect_insert_size_metrics", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("picard_collect_insert_size_metrics", {}).get("container", config["default_container"])
    message:
        "{rule}: calculate insert size using picard for {input.bam}"
    wrapper:
        "0.79.0/bio/picard/collectinsertsizemetrics"


rule picard_collect_multiple_metrics:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        bai="alignment/samtools_merge_bam/{sample}_{type}.bam.bai",
        ref=config.get("reference", {}).get("fasta", ""),
    output:
        expand(
            "qc/picard_collect_multiple_metrics/{{sample}}_{{type}}.{ext}",
            ext=config.get("picard_collect_multiple_metrics", {}).get("output_ext", ""),
        ),
    params:
        extra=config.get("picard_collect_multiple_metrics", {}).get("extra", ""),
    log:
        "qc/picard_collect_multiple_metrics/{sample}_{type}.alignment_summary_metrics.log",
    benchmark:
        repeat(
            "qc/picard_collect_multiple_metrics/{sample}_{type}.alignment_summary_metrics.benchmark.tsv",
            config.get("picard_collect_multiple_metrics", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("picard_collect_multiple_metrics", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("picard_collect_multiple_metrics", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("picard_collect_multiple_metrics", {}).get(
            "mem_per_cpu", config["default_resources"]["mem_per_cpu"]
        ),
        partition=config.get("picard_collect_multiple_metrics", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("picard_collect_multiple_metrics", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_collect_multiple_metrics", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("picard_collect_multiple_metrics", {}).get("container", config["default_container"])
    message:
        "{rule}: calculate multiple metrics using picard for {input.bam}"
    wrapper:
        "0.80.2/bio/picard/collectmultiplemetrics"


rule picard_collect_wgs_metrics:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        bai="alignment/samtools_merge_bam/{sample}_{type}.bam.bai",
        ref=config.get("reference", {}).get("fasta", ""),
        interval=config.get("reference", {}).get("wgs_intervals", ""),
    output:
        metrics=temp("qc/picard_collect_wgs_metrics/{sample}_{type}.txt"),
    params:
        extra=config.get("picard_collect_wgs_metrics", {}).get("extra", ""),
    log:
        "qc/picard_collect_wgs_metrics/{sample}_{type}.txt.log",
    benchmark:
        repeat(
            "qc/picard_collect_wgs_metrics/{sample}_{type}.txt.benchmark.tsv",
            config.get("picard_collect_wgs_metrics", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("picard_collect_wgs_metrics", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("picard_collect_wgs_metrics", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("picard_collect_wgs_metrics", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("picard_collect_wgs_metrics", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("picard_collect_wgs_metrics", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_collect_wgs_metrics", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("picard_collect_wgs_metrics", {}).get("container", config["default_container"])
    message:
        "{rule}: collect wgs metrics using picard for {input.bam}"
    shell:
        "(picard CollectWgsMetrics "
        "I={input.bam} "
        "O={output.metrics} "
        "R={input.ref} "
        "INTERVALS={input.interval} "
        "{params.extra}) "
        "&> {log}"
