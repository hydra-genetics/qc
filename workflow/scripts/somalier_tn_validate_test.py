#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Unit tests for somalier_tn_validate.py
"""

import sys
import os
import unittest
import tempfile
import shutil
import pandas as pd
from unittest.mock import Mock

TEST_DIR = os.path.dirname(os.path.abspath(__file__))
SCRIPT_DIR = os.path.abspath(os.path.join(TEST_DIR, "../../workflow/scripts"))
sys.path.insert(0, SCRIPT_DIR)


class TestSomalierTNValidate(unittest.TestCase):
    def setUp(self):
        """Set up temp directory and read script"""
        self.temp_dir = tempfile.mkdtemp()
        self.script_path = os.path.join(SCRIPT_DIR, "somalier_tn_validate.py")
        with open(self.script_path, "r") as f:
            self.script_content = f.read()

    def tearDown(self):
        """Clean up temp dir"""
        shutil.rmtree(self.temp_dir)

    def test_parse_group_file(self):
        """Test parsing of group file"""
        group_file = os.path.join(self.temp_dir, "test.groups")
        with open(group_file, "w") as f:
            f.write("HD832_N,HD832_T\n")
            f.write("HD833_N,HD833_T\n")

        # Execute just the parse function
        exec(self.script_content, globals())
        result = parse_group_file(group_file)

        self.assertEqual(len(result), 2)
        self.assertIn("HD832", result)
        self.assertEqual(result["HD832"], ("HD832_N", "HD832_T"))
        self.assertIn("HD833", result)
        self.assertEqual(result["HD833"], ("HD833_N", "HD833_T"))

    def test_validate_tn_pairs_pass(self):
        """Test validation with high relatedness (should pass)"""
        
        # Create mock pairs data
        pairs_data = {
            '#sample_a': ['HD832_N', 'HD833_N'],
            'sample_b': ['HD832_T', 'HD833_T'],
            'relatedness': [0.95, 0.98]
        }
        pairs_df = pd.DataFrame(pairs_data)
        
        expected_pairs = {
            'HD832': ('HD832_N', 'HD832_T'),
            'HD833': ('HD833_N', 'HD833_T')
        }
        
        # Execute script to get validate function
        exec(self.script_content, globals())
        mismatches = validate_tn_pairs(pairs_df, expected_pairs, threshold=0.8)
        
        self.assertEqual(len(mismatches), 0, "Should have no mismatches with high relatedness")

    def test_validate_tn_pairs_fail(self):
        """Test validation with low relatedness (should fail check but return mismatch)"""
        
        # Create mock pairs data with low relatedness
        pairs_data = {
            '#sample_a': ['HD832_N', 'HD833_N'],
            'sample_b': ['HD832_T', 'HD833_T'],
            'relatedness': [0.95, 0.15]  # HD833 has low relatedness
        }
        pairs_df = pd.DataFrame(pairs_data)
        
        expected_pairs = {
            'HD832': ('HD832_N', 'HD832_T'),
            'HD833': ('HD833_N', 'HD833_T')
        }
        
        # Execute script to get validate function
        exec(self.script_content, globals())
        mismatches = validate_tn_pairs(pairs_df, expected_pairs, threshold=0.8)
        
        self.assertEqual(len(mismatches), 1, "Should have 1 mismatch")
        self.assertEqual(mismatches[0]['sample'], 'HD833')
        self.assertIn('Low relatedness', mismatches[0]['issue'])

    def test_validate_tn_pairs_missing(self):
        """Test validation when pair is missing from output"""
        
        # Create mock pairs data missing HD833
        pairs_data = {
            '#sample_a': ['HD832_N'],
            'sample_b': ['HD832_T'],
            'relatedness': [0.95]
        }
        pairs_df = pd.DataFrame(pairs_data)
        
        expected_pairs = {
            'HD832': ('HD832_N', 'HD832_T'),
            'HD833': ('HD833_N', 'HD833_T')  # This pair is missing
        }
        
        # Execute script to get validate function
        exec(self.script_content, globals())
        mismatches = validate_tn_pairs(pairs_df, expected_pairs, threshold=0.8)
        
        self.assertEqual(len(mismatches), 1, "Should have 1 mismatch for missing pair")
        self.assertEqual(mismatches[0]['sample'], 'HD833')
        self.assertIn('not found', mismatches[0]['issue'])

    def test_full_script_execution_pass(self):
        """Test full script execution with valid T/N pairs"""
        
        # Create test files
        pairs_file = os.path.join(self.temp_dir, "test.pairs.tsv")
        group_file = os.path.join(self.temp_dir, "test.groups")
        output_file = os.path.join(self.temp_dir, "output.txt")
        
        # Write pairs file
        pairs_data = pd.DataFrame({
            '#sample_a': ['HD832_N'],
            'sample_b': ['HD832_T'],
            'relatedness': [0.95]
        })
        pairs_data.to_csv(pairs_file, sep='\t', index=False)
        
        # Write group file
        with open(group_file, "w") as f:
            f.write("HD832_N,HD832_T\n")
        
        # Mock snakemake object
        mock_snakemake = Mock()
        mock_snakemake.input = {"pairs": pairs_file, "group": group_file}
        mock_snakemake.output = {"tncheck": output_file}
        mock_snakemake.params = {"threshold": 0.8}
        
        # Execute script
        global snakemake
        snakemake = mock_snakemake
        
        try:
            exec(self.script_content, globals())
        except SystemExit as e:
            # Script exits with 0 on success
            self.assertEqual(e.code, 0, "Script should exit with 0 on success")
        
        # Check output file
        self.assertTrue(os.path.exists(output_file))
        with open(output_file, "r") as f:
            content = f.read()
            self.assertIn("validated successfully", content)

    def test_full_script_execution_fail(self):
        """Test full script execution with invalid T/N pairs (should warn only)"""
        
        # Create test files
        pairs_file = os.path.join(self.temp_dir, "test.pairs.tsv")
        group_file = os.path.join(self.temp_dir, "test.groups")
        output_file = os.path.join(self.temp_dir, "output.txt")
        
        # Write pairs file with low relatedness
        pairs_data = pd.DataFrame({
            '#sample_a': ['HD832_N'],
            'sample_b': ['HD832_T'],
            'relatedness': [0.15]  # Low relatedness
        })
        pairs_data.to_csv(pairs_file, sep='\t', index=False)
        
        # Write group file
        with open(group_file, "w") as f:
            f.write("HD832_N,HD832_T\n")
        
        # Mock snakemake object
        mock_snakemake = Mock()
        mock_snakemake.input = {"pairs": pairs_file, "group": group_file}
        mock_snakemake.output = {"tncheck": output_file}
        mock_snakemake.params = {"threshold": 0.8}
        
        # Execute script
        global snakemake
        snakemake = mock_snakemake
        
        try:
            exec(self.script_content, globals())
        except SystemExit as e:
            # Script exits with 0 even on failure (warning only)
            self.assertEqual(e.code, 0, "Script should exit with 0 (success) even on validation mismatch")
        
        # Check output file
        self.assertTrue(os.path.exists(output_file))
        with open(output_file, "r") as f:
            content = f.read()
            self.assertIn("validation issues", content)
            self.assertIn("HD832", content)


if __name__ == "__main__":
    unittest.main()
