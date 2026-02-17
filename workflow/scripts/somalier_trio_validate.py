#!/usr/bin/env python
# coding: utf-8

"""
Validate parent-child relationships in trio analysis.
Checks that expected parent-child pairs have sufficient relatedness.
"""

import pandas as pd
import sys

pairs_file = snakemake.input["pairs"]
ped_file = snakemake.input["ped"]
output_file = snakemake.output["validation"]
threshold = snakemake.params["threshold"]

# Read the pairs file (relatedness scores)
pairs = pd.read_csv(pairs_file, sep="\t")

# Read the PED file to get trio relationships (keep as strings for consistent comparison)
ped = pd.read_csv(ped_file, sep="\t", header=None, names=["fam", "ind", "father", "mother", "sex", "pheno"], dtype=str)

# Track validation issues
issues = []

# For each individual with parents defined
for _, row in ped.iterrows():
    individual = row["ind"]
    father = row["father"]
    mother = row["mother"]

    # Check each parent independently (validate known parents even if one is missing)
    has_father = father not in ["0", ".", ""]
    has_mother = mother not in ["0", ".", ""]

    # Skip if neither parent is defined
    if not has_father and not has_mother:
        continue

    # Check father-child relationship (only if father is defined)
    if has_father:
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
        else:
            issues.append(
                f"Missing father-child pair: {father} - {individual} "
                f"(pair not found in relatedness results)"
            )

    # Check mother-child relationship (only if mother is defined)
    if has_mother:
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
        else:
            issues.append(
                f"Missing mother-child pair: {mother} - {individual} "
                f"(pair not found in relatedness results)"
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
