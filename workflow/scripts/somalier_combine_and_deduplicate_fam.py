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
    # continue with empty dataframe
    deduped_df = pd.DataFrame(columns=['family_id', 'sample_id', 'paternal_id', 'maternal_id', 'sex', 'phenotype'])
else:
    # Concatenate all entries
    combined_df = pd.concat(all_entries, ignore_index=True)

    # Detect standalone entries: family_id is the sample_id prefix (before _type suffix)
    # Example: D26-01237_N has standalone entry with family_id=D26-01237
    def is_standalone_entry(row):
        """Check if family_id matches the sample_id prefix (before underscore)."""
        family_id = row['family_id']
        sample_id = row['sample_id']
        # Check if family_id is the sample prefix (sample_id without the _type suffix)
        # E.g., sample_id="D26-01237_N", family_id="D26-01237"
        if '_' in sample_id:
            sample_prefix = sample_id.rsplit('_', 1)[0]
            return family_id == sample_prefix
        # If no underscore, check exact match
        return family_id == sample_id

    combined_df['is_standalone'] = combined_df.apply(is_standalone_entry, axis=1)

    # Find sample_ids that appear in non-standalone (trio) entries
    trio_samples = set(combined_df[~combined_df['is_standalone']]['sample_id'])

    # Remove standalone entries for samples that also appear in trios
    deduped_df = combined_df[~(combined_df['is_standalone'] &
                               combined_df['sample_id'].isin(trio_samples))]

    # Drop the helper column
    deduped_df = deduped_df.drop(columns=['is_standalone'])

# Sort for consistent output: first by family_id, then by sample_id
if len(deduped_df) > 0:
    deduped_df = deduped_df.sort_values(['family_id', 'sample_id'])

# Write output
deduped_df.to_csv(output_ped, sep='\t', header=False, index=False)

# Log statistics
if all_entries:
    removed_count = len(combined_df) - len(deduped_df)
    if removed_count > 0:
        print(f"Removed {removed_count} duplicate entries", file=sys.stderr)
        print(f"Original entries: {len(combined_df)}", file=sys.stderr)
        print(f"Deduplicated entries: {len(deduped_df)}", file=sys.stderr)
