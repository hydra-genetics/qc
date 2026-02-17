#!/usr/bin/env python
# coding: utf-8

"""
Create a group file for somalier trio analysis.
Format: father,mother,proband (one trio per line)
Only includes samples with valid trio information.
"""

import sys

input_file = snakemake.input["samples"]
output_file = snakemake.output["groups"]

trios = []

with open(input_file, "r") as samplesheet:
    header_line = samplesheet.readline().strip().split("\t")
    header_line = [h.strip('"') for h in header_line]

    try:
        sample_idx = header_line.index("sample")
        trio_idx = header_line.index("trio")
        father_idx = header_line.index("father")
        mother_idx = header_line.index("mother")
    except ValueError:
        # If trio columns don't exist, create an empty group file
        with open(output_file, "w") as outfile:
            pass
        sys.exit(0)

    # Track samples by their trio ID to build complete trios
    trio_dict = {}

    for line in samplesheet:
        fields = line.strip().split("\t")
        if len(fields) <= max(sample_idx, trio_idx, father_idx, mother_idx):
            continue

        sample = fields[sample_idx]
        trio_val = fields[trio_idx]
        father_val = fields[father_idx]
        mother_val = fields[mother_idx]

        # Skip samples without trio information
        if not trio_val or trio_val in [".", "0"]:
            continue

        if trio_val not in trio_dict:
            trio_dict[trio_val] = {"father": None, "mother": None, "proband": None}

        # Determine role based on father/mother fields
        if father_val and father_val not in [".", "0"] and mother_val and mother_val not in [".", "0"]:
            # This sample has parents, so it's the proband
            trio_dict[trio_val]["proband"] = sample
            trio_dict[trio_val]["father"] = father_val
            trio_dict[trio_val]["mother"] = mother_val
        # Note: Parent samples are identified by name in proband rows above
        # No additional processing needed for parent rows since they're already captured

    # Write complete trios to output
    with open(output_file, "w") as outfile:
        for trio_id, members in trio_dict.items():
            if members["father"] and members["mother"] and members["proband"]:
                # Write in format: father,mother,proband
                # Add sample type suffix if using typed samples
                outfile.write(f"{members['father']},{members['mother']},{members['proband']}\n")
