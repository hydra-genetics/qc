# :snake: hydra-genetics/qc

#### Snakemake module containing steps for quality control of sequencing data

![Compatibility](https://github.com/hydra-genetics/qc/actions/workflows/compatibility.yaml/badge.svg?branch=develop)
![Lint](https://github.com/hydra-genetics/qc/actions/workflows/lint.yaml/badge.svg?branch=develop)
![Snakefmt](https://github.com/hydra-genetics/qc/actions/workflows/snakefmt.yaml/badge.svg?branch=develop)
![snakemake dry run](https://github.com/hydra-genetics/qc/actions/workflows/snakemake-dry-run.yaml/badge.svg?branch=develop)
![integration test](https://github.com/hydra-genetics/qc/actions/workflows/integration.yaml/badge.svg?branch=develop)

[![License: GPL-3](https://img.shields.io/badge/License-GPL3-yellow.svg)](https://opensource.org/licenses/gpl-3.0.html)

## :speech_balloon: Introduction

The module contains rules to run different quality control tools. Fastqc is checking the raw `.fastq` files while
mosdepth, samtools stats and picard's collect metrics generates reports on the resulting `.bam` files. Most
output can be compiled to one `.html` report using multiqc.

## :heavy_exclamation_mark: Dependencies

In order to use this module, the following dependencies are required:

[![hydra-genetics](https://img.shields.io/badge/hydragenetics-v0.9.0-blue)](https://github.com/hydra-genetics/)
[![pandas](https://img.shields.io/badge/pandas-1.3.1-blue)](https://pandas.pydata.org/)
[![python](https://img.shields.io/badge/python-3.8-blue)](https://www.python.org/)
[![snakemake](https://img.shields.io/badge/snakemake-6.10.0-blue)](https://snakemake.readthedocs.io/en/stable/)
[![singularity](https://img.shields.io/badge/singularity-3.0.0-blue)](https://sylabs.io/docs/)

## :school_satchel: Preparations

### Sample and unit data

Input data should be added to [`samples.tsv`](https://github.com/hydra-genetics/prealignment/blob/develop/config/samples.tsv)
and [`units.tsv`](https://github.com/hydra-genetics/prealignment/blob/develop/config/units.tsv).
The following information need to be added to these files:

| Column Id | Description |
| --- | --- |
| **`samples.tsv`** |
| sample | unique sample/patient id, one per row |
| tumor_content | ratio of tumor cells to total cells |
| **`units.tsv`** |
| sample | same sample/patient id as in `samples.tsv` |
| type | data type identifier (one letter), can be one of **T**umor, **N**ormal, **R**NA |
| platform | type of sequencing platform, e.g. `NovaSeq` |
| machine | specific machine id, e.g. NovaSeq instruments have `@Axxxxx` |
| flowcell | identifer of flowcell used |
| lane | flowcell lane number |
| barcode | sequence library barcode/index, connect forward and reverse indices by `+`, e.g. `ATGC+ATGC` |
| fastq1/2 | absolute path to forward and reverse reads |
| adapter | adapter sequences to be trimmed, separated by comma |

### Reference data

A reference `.fasta`-file should be specified in `config.yaml` in the section `reference` and `fasta`. Picard
requires also interval files for WGS, `wgs_intervals`, and for HS metrics, `design_intervals`. Mosdepth and
samtools require a `.bed` file with specified regions to be analysed.

## :white_check_mark: Testing

The workflow repository contains a small test dataset `.tests/integration` which can be run like so:

```bash
cd .tests/integration
snakemake -s ../../Snakefile -j1 --use-singularity
```

## :rocket: Usage

To use this module in your workflow, follow the description in the
[snakemake docs](https://snakemake.readthedocs.io/en/stable/snakefiles/modularization.html#modules).
Add the module to your `Snakefile` like so:

```bash
module qc:
    snakefile:
        github(
            "hydra-genetics/qc",
            path="workflow/Snakefile",
            tag="v0.1.0",
        )
    config:
        config


use rule * from qc as qc_*
```

### Compatibility

Latest:
 - alignment:v0.1.0

 See [COMPATIBLITY.md](../master/COMPATIBLITY.md) file for a complete list of module compatibility.

### Output files

The following output files should be targeted via another rule:

| File | Description |
|---|---|
| `qc/multiqc/multiqc.html` | `.html` report from multiqc |
| `qc/multiqc/multiqc_data` | directory holding multiqc data |

## :judge: Rule Graph

![rule_graph](images/rulegraph.svg)
