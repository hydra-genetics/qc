#!/usr/bin/env bash
# Wrapper script for somalier extract with SM tag validation
# to ensure expected output filename

set -euo pipefail

EXTRA_ARGS="$1"
SITES="$2"
FASTA="$3"
OUTDIR="$4"
BAM="$5"
EXPECTED_OUTPUT="$6"

# Extract and validate
echo "INFO: Extracting SM tag from BAM file: $BAM" >&2
SM_TAG=$(samtools view -H "$BAM" | grep "^@RG" | sed -n 's/.*SM:\([^\t]*\).*/\1/p' | head -n1)

if [ -z "$SM_TAG" ]; then
    echo "ERROR: No SM tag found in BAM file $BAM" >&2
    echo "ERROR: Please ensure the BAM file has a valid @RG header with SM tag" >&2
    exit 1
fi

# catch multiple samples having the same SM tag
TEMP_DIR=$(mktemp -d "${OUTDIR}/somalier_tmp.XXXXXX")
trap "rm -rf $TEMP_DIR" EXIT

# Run somalier extract
echo "INFO: Running somalier extract..." >&2
somalier extract $EXTRA_ARGS -s "$SITES" -f "$FASTA" -d "$TEMP_DIR" "$BAM"

GENERATED_FILE="$TEMP_DIR/${SM_TAG}.somalier"
if [ ! -f "$GENERATED_FILE" ]; then
    echo "ERROR: Expected somalier output file not found: $GENERATED_FILE" >&2
    echo "ERROR: Files in temporary directory:" >&2
    ls -la "$TEMP_DIR"/*.somalier 2>&1 >&2 || echo "ERROR: No .somalier files found in $TEMP_DIR" >&2
    exit 1
fi

# move to final location
mv "$GENERATED_FILE" "$EXPECTED_OUTPUT"