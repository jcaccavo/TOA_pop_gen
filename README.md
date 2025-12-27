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
- **getInsertSizefromSAM.sh**: bash script to determine the read length distribution from mapping (.sam) files.
- **getInsertSizefromSAM.py**: python script to determine the read length distribution from mapping (.sam) files (referred to in getInsertSizefromSAM.sh).
- **plotFragSizes_args_fastq.R**: R script to plot read length distributions based on the output from getInsertSizefromSAM.py (referred to in getInsertSizefromSAM.sh).
- **08_merging.sh**: bash script to merge pair-end reads using [PEAR](https://cme.h-its.org/exelixis/web/software/pear/doc.html). Based on length distributions, modify the following script parameters (the rest remain unchanged): 1) **-n – 30**: specifies the minimum possible length of the assembled sequences. Setting this value to 0 disables the restriction and assembled sequences may be arbitrarily short (default: 50); 2) **-m – 310**: specifies the maximum possible length of the assembled sequences. Setting this value to 0 disables the restriction and assembled sequences may be arbitrarily long (default: 3); **-v – 10**: specifies the minimum overlap size. The minimum overlap may be set to 1 when the statistical test is used. However, further restricting the minimum overlap size to a proper value may reduce false-positive assembles (default: 10).
- **09_CorrectOrientation.sh**: The files to continue with are the *.unassembled.forward.fastq and *.unassembled.reverse.fastq. After using merging with [PEAR](https://cme.h-its.org/exelixis/web/software/pear/doc.html), R2 is inverted. This bash script corrects the orientation of R2.
- **SeqIO_reverseComplement.py**: python script to to correct the orientation of R2 (referred to in 09_CorrectOrientation.sh).
- **10_QualityFilter.sh**: bash script to remove low quality reads using [Trimmomatic](https://doi.org/10.1093/bioinformatics/btu170).
- **11_CheckRestSites.sh**: remove reads that don’t start and end with the correct restriction sites. Assure that the correct restriction enzyme sequences are indicated: XbaI **CTAGA**; EcoRI **AATTC**; MspI **CGG**.
- **12a_EditHeaders.sh**: first in a set of three bash scripts to remove undigested reads. This first script edits the file headers.
- **12b_SaveHeaders.sh**: second in a set of three bash scripts to remove undigested reads. This second script saves the headers of reads with intact restriction sites. Assure that the correct restriction enzyme sequences are indicated; note that these sequence indications include the base pair before the cut site. The first restriction site sequence is for the 1st enzyme (start) (e.g., XbaI or MspI). The second restriction site sequence is for the 3rd enzyme (middle) (e.g., ClaI or NheI). The third rescrition site sequence is for the 2nd enzyme (end, EcoRI). **XbaI** TCTAGA; **EcoRI** GAATTC; **MspI** CCGG; **ClaI** ATCGAT; **NheI** GCTAGC.
- **12c_3enzymesFilter.sh**: this in a set of three bash script to remove undigested reads. This third script filters out the reads indicated in the list created in the previous script.
- **Filter_reads.py**: python script to remove undigested read (referred to in 12c_3enzymesFilter.sh).
- **13_final_fastqc.sh**: bash script to check reads quality using fastqc after all pre-processing steps. Output can then be compiled using multiqc.
- 
  
### SNP calling
- ...

## WGR
Scripts and files required for the analysis of high-output sequencing data produced using whole-genome resequencing (WGR).
