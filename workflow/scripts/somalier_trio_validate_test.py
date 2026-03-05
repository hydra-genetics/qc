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
from unittest.mock import Mock, patch
import pandas as pd

TEST_DIR = os.path.dirname(os.path.abspath(__file__))
SCRIPT_DIR = os.path.abspath(os.path.join(TEST_DIR, "../../workflow/scripts"))
sys.path.insert(0, SCRIPT_DIR)


class TestSomalierTrioValidate(unittest.TestCase):
    def setUp(self):
        """Set up - read the script content and create temp dir"""
        self.script_path = os.path.join(SCRIPT_DIR, "somalier_trio_validate.py")
        with open(self.script_path, "r") as f:
            self.script_content = f.read()
        self.temp_dir = tempfile.mkdtemp()

    def tearDown(self):
        """Clean up temp dir"""
        shutil.rmtree(self.temp_dir)

    def run_script(self, pairs_data, ped_data, threshold=0.4):
        """Helper to run the script with mocked environment"""
        pairs_file = os.path.join(self.temp_dir, "pairs.tsv")
        ped_file = os.path.join(self.temp_dir, "ped.tsv")
        output_file = os.path.join(self.temp_dir, "validation.txt")

        # Write input files
        with open(pairs_file, "w") as f:
            f.write(pairs_data)
        with open(ped_file, "w") as f:
            f.write(ped_data)

        mock_snakemake = Mock()
        mock_snakemake.input = {
            "pairs": pairs_file,
            "ped": ped_file,
        }
        mock_snakemake.output = {"validation": output_file}
        mock_snakemake.params = {"threshold": threshold}

        # Execute the script with isolated context
        context = {"snakemake": mock_snakemake, "__name__": "__main__"}
        exec(self.script_content, context)

        # Read output
        with open(output_file, "r") as f:
            return f.read()

    def test_valid_trio(self):
        """Test trio with all relationships above threshold"""
        pairs_data = (
            "#sample_a\tsample_b\trelatedness\tibs0\tibs2\thomalt_count"
            "\tshared_hets\tshared_hom_alts\tn\tx_ibs0\tx_ibs2\texpected_relatedness\n"
            "father1_N\tproband1_N\t0.45\t0.1\t0.8\t100\t50\t30\t1000\t0\t0\t0.5\n"
            "mother1_N\tproband1_N\t0.48\t0.1\t0.8\t100\t50\t30\t1000\t0\t0\t0.5\n"
            "father1_N\tmother1_N\t0.05\t0.9\t0.1\t10\t5\t3\t1000\t0\t0\t0\n"
        )
        ped_data = """trio1\tproband1_N\tfather1_N\tmother1_N\t1\t-9
trio1\tfather1_N\t0\t0\t1\t-9
trio1\tmother1_N\t0\t0\t2\t-9
"""
        result = self.run_script(pairs_data, ped_data, threshold=0.4)
        self.assertIn("validated successfully", result)
        self.assertNotIn("ISSUES", result)

    def test_low_father_relatedness(self):
        """Test detection of low father-child relatedness"""
        pairs_data = (
            "#sample_a\tsample_b\trelatedness\tibs0\tibs2\thomalt_count"
            "\tshared_hets\tshared_hom_alts\tn\tx_ibs0\tx_ibs2\texpected_relatedness\n"
            "father1_N\tproband1_N\t0.25\t0.5\t0.3\t100\t20\t15\t1000\t0\t0\t0.5\n"
            "mother1_N\tproband1_N\t0.48\t0.1\t0.8\t100\t50\t30\t1000\t0\t0\t0.5\n"
        )
        ped_data = """trio1\tproband1_N\tfather1_N\tmother1_N\t1\t-9
trio1\tfather1_N\t0\t0\t1\t-9
trio1\tmother1_N\t0\t0\t2\t-9
"""
        result = self.run_script(pairs_data, ped_data, threshold=0.4)
        self.assertIn("Total issues:", result)
        self.assertIn("Low father-child relatedness", result)
        self.assertIn("father1_N", result)
        self.assertIn("0.2500", result)

    def test_low_mother_relatedness(self):
        """Test detection of low mother-child relatedness"""
        pairs_data = (
            "#sample_a\tsample_b\trelatedness\tibs0\tibs2\thomalt_count"
            "\tshared_hets\tshared_hom_alts\tn\tx_ibs0\tx_ibs2\texpected_relatedness\n"
            "father1_N\tproband1_N\t0.45\t0.1\t0.8\t100\t50\t30\t1000\t0\t0\t0.5\n"
            "mother1_N\tproband1_N\t0.30\t0.4\t0.5\t100\t30\t20\t1000\t0\t0\t0.5\n"
        )
        ped_data = """trio1\tproband1_N\tfather1_N\tmother1_N\t1\t-9
trio1\tfather1_N\t0\t0\t1\t-9
trio1\tmother1_N\t0\t0\t2\t-9
"""
        result = self.run_script(pairs_data, ped_data, threshold=0.4)
        self.assertIn("Total issues:", result)
        self.assertIn("Low mother-child relatedness", result)
        self.assertIn("mother1_N", result)
        self.assertIn("0.3000", result)

    def test_multiple_trios(self):
        """Test validation of multiple trios"""
        pairs_data = (
            "#sample_a\tsample_b\trelatedness\tibs0\tibs2\thomalt_count"
            "\tshared_hets\tshared_hom_alts\tn\tx_ibs0\tx_ibs2\texpected_relatedness\n"
            "father1_N\tproband1_N\t0.45\t0.1\t0.8\t100\t50\t30\t1000\t0\t0\t0.5\n"
            "mother1_N\tproband1_N\t0.48\t0.1\t0.8\t100\t50\t30\t1000\t0\t0\t0.5\n"
            "father2_N\tproband2_N\t0.47\t0.1\t0.8\t100\t50\t30\t1000\t0\t0\t0.5\n"
            "mother2_N\tproband2_N\t0.46\t0.1\t0.8\t100\t50\t30\t1000\t0\t0\t0.5\n"
        )
        ped_data = """trio1\tproband1_N\tfather1_N\tmother1_N\t1\t-9
trio1\tfather1_N\t0\t0\t1\t-9
trio1\tmother1_N\t0\t0\t2\t-9
trio2\tproband2_N\tfather2_N\tmother2_N\t2\t-9
trio2\tfather2_N\t0\t0\t1\t-9
trio2\tmother2_N\t0\t0\t2\t-9
"""
        result = self.run_script(pairs_data, ped_data, threshold=0.4)
        self.assertIn("validated successfully", result)

    def test_threshold_sensitivity(self):
        """Test that threshold parameter works correctly"""
        pairs_data = (
            "#sample_a\tsample_b\trelatedness\tibs0\tibs2\thomalt_count"
            "\tshared_hets\tshared_hom_alts\tn\tx_ibs0\tx_ibs2\texpected_relatedness\n"
            "father1_N\tproband1_N\t0.35\t0.2\t0.7\t100\t40\t25\t1000\t0\t0\t0.5\n"
            "mother1_N\tproband1_N\t0.35\t0.2\t0.7\t100\t40\t25\t1000\t0\t0\t0.5\n"
        )
        ped_data = """trio1\tproband1_N\tfather1_N\tmother1_N\t1\t-9
trio1\tfather1_N\t0\t0\t1\t-9
trio1\tmother1_N\t0\t0\t2\t-9
"""
        # Should pass with threshold=0.3
        result = self.run_script(pairs_data, ped_data, threshold=0.3)
        self.assertIn("validated successfully", result)

        # Should fail with threshold=0.4
        result = self.run_script(pairs_data, ped_data, threshold=0.4)
        self.assertIn("Total issues:", result)

    def test_no_parents_defined(self):
        """Test samples without parents are skipped"""
        pairs_data = (
            "#sample_a\tsample_b\trelatedness\tibs0\tibs2\thomalt_count"
            "\tshared_hets\tshared_hom_alts\tn\tx_ibs0\tx_ibs2\texpected_relatedness\n"
            "sample1_N\tsample2_N\t0.05\t0.9\t0.1\t10\t5\t3\t1000\t0\t0\t0\n"
        )
        ped_data = """fam1\tsample1_N\t0\t0\t1\t-9
fam2\tsample2_N\t0\t0\t2\t-9
"""
        result = self.run_script(pairs_data, ped_data, threshold=0.4)
        self.assertIn("validated successfully", result)

    def test_missing_parent_pairs(self):
        """Test detection when expected parent-child pairs are missing from relatedness results"""
        # Only has mother-child pair, father-child pair is missing
        pairs_data = (
            "#sample_a\tsample_b\trelatedness\tibs0\tibs2\thomalt_count"
            "\tshared_hets\tshared_hom_alts\tn\tx_ibs0\tx_ibs2\texpected_relatedness\n"
            "mother1_N\tproband1_N\t0.48\t0.1\t0.8\t100\t50\t30\t1000\t0\t0\t0.5\n"
        )
        ped_data = """trio1\tproband1_N\tfather1_N\tmother1_N\t1\t-9
trio1\tfather1_N\t0\t0\t1\t-9
trio1\tmother1_N\t0\t0\t2\t-9
"""
        result = self.run_script(pairs_data, ped_data, threshold=0.4)
        self.assertIn("Total issues:", result)
        self.assertIn("Missing father-child pair", result)
        self.assertIn("father1_N - proband1_N", result)
        self.assertNotIn("Missing mother-child pair", result)

    def test_single_parent_validation(self):
        """Test validation of known parent when other parent is undefined"""
        # Only mother is defined (father is 0), and mother has good relatedness
        pairs_data = (
            "#sample_a\tsample_b\trelatedness\tibs0\tibs2\thomalt_count"
            "\tshared_hets\tshared_hom_alts\tn\tx_ibs0\tx_ibs2\texpected_relatedness\n"
            "mother1_N\tproband1_N\t0.48\t0.1\t0.8\t100\t50\t30\t1000\t0\t0\t0.5\n"
        )
        ped_data = """trio1\tproband1_N\t0\tmother1_N\t1\t-9
trio1\tmother1_N\t0\t0\t2\t-9
"""
        result = self.run_script(pairs_data, ped_data, threshold=0.4)
        self.assertIn("validated successfully", result)
        self.assertNotIn("father", result.lower())  # Should not check father when undefined


if __name__ == "__main__":
    unittest.main()
