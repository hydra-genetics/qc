__author__ = "Padraic Corcoran"
__copyright__ = "Copyright 2022, Padraic Corcoran"
__email__ = "padraic.corcoran@scilifelab.uu.se"
__license__ = "GPL-3"


rule peddy:
    input:
        vcf="qc/peddy/all.vcf.gz",
        ped="qc/peddy/all.ped",
    output:
        ped=temp("qc/peddy/peddy.peddy.ped"),
        ped_check=temp("qc/peddy/peddy.ped_check.csv"),
        sex_check=temp("qc/peddy/peddy.sex_check.csv"),
        het_check=temp("qc/peddy/peddy.het_check.csv"),
        ped_html=temp("qc/peddy/peddy.html"),
        ped_vs_html=temp("qc/peddy/peddy.vs.html"),
        pca=temp("qc/peddy/peddy.background_pca.json"),
    params:
        prefix=lambda wildcards, input: os.path.split(input.ped)[0],
        extra=config.get("peddy", {}).get("extra", ""),
    log:
        "qc/peddy/peddy.output.log",
    benchmark:
        repeat(
            "qc/peddy/all.peddy.benchmark.tsv",
            config.get("peddy", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("peddy", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("peddy", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("peddy", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("peddy", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("peddy", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("peddy", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("peddy", {}).get("container", config["default_container"])
    conda:
        "../envs/peddy.yaml"
    message:
        "{rule}: Run peddy analysis to check relatedeness and sex of samples in \
        {input.ped} and using the genotypes in {input.vcf}"
    shell:
        "python -m peddy "
        "--procs {threads} "
        "{params.extra}"
        "--prefix {params.prefix}/peddy "
        "{input.vcf} {input.ped} &> {log}"
