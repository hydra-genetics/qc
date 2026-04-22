#!/usr/bin/env python
# coding: utf-8

"""
Combine multiple FAM files and deduplicate entries.
Keeps trio entries, removes standalone entries for samples that are part of trios.
"""

import pandas as pd
import sys

# Read all input FAM files
fam_files = snakemake.input.fam
output_ped = snakemake.output.ped

# Collect all entries
all_entries = []
for fam_file in fam_files:
    try:
        df = pd.read_csv(
            fam_file,
            sep='\t',
            header=None,
            names=['family_id', 'sample_id', 'paternal_id', 'maternal_id', 'sex', 'phenotype'],
            dtype=str
        )
        all_entries.append(df)
    except pd.errors.EmptyDataError:
        # Skip empty files
        continue

if not all_entries:
    # Create empty output if no entries
    with open(output_ped, 'w') as f:
        pass
    sys.exit(0)

# Concatenate all entries
combined_df = pd.concat(all_entries, ignore_index=True)

# Find samples that are part of trios (family_id != sample_id)
trio_samples = set(combined_df[combined_df['family_id'] != combined_df['sample_id']]['sample_id'])

# Remove standalone entries (family_id == sample_id) for samples that are in trios
# This keeps trio entries and removes duplicates
deduped_df = combined_df[~((combined_df['family_id'] == combined_df['sample_id']) & 
                            (combined_df['sample_id'].isin(trio_samples)))]

# Sort for consistent output: first by family_id, then by sample_id
deduped_df = deduped_df.sort_values(['family_id', 'sample_id'])

# Write output
deduped_df.to_csv(output_ped, sep='\t', header=False, index=False)

# Log statistics
removed_count = len(combined_df) - len(deduped_df)
if removed_count > 0:
    print(f"Removed {removed_count} duplicate entries", file=sys.stderr)
    print(f"Original entries: {len(combined_df)}", file=sys.stderr)
    print(f"Deduplicated entries: {len(deduped_df)}", file=sys.stderr)
