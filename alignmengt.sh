#!/bin/bash
set -euo pipefail

REF="/path/to/GRCh38.fa"
INPUT_DIR="/path/to/raw_reads"
OUTPUT_DIR="/path/to/output"
THREADS=8

mkdir -p "$OUTPUT_DIR"

echo "Reference Indexing Started"

# Detect reference extension automatically
REF_BASE="${REF%.*}"

# BWA index (runs only if index not present)
if [ ! -f "${REF}.bwt" ]; then
    bwa index "$REF"
fi

# SAMTOOLS indexing (runs only if missing)
if [ ! -f "${REF}.fai" ]; then
    samtools faidx "$REF"
fi

# Dictionary for GATK (needs gatk/picard)
if [ ! -f "${REF_BASE}.dict" ]; then
    gatk CreateSequenceDictionary -R "$REF" -O "${REF_BASE}.dict"
fi

echo "Reference Indexing Completed"
echo ""

# Alignment Pipeline
echo "Alignment Started"

for FILE1 in "$INPUT_DIR"/*_R1*.fastq.gz; do
    if [ ! -f "$FILE1" ]; then
        echo "No R1 files found in input directory!"
        exit 1
    fi

    FILE2="${FILE1/_R1/_R2}"
    BASE=$(basename "$FILE1" _R1.fastq.gz)

    if [ ! -f "$FILE2" ]; then
        echo "Skipping $FILE1 because matching R2 not found!"
        continue
    fi

    echo "Aligning: $BASE"

    bwa mem -t "$THREADS" "$REF" "$FILE1" "$FILE2" \
        | samtools view -bS - \
        | samtools sort -@ "$THREADS" -o "$OUTPUT_DIR/${BASE}_sorted.bam"

    # BAM index
    samtools index "$OUTPUT_DIR/${BASE}_sorted.bam"

done

echo "Alignment Completed"
echo ""

