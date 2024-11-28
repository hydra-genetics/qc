__author__ = "Magdalena Zarowiecki"
__copyright__ = "Copyright 2024, Magdalena Zarowiecki"
__email__ = "name@email.com"
__license__ = "GPL-3"


rule longqc_sampleqc:
    input:
        fastq="data/sample.fastq",
    output:
        dir=directory("qc/sample_qc/"),
    params:
        extra="--min_length 1000 --max_length 15000",  # example of additional parameters
    log:
        "qc/longqc_sampleqc/{sample}_{type}.sample_qc.log",
    benchmark:
        repeat(
            "qc/longqc_sampleqc/{sample}_{type}.output.benchmark.tsv",
            config.get("longqc_sampleqc", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("longqc_sampleqc", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("longqc_sampleqc", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("longqc_sampleqc", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("longqc_sampleqc", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("longqc_sampleqc", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("longqc_sampleqc", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("longqc_sampleqc", {}).get("container", config["default_container"])
    message:
        "longqc_sampleqc: run longqc QC statistics and generate plots from  {input.fastq}"
    wrapper:
        "file://path/to/your/wrappers/longqc/wrapper.py"
