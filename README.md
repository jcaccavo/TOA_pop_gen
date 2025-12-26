# TOA_pop_gen
This repository contains data files and scripts used for 3RADseq and WGR data analysis from the paper Caccavo et al. 2026a "Whole-genome resequencing reveals exceptions to panmixia in the exploited top fish predator Antarctic toothfish (Dissostichus mawsoni)".

## 3RADseq
Scripts and files required for the analysis of high-output sequencing data produced using 3RADseq.

### Preprocessing
- **01_fastqc.sh**: bash script to check reads quality using fastqc. Output can then be compiled using multiqc.
- **02_AdapterTrimming.sh**: bash script to remove sequencing adapters.
- **02a_AdapterTrimming.sh**: alternative bash script to remove sequencing adapters. In this alternative script, the adapter sequence is adjusted for the Illumina Universal Adapter script, as opposed to the Nextera Transposase Sequence.
- **03_Demultiplexing.sh**: bash script for demultiplexing. Should be run in a flexbar conda environment.
- **Internal_indexes_LIB_P5**: P5 internal indexes (referred to in 03_Demultiplexing.sh).
- **Internal_indexes_LIB_P7**: P7 internal indexes (referred to in 03_Demultiplexing.sh).
- **04_Rename.sh**: bash script to rename demultiplexed files. Demultiplexing will have produced a lot of files, i.e., 2 reads x number of library pools x number of barcode combinations. Prepare renaming script using Excel following RenameIndividuals.xlsx example, and then replace the contents of the script uploaded here with your relevant input.
- **RenameIndividuals.xlsx**: Excel file to prepare renaming script.
- **05_PCRduplicatesFilter.sh**: bash script to filter PCR duplicates.
- **filterPCRdups.py**: python script to filter PCR duplicates (referred to in 05_PCRduplicatesFilter.sh).
- **06_Concatenate_all.sh**: bash script to concatenate the 4 replicates per individual.
- **07_mapping.sh**: bash script to map concatenated reads to the _D. mawsoni_ referencegenome (read 1 only). The _D. mawsoni_ reference genome is available from GenBank accession number [JAAKFY000000000](https://www.ncbi.nlm.nih.gov/nuccore/JAAKFY000000000).

### SNP calling
- ...

## WGR
Scripts and files required for the analysis of high-output sequencing data produced using whole-genome resequencing (WGR).
