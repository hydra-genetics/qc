__author__ = "Patrik Smeds"
__copyright__ = "Copyright 2021, Patrik Smeds"
__email__ = "patrik.smeds@scilifelab.uu.se"
__license__ = "GPL-3"


rule multiqc:
    input:
        files=lambda wildcards: set(
            [
                file.format(sample=sample, type=u.type, lane=u.lane, flowcell=u.flowcell, barcode=u.barcode, read=read, ext=ext)
                for file in config["multiqc"]["reports"][wildcards.report]["qc_files"]
                for sample in get_samples(samples)
                for u in units.loc[sample].dropna().itertuples()
                if u.type in config["multiqc"]["reports"][wildcards.report]["included_unit_types"]
                for read in ["fastq1", "fastq2"]
                for ext in config.get("picard_collect_multiple_metrics", {}).get("output_ext", [""])
            ]
        ),
    output:
        html=temp("qc/multiqc/multiqc_{report}.html"),
        data=temp(directory("qc/multiqc/multiqc_{report}_data")),
    params:
        extra=lambda wildcards: "{} {}".format(
            config.get("multiqc", {}).get("extra", ""),
            " -c {}".format(config["multiqc"]["reports"][wildcards.report]["config"])
            if "config" in config.get("multiqc", {}).get("reports", {}).get(wildcards.report, {})
            else "",
        ),
    log:
        "qc/multiqc/multiqc_{report}.html.log",
    benchmark:
        repeat("qc/multiqc/multiqc_{report}.html.benchmark.tsv", config.get("multiqc", {}).get("benchmark_repeats", 1))
    threads: config.get("multiqc", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("multiqc", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("multiqc", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("multiqc", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("multiqc", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("multiqc", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("multiqc", {}).get("container", config["default_container"])
    conda:
        "../envs/multiqc.yaml"
    message:
        "{rule}: generate combined qc report at {output.html}"
    shell:
        "FILENAME=`basename {output.html}` && "
        "DIRECTORY=`dirname {output.html}` && "
        "(multiqc "
        "{params.extra} "
        "--force "
        "-o $DIRECTORY "
        "-n $FILENAME "
        "{input}) "
        "&> {log}"
