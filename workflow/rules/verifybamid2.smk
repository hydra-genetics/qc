__author__ = "Padraic Corcoran and Magdalena"
__copyright__ = "Copyright 2023, Padraic Corcoran and Magdalena"
__email__ = "padraic.corcoran@scilifelab.uu.se"
__license__ = "GPL-3"


rule verifybamid2:
    input:
        bam="alignment/samtools_merge_bam/{sample}_{type}.bam",
        ref=config.get("reference", {}).get("fasta", ""),
        svd_mu=config.get("verifybamid2", {}).get("svd_mu", ""),
    output:
        selfsm=temp("qc/verifybamid2/{sample}_{type}.selfSM"),
        ancestry=temp("qc/verifybamid2/{sample}_{type}.ancestry"),
    params:
        extra=config.get("verifybamid2", {}).get("extra", ""),
    log:
        "qc/verifybamid2/{sample}_{type}.selfsm.log",
    benchmark:
        repeat("qc/verifybamid2/{sample}_{type}.output.benchmark.tsv", config.get("verifybamid2", {}).get("benchmark_repeats", 1))
    threads: config.get("verifybamid2", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("verifybamid2", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("verifybamid2", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("verifybamid2", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("verifybamid2", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("verifybamid2", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("verifybamid2", {}).get("container", config["default_container"])
    message:
        "{rule}: estimate contamination from  {input.bam}"
    wrapper:
        "v2.6.0-35-g755343f/bio/verifybamid/verifybamid2"
