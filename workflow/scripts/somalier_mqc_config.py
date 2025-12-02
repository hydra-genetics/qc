#!/usr/bin/env python


import sys
import traceback
import yaml
import pandas as pd

# test handling outside of snakemake
try:
    snakemake
except NameError:
    snakemake = None


def comment_the_config_keys(config_dict):
    """
    Converts config dictionary into commented YAML format.
    """
    commented_config = '\n'.join(
        ['# ' + line for line in yaml.dump(config_dict).rstrip('\n').split('\n')]
    )
    return commented_config


def process_sample_file(input_file):
    """
    Extracts columns 2, 5, and 7; renames header; transforms data as specified.
    """
    # Read the input file
    df = pd.read_csv(input_file, sep="\t")

    # Extract the required columns
    df = df[['sample_id', 'sex', 'original_pedigree_sex']]

    # Rename 'sample_id' to 'Sample'
    df.rename(columns={'sample_id': 'Sample'}, inplace=True)
    df.rename(columns={'sex': 'inferred_sex'}, inplace=True)
    df.rename(columns={'original_pedigree_sex': 'reported_sex'}, inplace=True)
    # Map `sex` column values to 'female' and 'male'
    df['inferred_sex'] = df['inferred_sex'].map({2: 'female', 1: 'male'})

    # Add 'sex_check' column to check if 'sex' matches 'original_pedigree_sex'
    df['sex_check'] = df.apply(
        lambda row: 'Pass' if row['inferred_sex'] == row['reported_sex'] else 'Fail',
        axis=1
    )
    return df


def main():
    try:
        # Get the config path from Snakemake params (passed from rule)
        config_path = snakemake.params.mqc_config
        if not config_path:
            raise FileNotFoundError("Path to Somalier MultiQC config file not found/specified in Snakemake config.")

        # Load the configuration
        with open(config_path, 'r') as config_file:
            config_dict = yaml.load(config_file, Loader=yaml.FullLoader)

        # Comment the config keys
        commented_config = comment_the_config_keys(config_dict)

        # Process the sample file
        sample_file = snakemake.input.samples
        sample_df = process_sample_file(sample_file)

        # Combine the commented config and processed sample file
        sample_data_str = sample_df.to_csv(sep="\t", index=False)
        combined_output = f"{commented_config}\n{sample_data_str}"

        # Write the combined output directly to the final file
        with open(snakemake.output[0], 'w') as output_file:
            output_file.write(combined_output)

    except FileNotFoundError as e:
        with open(snakemake.log[0], 'w') as log_file:
            log_file.write(f"Error: {e}\n")
            log_file.write(traceback.format_exc())
        sys.exit(1)


if __name__ == "__main__":
    main()
