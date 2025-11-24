#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = "Julia Höglund"
__copyright__ = "Copyright 2025, Julia Höglund"
__email__ = "julia.hoglund@scilifelab.uu.se"
__license__ = "GPL-3"

import sys
import os
import unittest
from unittest.mock import Mock, patch
import tempfile

TEST_DIR = os.path.dirname(os.path.abspath(__file__))
SCRIPT_DIR = os.path.abspath(os.path.join(TEST_DIR, "../../workflow/scripts"))
sys.path.insert(0, SCRIPT_DIR)

# Import functions from the script
from somalier_mqc_config import comment_the_config_keys, process_sample_file  # noqa: E402


class TestCommentTheConfigKeys(unittest.TestCase):
    def test_comment_config(self):
        """Test that config dictionary is properly commented"""
        config_dict = {
            "id": "somalier_sex_check",
            "section_name": "Somalier Sex Check"
        }
        result = comment_the_config_keys(config_dict)

        for line in result.split('\n'):
            self.assertTrue(line.startswith('#'), f"Line not commented: {line}")

        self.assertIn("id:", result)
        self.assertIn("somalier_sex_check", result)
        self.assertIn("section_name:", result)


class TestProcessSampleFile(unittest.TestCase):
    def setUp(self):
        """Set up test fixtures"""
        self.test_dir = os.path.join(SCRIPT_DIR, ".tests")
        os.makedirs(self.test_dir, exist_ok=True)

    def test_process_sample_file_pass(self):
        """Test processing sample file with matching sex (Pass)"""
        input_file = os.path.join(self.test_dir, "somalier_mqc_config.pass.input.tsv")

        df = process_sample_file(input_file)

        self.assertIn('Sample', df.columns)
        self.assertIn('inferred_sex', df.columns)
        self.assertIn('reported_sex', df.columns)
        self.assertIn('sex_check', df.columns)

        self.assertEqual(df.iloc[0]['Sample'], 'SAMPLE001_N')
        self.assertEqual(df.iloc[0]['inferred_sex'], 'male')
        self.assertEqual(df.iloc[0]['reported_sex'], 'male')
        self.assertEqual(df.iloc[0]['sex_check'], 'Pass')

    def test_process_sample_file_fail(self):
        """Test processing sample file with mismatched sex (Fail)"""
        input_file = os.path.join(self.test_dir, "somalier_mqc_config.fail.input.tsv")

        df = process_sample_file(input_file)

        self.assertEqual(df.iloc[0]['Sample'], 'SAMPLE002_T')
        self.assertEqual(df.iloc[0]['inferred_sex'], 'female')
        self.assertEqual(df.iloc[0]['reported_sex'], 'male')
        self.assertEqual(df.iloc[0]['sex_check'], 'Fail')

    def test_process_sample_file_multiple(self):
        """Test processing sample file with multiple samples"""
        input_file = os.path.join(self.test_dir, "somalier_mqc_config.multiple.input.tsv")

        df = process_sample_file(input_file)

        self.assertEqual(len(df), 3)

        self.assertEqual(df.iloc[0]['sex_check'], 'Pass')
        self.assertEqual(df.iloc[1]['sex_check'], 'Fail')
        self.assertEqual(df.iloc[2]['sex_check'], 'Pass')


class TestSomalierMqcConfigMain(unittest.TestCase):
    def setUp(self):
        """Set up test fixtures"""
        self.test_dir = os.path.join(SCRIPT_DIR, ".tests")
        os.makedirs(self.test_dir, exist_ok=True)

    def tearDown(self):
        """Clean up test files"""
        # Clean up actual output files
        for f in os.listdir(self.test_dir):
            if f.endswith(".actual.tsv"):
                os.remove(os.path.join(self.test_dir, f))

    def test_full_workflow(self):
        """Test the complete workflow from config and sample file to output"""
        config_file = os.path.join(self.test_dir, "somalier_mqc_config.config.yaml")
        sample_file = os.path.join(self.test_dir, "somalier_mqc_config.pass.input.tsv")
        expected_file = os.path.join(self.test_dir, "somalier_mqc_config.pass.expected.tsv")
        output_file = os.path.join(self.test_dir, "somalier_mqc_config.pass.actual.tsv")

        mock_snakemake = Mock()
        mock_snakemake.config = {
            "somalier_mqc": {
                "config": config_file
            }
        }
        mock_snakemake.input = Mock()
        mock_snakemake.input.samples = sample_file
        mock_snakemake.output = [output_file]
        mock_snakemake.log = [os.path.join(self.test_dir, "test.log")]

        with patch('somalier_mqc_config.snakemake', mock_snakemake):
            from somalier_mqc_config import main
            main()

        with open(expected_file, "r") as expected:
            with open(output_file, "r") as actual:
                expected_lines = [line for line in expected.readlines() if not line.startswith('#')]
                actual_lines = [line for line in actual.readlines() if not line.startswith('#')]

                self.assertEqual(
                    expected_lines,
                    actual_lines,
                    f"Output differs from expected"
                )


if __name__ == "__main__":
    unittest.main()
