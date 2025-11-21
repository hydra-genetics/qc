#!/usr/bin/env python
# coding: utf-8


import sys

sample_type = snakemake.params["sample_type"]
input_file = snakemake.input[0]


with open(input_file, "r") as samplesheet:
    header_line = samplesheet.readline().strip().split("\t")
    for lline in samplesheet:
        line = lline.strip().split("\t")
        if line[header_line.index("sex")] == "M":
            sex = "1"
        elif line[header_line.index("sex")] == "K":
            sex = "2"
        else:
            sex = "0"
        sample_id = line[header_line.index("sample")]
        output_path = snakemake.output["fam"]
        with open(output_path, "w+") as pedfile:
            pedfile.write(
                "\t".join([sample_id, f"{sample_id}_{sample_type}", "0", "0", sex, "-9"]) + "\n"
            )
