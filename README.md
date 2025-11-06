# Automated-RNA-Seq-Alignment-Workflow-using-BWA-and-SAMtools
Robust RNA-Seq alignment pipeline featuring BWA-MEM, SAMtools sorting/indexing, and GATK-compatible reference preprocessing.
 README.md (Copy-Paste Friendly)
#  BWA-MEM Alignment Pipeline for Paired-End RNA-Seq Data

This repository provides an automated workflow for aligning paired-end RNA-Seq reads against a reference genome (e.g., GRCh38) using BWA-MEM and SAMtools. The script performs reference indexing, alignment, BAM sorting, and BAM indexing — ensuring fast and accurate preprocessing for downstream analysis.

 Features
-  Automatic BWA + SAMtools reference indexing
-  Paired-end FASTQ auto-detection (`_R1` / `_R2`)
-  Multithreaded alignment (configurable)
-  Sorted and indexed BAM output files
-  Fail-safe execution (`set -euo pipefail`)
- Progress logs for each stage

# Dependencies
Ensure the following tools are installed and available in `$PATH`:

 Tool  Version (Recommended) 
 BWA  ≥ 0.7.17 
 SAMtools  ≥ 1.10 
GATK / Picard  ≥ 4.0 
 Update script paths
Edit these variables inside the script:
REF="/path/to/GRCh38.fa"
INPUT_DIR="/path/to/raw_reads"
OUTPUT_DIR="/path/to/output"
THREADS=8
 Run the pipeline
bash bwa_rnaseq_alignment.sh
 Outputs will be inside the output directory:
sample_sorted.bam
sample_sorted.bam.bai
Notes
•	FASTQ names must contain _R1 and _R2
•	BAM and FASTQ files should be excluded from GitHub using. gitignore
Example. gitignore:
*.fastq.gz
*.bam
*.bai
Recommended Next Steps
This workflow prepares data for:
•	Mark duplicates (Picard / SAMtools markdup)
•	RNA variant calling (GATK)
•	Gene expression quantification
•	Differential expression analysis
Citation Support
If you use this workflow, please cite:
•	Li & Durbin, BWA-MEM (2009)
•	Danecek et al., SAMtools (2021)
Contributing
Issues and pull requests are welcome to improve this workflow 
