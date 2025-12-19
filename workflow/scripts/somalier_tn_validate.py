#!/usr/bin/env python
# coding: utf-8

"""
Validate T/N pairs from Somalier output.
Checks that expected T/N pairs have high relatedness scores.
"""

import sys
import pandas as pd

# Get inputs from Snakemake
pairs_file = snakemake.input["pairs"]
group_file = snakemake.input.get("group", None)
output_file = snakemake.output["tncheck"]
threshold = snakemake.params.get("threshold", 0.8)

def parse_group_file(group_path):
    """Parse the group file to get expected T/N pairs.
    
    Returns:
        dict: {sample_id: (sample_N, sample_T)}
    """
    expected_pairs = {}
    if not group_path:
        return expected_pairs
        
    with open(group_path, 'r') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            # Format: sample_N,sample_T
            parts = line.split(',')
            if len(parts) == 2:
                sample_n, sample_t = parts
                # Extract base sample ID (remove _N or _T suffix)
                sample_id = sample_n.rsplit('_', 1)[0]
                expected_pairs[sample_id] = (sample_n, sample_t)
    
    return expected_pairs

def validate_tn_pairs(pairs_df, expected_pairs, threshold):
    """Validate that T/N pairs have high relatedness.

    Returns:
        list: Sample IDs with mismatched T/N pairs
    """
    mismatches = []
    
    for sample_id, (sample_n, sample_t) in expected_pairs.items():
        # Find the row where these two samples are compared
        pair_row = pairs_df[
            ((pairs_df['#sample_a'] == sample_n) & (pairs_df['sample_b'] == sample_t)) |
            ((pairs_df['#sample_a'] == sample_t) & (pairs_df['sample_b'] == sample_n))
        ]
        
        if pair_row.empty:
            mismatches.append({
                'sample': sample_id,
                'sample_a': sample_n,
                'sample_b': sample_t,
                'pair_type': 'T/N',
                'relatedness': 'N/A',
                'issue': 'Pair not found in somalier output'
            })
        else:
            relatedness = pair_row['relatedness'].iloc[0]
            if relatedness < threshold:
                mismatches.append({
                    'sample': sample_id,
                    'sample_a': sample_n,
                    'sample_b': sample_t,
                    'pair_type': 'T/N',
                    'relatedness': f"{relatedness:.4f}",
                    'issue': f'Low relatedness (< {threshold})'
                })
    
    return mismatches


# Main execution
try:
    # Read somalier pairs output
    pairs_df = pd.read_csv(pairs_file, sep='\t')
    
    # Parse expected pairs from group file
    expected_pairs = parse_group_file(group_file)
    
    # Validate T/N pairs
    tn_mismatches = validate_tn_pairs(pairs_df, expected_pairs, threshold) if expected_pairs else []
    
    # Write output
    with open(output_file, 'w') as f:
        if not tn_mismatches:
            if not expected_pairs:
                f.write("# No T/N pairs to validate\n")
            else:
                f.write("# All T/N pairs validated successfully\n")
        else:
            f.write("# T/N pairs with validation issues:\n")
            f.write("# sample\tsample_a\tsample_b\tpair_type\trelatedness\tissue\n")
            for m in tn_mismatches:
                f.write(f"{m['sample']}\t{m['sample_a']}\t{m['sample_b']}\t{m['pair_type']}\t{m['relatedness']}\t{m['issue']}\n")
    
    # Always exit with success (warning only behavior)
    sys.exit(0)
    
except Exception as e:
    with open(output_file, 'w') as f:
        f.write(f"# ERROR: {str(e)}\n")
    sys.exit(1)
