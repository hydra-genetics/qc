# Softwares used in the biomarker module

## [fastqc](https://github.com/s-andrews/FastQC)
Generate QC data from short read fastq files. Can be used to located problems with sequencing runs.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__fastqc__fastqc#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__fastqc__fastqc#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__fastqc#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__fastqc#

---

## [gatk_calculate_contamination](https://gatk.broadinstitute.org/hc/en-us/articles/360036888972-CalculateContamination)
Based on pileups from gatk_get_pileup_summaries calculates sample contamination.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__gatk__gatk_calculate_contamination#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__gatk__gatk_calculate_contamination#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__gatk_calculate_contamination#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__gatk_calculate_contamination#

---

## [gatk_get_pileup_summaries](https://gatk.broadinstitute.org/hc/en-us/articles/360037593451-GetPileupSummaries)
Calculate coverage in specified regions that is used by gatk_calculate_contamination to find sample contamination within a sequencing run.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__gatk__gatk_get_pileup_summaries#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__gatk__gatk_get_pileup_summaries#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__gatk_get_pileup_summaries#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__gatk_get_pileup_summaries#

---

## [happy](https://github.com/Illumina/hap.py)
To compare a VCF against a gold standard dataset. 

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__happy__happy#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__happy__happy#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__happy#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__happy#

---

## [longqc_sampleqc](https://github.com/yfukasawa/LongQC)
Introduction to longqc_sampleqc

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__longqc__longqc_sampleqc#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__longqc__longqc_sampleqc#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__longqc_sampleqc#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__longqc_sampleqc#

---

## [mosdepth](https://github.com/brentp/mosdepth)
Fast calculations of coverage.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__mosdepth__mosdepth#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__mosdepth__mosdepth#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__mosdepth#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__mosdepth#

---

## [mosdepth_bed](https://github.com/brentp/mosdepth)
Fast calculations of coverage with additional per base coverage information.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__mosdepth__mosdepth_bed#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__mosdepth__mosdepth_bed#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__mosdepth_bed#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__mosdepth_bed#

---

## [multiqc](https://github.com/ewels/MultiQC)
Collects QC data from external sources and compiles a comprehensive html QC-report.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__multiqc__multiqc#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__multiqc__multiqc#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__multiqc#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__multiqc#

---

## [peddy](http://www.htslib.org/doc/samtools-stats.html)
Relatedness and sex checks performed on a jointly called germline vcf (eg. glnexus).

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__peddy__peddy#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__peddy__peddy#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__peddy#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__peddy#

---

## [picard_collect_alignment_summary_metrics](https://broadinstitute.github.io/picard/)
Collects alignment statistics used by MultiQC.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__picard__picard_collect_alignment_summary_metrics#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__picard__picard_collect_alignment_summary_metrics#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__picard_collect_alignment_summary_metrics#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__picard_collect_alignment_summary_metrics#

---

## [picard_collect_duplication_metrics](https://broadinstitute.github.io/picard/)
Collects read duplication statistics used by MultiQC.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__picard__picard_collect_duplication_metrics#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__picard__picard_collect_duplication_metrics#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__picard_collect_duplication_metrics#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__picard_collect_duplication_metrics#

---

## [picard_collect_gc_bias_metrics](https://broadinstitute.github.io/picard/)
Collects gc bias statistics used by MultiQC.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__picard__picard_collect_gc_bias_metrics#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__picard__picard_collect_gc_bias_metrics#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__picard_collect_gc_bias_metrics#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__picard_collect_gc_bias_metrics#

---

## [picard_collect_hs_metrics](https://broadinstitute.github.io/picard/)
Collects panel statistics used by MultiQC.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__picard__picard_collect_hs_metrics#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__picard__picard_collect_hs_metrics#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__picard_collect_hs_metrics#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__picard_collect_hs_metrics#

---

## [picard_collect_insert_size_metrics](https://broadinstitute.github.io/picard/)
Collects insert size statistics used by MultiQC.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__picard__picard_collect_insert_size_metrics#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__picard__picard_collect_insert_size_metrics#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__picard_collect_insert_size_metrics#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__picard_collect_insert_size_metrics#

---

## [picard_collect_multiple_metrics](https://broadinstitute.github.io/picard/)
Collects multiple statistics st once that can be used by MultiQC.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__picard__picard_collect_multiple_metrics#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__picard__picard_collect_multiple_metrics#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__picard_collect_multiple_metrics#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__picard_collect_multiple_metrics#

---
 
## [verifybamid2](https://github.com/Griffan/VerifyBamID)
verifybamid2 estimates contamination in samples by simultaneously estimating genetic background and contamination using population allele frequencies. The output is parsed and displayed by the MultiQC rapport.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__verifybamid2__verifybamid2#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__verifybamid2__verifybamid2#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__verifybamid2#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__verifybamid2#


