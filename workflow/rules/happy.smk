__author__ = "Magdalena Z"
__copyright__ = "Copyright 2024, Uppsala Universitet"
__email__ = "magdalena.z@scilifelab.uu.se"
__license__ = "GPL-3"


rule happy:
    input:
        truth="reference/happy.truth.vcf",
        query="reference/happy.test.vcf",
        truth_regions="reference/happy.bed",
        strats="stratifications.tsv",  # optional, from https://github.com/genome-in-a-bottle/genome-stratifications
        genome=config.get("reference", {}).get("fasta", ""),
        genome_index=config.get("reference", {}).get("fai", ""),
    output:
        multiext(
            "qc/happy/{sample}_{type}.",
            "results",
            ".runinfo.json",
            ".vcf.gz",
            ".summary.csv",
            ".extended.csv",
            ".metrics.json.gz",
            ".roc.all.csv.gz",
            ".roc.Locations.INDEL.csv.gz",
            ".roc.Locations.INDEL.PASS.csv.gz",
            ".roc.Locations.SNP.csv.gz",
            ".roc.tsv",
        ),
        dummy="qc/happy/{sample}_{type}.vcf.gz",
    params:
        engine="vcfeval",
        prefix=lambda wc, input, output: output[0].split(".")[0],
        ## parameters such as -L to left-align variants
        extra="--verbose",
    log:
        "qc/happy/{sample}_{type}.happy.log",
    container:
        config.get("happy", {}).get("container", config["default_container"])
    message:
        "{rule}: Happy is for benchmarking variant accuracy of {input.query} compared to {input.truth}"
    threads: config.get("happy", {}).get("threads", config["default_resources"]["threads"])
    wrapper:
        "v3.13.7/bio/hap.py/hap.py"
