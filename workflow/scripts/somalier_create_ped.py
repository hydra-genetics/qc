#!/usr/bin/env python
# coding: utf-8


import sys

sample_type = snakemake.params["sample_type"]
input_file = snakemake.input[0]
target_sample = snakemake.wildcards.sample

# Flexible sex mapping
SEX_MAPPING = {
    "M": "1", "Male": "1", "Man": "1", "1": "1",
    "F": "2", "Female": "2", "K": "2", "Kvinna": "2", "2": "2",
    "O": "0", "Okänd": "0", "U": "0", "Unknown": "0", "0": "0"
}

with open(input_file, "r") as samplesheet:
    header_line = samplesheet.readline().strip().split("\t")
    header_line = [h.strip('"') for h in header_line]

    try:
        sex_idx = header_line.index("sex")
        sample_idx = header_line.index("sample")
    except ValueError as e:
        sys.exit(f"Error: Missing required column in samplesheet: {e}")

    for lline in samplesheet:
        line = lline.strip().split("\t")
        if len(line) <= max(sex_idx, sample_idx):
            continue

        if line[sample_idx] == target_sample:
            raw_sex = line[sex_idx]
            sex = SEX_MAPPING.get(raw_sex, SEX_MAPPING.get(raw_sex.capitalize(), "0"))

            # Default pedigree values (unrelated)
            fam_id = target_sample
            father_id = "0"
            mother_id = "0"

            # Check for trio columns
            try:
                trio_idx = header_line.index("trio")
                father_idx = header_line.index("father")
                mother_idx = header_line.index("mother")
                
                # If trio info exists for this sample
                if len(line) > max(trio_idx, father_idx, mother_idx):
                    trio_val = line[trio_idx]
                    if trio_val and trio_val != "." and trio_val != "0":
                        fam_id = trio_val

                        
                        father_val = line[father_idx]
                        if father_val and father_val != "." and father_val != "0":
                            father_id = f"{father_val}_{sample_type}"
                            
                        mother_val = line[mother_idx]
                        if mother_val and mother_val != "." and mother_val != "0":
                            mother_id = f"{mother_val}_{sample_type}"
            except ValueError:
                # Trio columns not present, proceed with defaults
                pass

            output_path = snakemake.output["fam"]
            individual_id = f"{target_sample}_{sample_type}"

            with open(output_path, "w+") as pedfile:
                pedfile.write(
                    "\t".join([fam_id, individual_id, father_id, mother_id, sex, "-9"]) + "\n"
                )
            break
