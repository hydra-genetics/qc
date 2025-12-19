#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = "Julia Höglund"
__copyright__ = "Copyright 2025, Julia Höglund"
__email__ = "julia.hoglund@scilifelab.uu.se"
__license__ = "GPL-3"

import sys
import os
import unittest
from unittest.mock import Mock

TEST_DIR = os.path.dirname(os.path.abspath(__file__))
SCRIPT_DIR = os.path.abspath(os.path.join(TEST_DIR, "../../workflow/scripts"))
sys.path.insert(0, SCRIPT_DIR)


class TestSomalierCreatePed(unittest.TestCase):
    def setUp(self):
        """Set up - read the script content"""
        self.script_path = os.path.join(SCRIPT_DIR, "somalier_create_ped.py")
        with open(self.script_path, "r") as f:
            self.script_content = f.read()

    def run_script(self, input_content, wildcards_sample, sample_type="T"):
        """Helper to run the script with mocked environment"""
        mock_snakemake = Mock()
        mock_snakemake.params = {"sample_type": sample_type}
        mock_snakemake.input = ["samples.tsv"]
        mock_snakemake.wildcards.sample = wildcards_sample
        mock_snakemake.output = {"fam": "output.fam"}

        with unittest.mock.patch("builtins.open", unittest.mock.mock_open(read_data=input_content)) as m_open:
            global snakemake
            snakemake = mock_snakemake

            # Execute the script
            exec(self.script_content, globals())

            # Capture what was written
            handle = m_open()
            return handle.write.call_args_list

    def test_sex_mapping_flexible(self):
        """Test flexible sex mapping (M/F/K/O/etc)"""
        cases = [
            ("M", "1"), ("Male", "1"), ("Man", "1"), ("1", "1"),
            ("F", "2"), ("Female", "2"), ("K", "2"), ("Kvinna", "2"), ("2", "2"),
            ("O", "0"), ("Okänd", "0"), ("U", "0"), ("Unknown", "0"), ("0", "0")
        ]

        for input_sex, expected_ped_sex in cases:
            with self.subTest(sex=input_sex):
                content = f"sample\tsex\nsample1\t{input_sex}\n"
                calls = self.run_script(content, "sample1")

                # Check match
                self.assertTrue(calls, "No write calls found")
                args = calls[0][0][0]
                # First call, args tuple, first arg
                expected = f"sample1\tsample1_T\t0\t0\t{expected_ped_sex}\t-9\n"
                self.assertEqual(args, expected)

    def test_sample_selection(self):
        """Test that script picks the correct sample from a multi-line samplesheet"""
        content = "sample\tsex\nsample1\tM\nsample2\tF\nsample3\tO\n"

        calls = self.run_script(content, "sample2")

        self.assertTrue(calls, "No write calls found")
        args = calls[0][0][0]
        expected = "sample2\tsample2_T\t0\t0\t2\t-9\n"
        self.assertEqual(args, expected)

    def test_missing_column(self):
        """Test error handling for missing columns"""
        content = "sample\tother\nsample1\tM\n"
        with self.assertRaises(SystemExit) as cm:
            self.run_script(content, "sample1")

        self.assertIn("Missing required column", str(cm.exception))


if __name__ == "__main__":
    unittest.main()
