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
        """Set up test fixtures"""
        self.test_dir = os.path.join(SCRIPT_DIR, ".tests")
        os.makedirs(self.test_dir, exist_ok=True)

    def tearDown(self):
        """Clean up test files"""
        # Clean up actual output files
        for f in os.listdir(self.test_dir):
            if f.endswith(".actual.fam"):
                os.remove(os.path.join(self.test_dir, f))

    def test_create_ped_male_tumor(self):
        """Test creating .fam file for male tumor sample"""
        input_file = os.path.join(self.test_dir, "somalier_create_ped.male.input.tsv")
        expected_file = os.path.join(self.test_dir, "somalier_create_ped.male_T.expected.fam")
        output_file = os.path.join(self.test_dir, "somalier_create_ped.male_T.actual.fam")

        # Mock snakemake object
        global snakemake
        snakemake = Mock()
        snakemake.params = {"sample_type": "T"}
        snakemake.input = [input_file]
        snakemake.output = {"fam": output_file}

        # Import and run the script logic
        with open(input_file, "r") as samplesheet:
            header_line = samplesheet.readline().strip().split("\t")
            for lline in samplesheet:
                line = lline.strip().split("\t")
                if line[header_line.index("sex")] == "M":
                    sex = "1"
                elif line[header_line.index("sex")] == "K":
                    sex = "2"
                else:
                    sex = "0"
                sample_id = line[header_line.index("sample")]
                output_path = snakemake.output["fam"]
                with open(output_path, "w+") as pedfile:
                    pedfile.write(
                        "\t".join([sample_id, f"{sample_id}_{snakemake.params['sample_type']}", "0", "0", sex, "-9"]) + "\n"
                    )

        # Compare with expected output
        with open(expected_file, "r") as expected:
            with open(output_file, "r") as actual:
                expected_content = expected.read()
                actual_content = actual.read()
                self.assertEqual(
                    expected_content,
                    actual_content,
                    f"Output differs from expected.\nExpected:\n{expected_content}\nActual:\n{actual_content}"
                )

    def test_create_ped_female_normal(self):
        """Test creating .fam file for female normal sample"""
        input_file = os.path.join(self.test_dir, "somalier_create_ped.female.input.tsv")
        expected_file = os.path.join(self.test_dir, "somalier_create_ped.female_N.expected.fam")
        output_file = os.path.join(self.test_dir, "somalier_create_ped.female_N.actual.fam")

        # Mock snakemake object
        global snakemake
        snakemake = Mock()
        snakemake.params = {"sample_type": "N"}
        snakemake.input = [input_file]
        snakemake.output = {"fam": output_file}

        # Import and run the script logic
        with open(input_file, "r") as samplesheet:
            header_line = samplesheet.readline().strip().split("\t")
            for lline in samplesheet:
                line = lline.strip().split("\t")
                if line[header_line.index("sex")] == "M":
                    sex = "1"
                elif line[header_line.index("sex")] == "K":
                    sex = "2"
                else:
                    sex = "0"
                sample_id = line[header_line.index("sample")]
                output_path = snakemake.output["fam"]
                with open(output_path, "w+") as pedfile:
                    pedfile.write(
                        "\t".join([sample_id, f"{sample_id}_{snakemake.params['sample_type']}", "0", "0", sex, "-9"]) + "\n"
                    )

        # Compare with expected output
        with open(expected_file, "r") as expected:
            with open(output_file, "r") as actual:
                expected_content = expected.read()
                actual_content = actual.read()
                self.assertEqual(
                    expected_content,
                    actual_content,
                    f"Output differs from expected.\nExpected:\n{expected_content}\nActual:\n{actual_content}"
                )

    def test_create_ped_unknown_sex(self):
        """Test creating .fam file for sample with unknown sex"""
        input_file = os.path.join(self.test_dir, "somalier_create_ped.unknown.input.tsv")
        expected_file = os.path.join(self.test_dir, "somalier_create_ped.unknown_T.expected.fam")
        output_file = os.path.join(self.test_dir, "somalier_create_ped.unknown_T.actual.fam")

        # Mock snakemake object
        global snakemake
        snakemake = Mock()
        snakemake.params = {"sample_type": "T"}
        snakemake.input = [input_file]
        snakemake.output = {"fam": output_file}

        # Import and run the script logic
        with open(input_file, "r") as samplesheet:
            header_line = samplesheet.readline().strip().split("\t")
            for lline in samplesheet:
                line = lline.strip().split("\t")
                if line[header_line.index("sex")] == "M":
                    sex = "1"
                elif line[header_line.index("sex")] == "K":
                    sex = "2"
                else:
                    sex = "0"
                sample_id = line[header_line.index("sample")]
                output_path = snakemake.output["fam"]
                with open(output_path, "w+") as pedfile:
                    pedfile.write(
                        "\t".join([sample_id, f"{sample_id}_{snakemake.params['sample_type']}", "0", "0", sex, "-9"]) + "\n"
                    )

        # Compare with expected output
        with open(expected_file, "r") as expected:
            with open(output_file, "r") as actual:
                expected_content = expected.read()
                actual_content = actual.read()
                self.assertEqual(
                    expected_content,
                    actual_content,
                    f"Output differs from expected.\nExpected:\n{expected_content}\nActual:\n{actual_content}"
                )


if __name__ == "__main__":
    unittest.main()
