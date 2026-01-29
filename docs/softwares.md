# Softwares used in the biomarker module

---

## [bcftools_stats](https://samtools.github.io/bcftools/bcftools.html#stats)
Bcftools stats parses VCF or BCF and produces text with summary statistics on the
variants. 

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__bcftools__bcftools_stats#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__bcftools__bcftools_stats#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__bcftools_stats#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__bcftools_stats#

## [cramino](https://github.com/wdecoster/cramino)
A tool for quick quality assessment of cram and bam files, intended for long read sequencing.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__cramino__cramino#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__cramino__cramino#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__cramino#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__cramino#

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

## [multiqc_longread](url_to_tool)
Collects QC data from external sources and compiles a comprehensive html QC-report.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__multiqc__multiqc_longread#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__multiqc__multiqc_longread#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__multiqc_longread#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__multiqc_longread#

---

## [nanoplot](https://github.com/wdecoster/NanoPlot)
Plotting tool for long read sequencing data and alignments.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__nanoplot__nanoplot#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__nanoplot__nanoplot#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__nanoplot#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__nanoplot#

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

## [sequali](https://sequali.readthedocs.io/en/latest/)
Sequali calculates and visulises quality metrics for FASTQ and uBAM files. Similar to fastqc but with addional plots for ONT when uBAM input used.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__sequali__sequali#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__sequali__sequali#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__sequali#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__sequali#


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

--

## somalier

## [somalier_combine_fam](https://github.com/brentp/somalier)
Combines individual tumor and normal pedigree files into a single master .fam file for batch analysis.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__somalier__somalier_combine_fam#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__somalier__somalier_combine_fam#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__somalier_combine_fam#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__somalier_combine_fam#

--

## [somalier_create_groupfile](https://github.com/brentp/somalier)
Creates group file mapping samples to their types (tumor/normal) for somalier's ancestry and QC analysis.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__somalier__somalier_create_groupfile#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__somalier__somalier_create_groupfile#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__somalier_create_groupfile#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__somalier_create_groupfile#

--

## [somalier_create_ped](https://github.com/brentp/somalier)
Creates pedigree (.fam) files from sample sheet for all samples. Converts sex information (M→1, F/K→2, other→0) for somalier compatibility. Can handle trio relationships if `trio`, `father`, and `mother` columns are present in `samples.tsv`.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__somalier__somalier_create_ped#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__somalier__somalier_create_ped#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__somalier_create_ped#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__somalier_create_ped#

--

## [somalier_mqc](https://github.com/brentp/somalier)
Formats somalier output files for MultiQC integration, adding custom configuration to display sample relatedness and QC metrics.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__somalier__somalier_mqc#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__somalier__somalier_mqc#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__somalier_mqc#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__somalier_mqc#

--

## [somalier_extract](https://github.com/brentp/somalier)
Extracts genotype information from BAM/CRAM files at informative sites for fast sample QC, relatedness checks, and sex inference.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__somalier__somalier_extract#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__somalier__somalier_extract#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__somalier_extract#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__somalier_extract#

--

## [somalier_relate](https://github.com/brentp/somalier)
Performs relatedness and ancestry inference across all samples, generating pairwise statistics and interactive HTML reports.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__somalier__somalier_relate#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__somalier__somalier_relate#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__somalier_relate#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__somalier_relate#

--

## [somalier_tn_test](https://github.com/brentp/somalier)
Validates that T/N pairs have high relatedness scores. Checks expected pairs from group file and reports mismatch diagnostics.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__somalier__somalier_tn_test#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__somalier__somalier_tn_test#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__somalier_tn_test#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__somalier_tn_test#
