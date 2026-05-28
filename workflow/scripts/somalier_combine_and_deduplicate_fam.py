#!/usr/bin/env python
# coding: utf-8

"""
Combine multiple FAM files and deduplicate entries.
Keeps trio entries, removes standalone entries for samples that are part of trios.
"""

import csv
import sys

# Read all input FAM files
fam_files = snakemake.input.fam
output_ped = snakemake.output.ped

# Collect all entries as list of dicts
all_entries = []
for fam_file in fam_files:
    try:
        with open(fam_file, 'r') as f:
            reader = csv.reader(f, delimiter='\t')
            for row in reader:
                if len(row) == 6:  # Valid FAM format
                    all_entries.append({
                        'family_id': row[0],
                        'sample_id': row[1],
                        'paternal_id': row[2],
                        'maternal_id': row[3],
                        'sex': row[4],
                        'phenotype': row[5]
                    })
    except (IOError, OSError) as e:
        # Fail fast on unreadable FAM files to avoid dropping pedigree data
        sys.stderr.write(f"ERROR: Cannot read FAM file '{fam_file}': {e}\n")
        sys.exit(1)

if not all_entries:
    # Create empty output if no entries
    with open(output_ped, 'w') as f:
        pass
    deduped_entries = []
else:
    # Detect standalone entries: family_id is the sample_id prefix (before _type suffix)
    # AND the entry has no parents (paternal_id='0' and maternal_id='0')
    # Example: D26-01237_N has standalone entry with family_id=D26-01237
    def is_standalone_entry(entry):
        """Check if family_id matches sample_id prefix AND entry has no parents."""
        # A true standalone must have no parents
        if entry['paternal_id'] != '0' or entry['maternal_id'] != '0':
            return False
        
        family_id = entry['family_id']
        sample_id = entry['sample_id']
        # Check if family_id is the sample prefix (sample_id without the _type suffix)
        # E.g., sample_id="D26-01237_N", family_id="D26-01237"
        if '_' in sample_id:
            sample_prefix = sample_id.rsplit('_', 1)[0]
            return family_id == sample_prefix
        # If no underscore, check exact match
        return family_id == sample_id

    # Mark standalone entries
    for entry in all_entries:
        entry['is_standalone'] = is_standalone_entry(entry)

    # Find all sample_ids that are part of trios (as proband OR as parents)
    trio_samples = set()
    for entry in all_entries:
        if not entry['is_standalone']:
            # Add the proband
            trio_samples.add(entry['sample_id'])
            # Add parents if they're defined (not '0')
            if entry['paternal_id'] != '0':
                trio_samples.add(entry['paternal_id'])
            if entry['maternal_id'] != '0':
                trio_samples.add(entry['maternal_id'])

    # Remove standalone entries for samples that also appear in trios
    # AND deduplicate exact duplicate rows across files
    seen = set()
    deduped_entries = []
    for entry in all_entries:
        # Skip standalone entries for samples in trios
        if entry['is_standalone'] and entry['sample_id'] in trio_samples:
            continue
        # Create tuple key for deduplication (all PED fields)
        entry_key = (
            entry['family_id'],
            entry['sample_id'],
            entry['paternal_id'],
            entry['maternal_id'],
            entry['sex'],
            entry['phenotype']
        )
        # Only add if not seen before
        if entry_key not in seen:
            seen.add(entry_key)
            deduped_entries.append(entry)

# Sort for consistent output: first by family_id, then by sample_id
if deduped_entries:
    deduped_entries.sort(key=lambda x: (x['family_id'], x['sample_id']))

# Write output
with open(output_ped, 'w') as f:
    writer = csv.writer(f, delimiter='\t', lineterminator='\n')
    for entry in deduped_entries:
        writer.writerow([
            entry['family_id'],
            entry['sample_id'],
            entry['paternal_id'],
            entry['maternal_id'],
            entry['sex'],
            entry['phenotype']
        ])

# Log statistics
if all_entries:
    removed_count = len(all_entries) - len(deduped_entries)
    if removed_count > 0:
        print(f"Removed {removed_count} duplicate entries", file=sys.stderr)
        print(f"Original entries: {len(all_entries)}", file=sys.stderr)
        print(f"Deduplicated entries: {len(deduped_entries)}", file=sys.stderr)
