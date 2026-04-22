#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = "Julia Höglund"
__copyright__ = "Copyright 2026, Julia Höglund"
__email__ = "julia.hoglund@scilifelab.uu.se"
__license__ = "GPL-3"

import sys
import os
import unittest
import tempfile
import shutil
from unittest.mock import Mock
import pandas as pd

TEST_DIR = os.path.dirname(os.path.abspath(__file__))
SCRIPT_DIR = os.path.abspath(os.path.join(TEST_DIR, "../../workflow/scripts"))
sys.path.insert(0, SCRIPT_DIR)


class TestSomalierCombineAndDeduplicate(unittest.TestCase):
    def setUp(self):
        """Set up"""
        self.script_path = os.path.join(SCRIPT_DIR, "somalier_combine_and_deduplicate_fam.py")
        with open(self.script_path, "r") as f:
            self.script_content = f.read()
        self.temp_dir = tempfile.mkdtemp()

    def tearDown(self):
        shutil.rmtree(self.temp_dir)

    def run_script(self, fam_files_content):
        """
        Helper to run the script with test FAM files.

        Args:
            fam_files_content: List of strings, each representing content of a FAM file

        Returns:
            pandas.DataFrame: The output PED file as a dataframe
        """
        # Create input FAM files
        input_files = []
        for i, content in enumerate(fam_files_content):
            fam_path = os.path.join(self.temp_dir, f"sample_{i}.fam")
            with open(fam_path, "w") as f:
                f.write(content)
            input_files.append(fam_path)

        # Create output path
        output_ped = os.path.join(self.temp_dir, "combined.ped")

        # Mock snakemake object
        mock_snakemake = Mock()
        mock_snakemake.input.fam = input_files
        mock_snakemake.output.ped = output_ped

        # Execute the script
        global snakemake
        snakemake = mock_snakemake
        exec(self.script_content, globals())

        # Read and return output
        if os.path.exists(output_ped) and os.path.getsize(output_ped) > 0:
            return pd.read_csv(
                output_ped,
                sep='\t',
                header=None,
                names=['family_id', 'sample_id', 'paternal_id', 'maternal_id', 'sex', 'phenotype'],
                dtype=str
            )
        else:
            return pd.DataFrame(columns=['family_id', 'sample_id', 'paternal_id', 'maternal_id', 'sex', 'phenotype'])

    def test_combine_no_duplicates(self):
        """Test combining FAM files with no duplicates"""
        fam_files = [
            "singleton1\tsample1_N\t0\t0\t1\t-9\n",
            "singleton2\tsample2_N\t0\t0\t2\t-9\n",
            "singleton3\tsample3_N\t0\t0\t1\t-9\n"
        ]

        result = self.run_script(fam_files)

        self.assertEqual(len(result), 3, "Should have 3 entries")
        self.assertEqual(set(result['sample_id']), {'sample1_N', 'sample2_N', 'sample3_N'})

    def test_deduplicate_trio_samples(self):
        """Test deduplication removes standalone entries for trio members"""
        fam_files = [
            # Proband creates trio entries (proband + father + mother)
            "Trio1\tproband_N\tfather_N\tmother_N\t1\t-9\n"
            "Trio1\tfather_N\t0\t0\t1\t-9\n"
            "Trio1\tmother_N\t0\t0\t2\t-9\n",
            # Father as standalone (should be removed)
            "father\tfather_N\t0\t0\t1\t-9\n",
            # Mother as standalone (should be removed)
            "mother\tmother_N\t0\t0\t2\t-9\n",
        ]

        result = self.run_script(fam_files)

        # Should only have 3 entries (all from Trio1), standalone entries removed
        self.assertEqual(len(result), 3, "Should have 3 entries after deduplication")

        # All remaining entries should be from Trio1
        self.assertTrue(all(result['family_id'] == 'Trio1'), "All entries should be from Trio1")

        # Should have proband, father, mother
        self.assertEqual(set(result['sample_id']), {'proband_N', 'father_N', 'mother_N'})

    def test_mixed_singletons_and_trios(self):
        """Test mixed case: singletons + trios, keep only non-trio singletons"""
        fam_files = [
            # Trio
            "Trio1\tchild_N\tdad_N\tmom_N\t1\t-9\n"
            "Trio1\tdad_N\t0\t0\t1\t-9\n"
            "Trio1\tmom_N\t0\t0\t2\t-9\n",
            # True singleton (not in any trio)
            "singleton1\tsingleton1_N\t0\t0\t2\t-9\n",
            # Dad as standalone (should be removed)
            "dad\tdad_N\t0\t0\t1\t-9\n",
            # Another true singleton
            "singleton2\tsingleton2_N\t0\t0\t1\t-9\n",
        ]

        result = self.run_script(fam_files)

        # Should have 5 entries: 3 from Trio1 + 2 true singletons
        self.assertEqual(len(result), 5, "Should have 5 entries")

        # Check family IDs
        family_ids = set(result['family_id'])
        self.assertEqual(family_ids, {'Trio1', 'singleton1', 'singleton2'})

        # Check sample IDs
        sample_ids = set(result['sample_id'])
        self.assertEqual(sample_ids, {'child_N', 'dad_N', 'mom_N', 'singleton1_N', 'singleton2_N'})

    def test_empty_fam_files(self):
        """Test handling of empty FAM files"""
        fam_files = [
            "",  # Empty file
            "sample1\tsample1_N\t0\t0\t1\t-9\n",
            "",  # Another empty file
        ]

        result = self.run_script(fam_files)

        self.assertEqual(len(result), 1, "Should have 1 entry")
        self.assertEqual(result.iloc[0]['sample_id'], 'sample1_N')

    def test_no_input_files(self):
        """Test handling of no input files"""
        result = self.run_script([])

        self.assertEqual(len(result), 0, "Should have 0 entries")

    def test_multiple_trios(self):
        """Test deduplication with multiple trios"""
        fam_files = [
            # Trio1
            "Trio1\tchild1_N\tfather1_N\tmother1_N\t1\t-9\n"
            "Trio1\tfather1_N\t0\t0\t1\t-9\n"
            "Trio1\tmother1_N\t0\t0\t2\t-9\n",
            # Trio2
            "Trio2\tchild2_N\tfather2_N\tmother2_N\t2\t-9\n"
            "Trio2\tfather2_N\t0\t0\t1\t-9\n"
            "Trio2\tmother2_N\t0\t0\t2\t-9\n",
            # Standalone entries for trio members (should be removed)
            "father1\tfather1_N\t0\t0\t1\t-9\n",
            "mother2\tmother2_N\t0\t0\t2\t-9\n",
            # True singleton
            "singleton\tsingleton_N\t0\t0\t1\t-9\n",
        ]

        result = self.run_script(fam_files)

        # Should have 7 entries: 3 from Trio1 + 3 from Trio2 + 1 singleton
        self.assertEqual(len(result), 7, "Should have 7 entries")

        # Check family IDs
        trio1_entries = result[result['family_id'] == 'Trio1']
        trio2_entries = result[result['family_id'] == 'Trio2']
        singleton_entries = result[result['family_id'] == 'singleton']

        self.assertEqual(len(trio1_entries), 3, "Trio1 should have 3 entries")
        self.assertEqual(len(trio2_entries), 3, "Trio2 should have 3 entries")
        self.assertEqual(len(singleton_entries), 1, "Should have 1 singleton")

    def test_sorting(self):
        """Test that output is sorted by family_id then sample_id"""
        fam_files = [
            "ZFamily\tzchild_N\t0\t0\t1\t-9\n",
            "AFamily\tafather_N\t0\t0\t1\t-9\n",
            "AFamily\tachild_N\t0\t0\t1\t-9\n",
            "MFamily\tmchild_N\t0\t0\t1\t-9\n",
        ]

        result = self.run_script(fam_files)

        # Check sorting: should be AFamily (achild, afather), MFamily (mchild), ZFamily (zchild)
        expected_order = ['achild_N', 'afather_N', 'mchild_N', 'zchild_N']
        actual_order = result['sample_id'].tolist()

        self.assertEqual(actual_order, expected_order, "Output should be sorted by family_id then sample_id")

    def test_idempotency(self):
        """Test that deduplicating already-deduplicated data is a no-op"""
        fam_files = [
            # Already deduplicated: trio entries only
            "Trio1\tchild_N\tfather_N\tmother_N\t1\t-9\n"
            "Trio1\tfather_N\t0\t0\t1\t-9\n"
            "Trio1\tmother_N\t0\t0\t2\t-9\n",
            "singleton\tsingleton_N\t0\t0\t1\t-9\n",
        ]

        result = self.run_script(fam_files)

        # Should have 4 entries, no changes
        self.assertEqual(len(result), 4, "Should have 4 entries")
        self.assertEqual(set(result['family_id']), {'Trio1', 'singleton'})


if __name__ == "__main__":
    unittest.main()
