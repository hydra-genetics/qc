#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = "Julia Höglund"
__copyright__ = "Copyright 2025, Julia Höglund"
__email__ = "julia.hoglund@scilifelab.uu.se"
__license__ = "GPL-3"

import sys
import os
import unittest
import tempfile
import shutil
from unittest.mock import Mock, patch, mock_open

TEST_DIR = os.path.dirname(os.path.abspath(__file__))
SCRIPT_DIR = os.path.abspath(os.path.join(TEST_DIR, "../../workflow/scripts"))
sys.path.insert(0, SCRIPT_DIR)


class TestSomalierCreatePed(unittest.TestCase):
    def setUp(self):
        """Set up - read the script content and create temp dir"""
        self.script_path = os.path.join(SCRIPT_DIR, "somalier_create_ped.py")
        with open(self.script_path, "r") as f:
            self.script_content = f.read()
        self.temp_dir = tempfile.mkdtemp()

    def tearDown(self):
        """Clean up temp dir"""
        shutil.rmtree(self.temp_dir)

    def run_script(self, input_content, wildcards_sample, sample_type="T"):
        """Helper to run the script with mocked environment"""
        mock_snakemake = Mock()
        mock_snakemake.params = {"sample_type": sample_type}
        mock_snakemake.input = ["samples.tsv"]
        mock_snakemake.wildcards.sample = wildcards_sample
        mock_snakemake.output = {"fam": "output.fam"}

        with patch("builtins.open", mock_open(read_data=input_content)) as m_open:
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

    def test_type_based_logic(self):
        """Test that all types (T, N, R, etc) use {sample}_{type} format."""
        class MockSnakemake:
            def __init__(self, params, input_files, output_files, wildcards):
                self.params = params
                self.input = input_files
                self.output = output_files
                self.wildcards = wildcards

        samples_file = os.path.join(self.temp_dir, "samples.tsv")
        input_data = "sample\tsex\nS1\tM\nS2\tF\n"
        with open(samples_file, "w") as f:
            f.write(input_data)

        # Test Case 1: Type T -> Expect S1_T (will be grouped with N if exists)
        output_fam_t = os.path.join(self.temp_dir, "output_T.fam")

        mock_snakemake_t = MockSnakemake(
            params={"sample_type": "T"},
            input_files=[samples_file],
            output_files={"fam": output_fam_t},
            wildcards=type("Wildcards", (object,), {"sample": "S1"})()
        )

        global snakemake
        snakemake = mock_snakemake_t
        exec(self.script_content, globals())

        # Verify Output
        with open(output_fam_t, "r") as f:
            content = f.read().strip()
            fields = content.split("\t")
            self.assertEqual(fields[0], "S1")
            self.assertEqual(fields[1], "S1_T")
            self.assertEqual(fields[4], "1")

        # Test Case 2: Type R -> Expect S2_R (won't be grouped, treated independently)
        output_fam_r = os.path.join(self.temp_dir, "output_R.fam")

        mock_snakemake_r = MockSnakemake(
            params={"sample_type": "R"},
            input_files=[samples_file],
            output_files={"fam": output_fam_r},
            wildcards=type("Wildcards", (object,), {"sample": "S2"})()
        )

        snakemake = mock_snakemake_r
        exec(self.script_content, globals())

        # Verify Output
        with open(output_fam_r, "r") as f:
            content = f.read().strip()
            fields = content.split("\t")
            self.assertEqual(fields[0], "S2")
            self.assertEqual(fields[1], "S2_R")
            self.assertEqual(fields[4], "2")



    def test_trio_ped_creation(self):
        """Test PED creation with trio information"""
        input_content = (
            "sample\tsex\ttrio\tfather\tmother\n"
            "child1\tM\tfamily1\tfather1\tmother1\n"
        )
        
        write_calls = self.run_script(input_content, "child1", sample_type="N")
        
        # Check write call
        args, _ = write_calls[0]
        written_line = args[0].strip()
        # Format: FID IID PID MID SEX PHENO
        parts = written_line.split("\t")
        
        self.assertEqual(parts[0], "family1")      # FID
        self.assertEqual(parts[1], "child1_N")     # IID
        self.assertEqual(parts[2], "father1_N")    # PID
        self.assertEqual(parts[3], "mother1_N")    # MID
        self.assertEqual(parts[4], "1")            # SEX (M->1)


if __name__ == "__main__":
    unittest.main()
