# TOA_pop_gen
This repository contains data files and scripts used for 3RADseq and WGR data analysis from the paper Caccavo et al. 2026a "Whole-genome resequencing reveals exceptions to panmixia in the exploited top fish predator Antarctic toothfish (Dissostichus mawsoni)".

## 3RADseq
Scripts and files required for the analysis of high-output sequencing data produced using 3RADseq.
- **01_fastqc.sh** Bash script to check reads quality using fastqc. Output can then be compiled using multiqc.
- **02_AdapterTrimming.sh** Bash script to remove sequencing adapters.
- **02a_AdapterTrimming.sh** Alternative bash script to remove sequencing adapters. In this alternative script, the adapter sequence is adjusted for the Illumina Universal Adapter script, as opposed to the Nextera Transposase Sequence.
- **03_Demultiplexing.sh** Bash script for demultiplexing. Should be run in a flexbar conda environment.
- **04_Rename.sh** Bash script to rename demultiplexed files. Demultiplexing will have produced a lot of files, i.e., 2 reads x number of library pools x number of barcode combinations. Prepare renaming script using Excel following RenameIndividuals.xlsx example, and then replace the contents of the script uploaded here with your relevant input.
