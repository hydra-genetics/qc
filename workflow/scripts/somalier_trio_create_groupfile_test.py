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


class TestSomalierTrioCreateGroupfile(unittest.TestCase):
    def setUp(self):
        """Set up - read the script content and create temp dir"""
        self.script_path = os.path.join(SCRIPT_DIR, "somalier_trio_create_groupfile.py")
        with open(self.script_path, "r") as f:
            self.script_content = f.read()
        self.temp_dir = tempfile.mkdtemp()

    def tearDown(self):
        """Clean up temp dir"""
        shutil.rmtree(self.temp_dir)

    def run_script(self, input_content):
        """Helper to run the script with mocked environment"""
        input_file = os.path.join(self.temp_dir, "samples.tsv")
        output_file = os.path.join(self.temp_dir, "groups.txt")

        with open(input_file, "w") as f:
            f.write(input_content)

        mock_snakemake = Mock()
        mock_snakemake.input = {"samples": input_file}
        mock_snakemake.output = {"groups": output_file}

        global snakemake
        snakemake = mock_snakemake

        # Execute the script
        exec(self.script_content, globals())

        # Read output
        if os.path.exists(output_file):
            with open(output_file, "r") as f:
                return f.read()
        return ""

    def test_single_trio(self):
        """Test single complete trio"""
        input_content = """sample\ttrio\tfather\tmother\tsex
proband1\ttrio1\tfather1\tmother1\tM
father1\ttrio1\t.\t.\tM
mother1\ttrio1\t.\t.\tF
"""
        result = self.run_script(input_content)
        self.assertEqual(result.strip(), "father1,mother1,proband1")

    def test_multiple_trios(self):
        """Test multiple complete trios"""
        input_content = """sample\ttrio\tfather\tmother\tsex
proband1\ttrio1\tfather1\tmother1\tM
father1\ttrio1\t.\t.\tM
mother1\ttrio1\t.\t.\tF
proband2\ttrio2\tfather2\tmother2\tF
father2\ttrio2\t.\t.\tM
mother2\ttrio2\t.\t.\tF
"""
        result = self.run_script(input_content)
        lines = result.strip().split("\n")
        self.assertEqual(len(lines), 2)
        self.assertIn("father1,mother1,proband1", lines)
        self.assertIn("father2,mother2,proband2", lines)

    def test_incomplete_trio_skipped(self):
        """Test that incomplete trios are skipped"""
        input_content = """sample\ttrio\tfather\tmother\tsex
proband1\ttrio1\tfather1\t.\tM
father1\ttrio1\t.\t.\tM
proband2\ttrio2\tfather2\tmother2\tF
father2\ttrio2\t.\t.\tM
mother2\ttrio2\t.\t.\tF
"""
        result = self.run_script(input_content)
        # Only trio2 should be in output (complete)
        self.assertEqual(result.strip(), "father2,mother2,proband2")

    def test_no_trio_columns(self):
        """Test when trio columns don't exist - should create empty file"""
        input_content = """sample\tsex
sample1\tM
sample2\tF
"""
        # When columns are missing, script exits with code 0 after creating empty file
        # This is expected behavior - not an error
        try:
            result = self.run_script(input_content)
            self.assertEqual(result, "")
        except SystemExit as e:
            # Script exits successfully with empty file - this is correct
            self.assertEqual(e.code, 0, "Should exit successfully when columns missing")

    def test_samples_without_trio_info(self):
        """Test samples without trio information are skipped"""
        input_content = """sample\ttrio\tfather\tmother\tsex
sample1\t.\t.\t.\tM
sample2\t0\t.\t.\tF
proband1\ttrio1\tfather1\tmother1\tM
father1\ttrio1\t.\t.\tM
mother1\ttrio1\t.\t.\tF
"""
        result = self.run_script(input_content)
        self.assertEqual(result.strip(), "father1,mother1,proband1")

    def test_mixed_trio_and_non_trio(self):
        """Test mix of trio and non-trio samples"""
        input_content = """sample\ttrio\tfather\tmother\tsex
proband1\ttrio1\tfather1\tmother1\tM
father1\ttrio1\t.\t.\tM
mother1\ttrio1\t.\t.\tF
standalone1\t.\t.\t.\tF
standalone2\t0\t.\t.\tM
"""
        result = self.run_script(input_content)
        self.assertEqual(result.strip(), "father1,mother1,proband1")

    def test_zero_placeholder_for_missing_parents(self):
        """Test that 0 placeholder for parents is treated as missing"""
        input_content = """sample\ttrio\tfather\tmother\tsex
proband1\ttrio1\tfather1\t0\tM
father1\ttrio1\t.\t.\tM
"""
        result = self.run_script(input_content)
        # Incomplete trio should be skipped
        self.assertEqual(result, "")


if __name__ == "__main__":
    unittest.main()
