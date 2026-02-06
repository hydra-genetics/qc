#!/usr/bin/env python
# coding: utf-8

"""
Validate parent-child relationships in trio analysis.
Checks that expected parent-child pairs have sufficient relatedness.
"""

import pandas as pd
import sys

pairs_file = snakemake.input["pairs"]
samples_file = snakemake.input["samples"]
ped_file = snakemake.input["ped"]
output_file = snakemake.output["validation"]
threshold = snakemake.params["threshold"]

# Read the pairs file (relatedness scores)
pairs = pd.read_csv(pairs_file, sep="\t")

# Read the PED file to get trio relationships
ped = pd.read_csv(ped_file, sep="\t", header=None, names=["fam", "ind", "father", "mother", "sex", "pheno"])

# Track validation issues
issues = []

# For each individual with parents defined
for idx, row in ped.iterrows():
    individual = row["ind"]
    father = row["father"]
    mother = row["mother"]

    # Skip if no parents defined
    if father == "0" or mother == "0":
        continue

    # Check father-child relationship
    father_child = pairs[
        ((pairs["#sample_a"] == father) & (pairs["sample_b"] == individual)) |
        ((pairs["#sample_a"] == individual) & (pairs["sample_b"] == father))
    ]

    if not father_child.empty:
        relatedness = father_child["relatedness"].values[0]
        if relatedness < threshold:
            issues.append(
                f"Low father-child relatedness: {father} - {individual} "
                f"(relatedness={relatedness:.4f}, threshold={threshold})"
            )

    # Check mother-child relationship
    mother_child = pairs[
        ((pairs["#sample_a"] == mother) & (pairs["sample_b"] == individual)) |
        ((pairs["#sample_a"] == individual) & (pairs["sample_b"] == mother))
    ]

    if not mother_child.empty:
        relatedness = mother_child["relatedness"].values[0]
        if relatedness < threshold:
            issues.append(
                f"Low mother-child relatedness: {mother} - {individual} "
                f"(relatedness={relatedness:.4f}, threshold={threshold})"
            )

# Write results
with open(output_file, "w") as outfile:
    if issues:
        outfile.write("TRIO VALIDATION ISSUES DETECTED:\n")
        outfile.write("=" * 70 + "\n\n")
        for issue in issues:
            outfile.write(f"⚠️  {issue}\n")
        outfile.write("\n" + "=" * 70 + "\n")
        outfile.write(f"Total issues: {len(issues)}\n")
    else:
        outfile.write("✓ All parent-child relationships validated successfully.\n")
        outfile.write(f"All relatedness scores >= {threshold}\n")
