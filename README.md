# TOA_pop_gen
This repository contains data files and scripts used for 3RADseq and WGR data analysis from the paper Caccavo et al. 2026a "Whole-genome resequencing reveals exceptions to panmixia in the exploited top fish predator Antarctic toothfish (Dissostichus mawsoni)".

## 3RADseq
Scripts and files required for the analysis of high-output sequencing data produced using 3RADseq.

### Preprocessing
- **01_fastqc.sh**: bash script to check reads quality using fastqc. Output can then be compiled using multiqc.
- **02_AdapterTrimming.sh**: bash script to remove sequencing adapters.
- **02a_AdapterTrimming.sh**: alternative bash script to remove sequencing adapters. In this alternative script, the adapter sequence is adjusted for the Illumina Universal Adapter script, as opposed to the Nextera Transposase Sequence.
- **03_Demultiplexing.sh**: bash script for demultiplexing. Should be run in a flexbar conda environment.
- **Internal_indexes_LIB_P5**: P5 internal indexes (referred to in `03_Demultiplexing.sh`).
- **Internal_indexes_LIB_P7**: P7 internal indexes (referred to in `03_Demultiplexing.sh`).
- **04_Rename.sh**: bash script to rename demultiplexed files. Demultiplexing will have produced a lot of files, i.e., 2 reads x number of library pools x number of barcode combinations. Prepare renaming script using Excel following RenameIndividuals.xlsx example, and then replace the contents of the script uploaded here with your relevant input.
- **RenameIndividuals.xlsx**: Excel file to prepare renaming script.
- **05_PCRduplicatesFilter.sh**: bash script to filter PCR duplicates.
- **filterPCRdups.py**: python script to filter PCR duplicates (referred to in `05_PCRduplicatesFilter.sh`).
- **06_Concatenate_all.sh**: bash script to concatenate the 4 replicates per individual.
- **07_mapping.sh**: bash script to map concatenated reads to the _D. mawsoni_ reference genome (read 1 only). The _D. mawsoni_ reference genome is available from GenBank accession number [JAAKFY000000000](https://www.ncbi.nlm.nih.gov/nuccore/JAAKFY000000000).
- **getInsertSizefromSAM.sh**: bash script to determine the read length distribution from mapping (.sam) files.
- **getInsertSizefromSAM.py**: python script to determine the read length distribution from mapping (.sam) files (referred to in `getInsertSizefromSAM.sh`).
- **plotFragSizes_args_fastq.R**: R script to plot read length distributions based on the output from getInsertSizefromSAM.py (referred to in `getInsertSizefromSAM.sh`).
- **08_merging.sh**: bash script to merge pair-end reads using [PEAR](https://cme.h-its.org/exelixis/web/software/pear/doc.html). Based on length distributions, modify the following script parameters (the rest remain unchanged):
    - **-n – 30**: specifies the minimum possible length of the assembled sequences. Setting this value to 0 disables the restriction and assembled sequences may be arbitrarily short (default: 50);
    - **-m – 310**: specifies the maximum possible length of the assembled sequences. Setting this value to 0 disables the restriction and assembled sequences may be arbitrarily long (default);
    - **-v – 10**: specifies the minimum overlap size. The minimum overlap may be set to 1 when the statistical test is used. However, further restricting the minimum overlap size to a proper value may reduce false-positive assembles (default: 10).
- **09_CorrectOrientation.sh**: The files to continue with are the *.unassembled.forward.fastq and *.unassembled.reverse.fastq. After using merging with [PEAR](https://cme.h-its.org/exelixis/web/software/pear/doc.html), R2 is inverted. This bash script corrects the orientation of R2.
- **SeqIO_reverseComplement.py**: python script to to correct the orientation of R2 (referred to in `09_CorrectOrientation.sh`).
- **10_QualityFilter.sh**: bash script to remove low quality reads using [Trimmomatic](https://doi.org/10.1093/bioinformatics/btu170).
- **11_CheckRestSites.sh**: remove reads that don’t start and end with the correct restriction sites. Assure that the correct restriction enzyme sequences are indicated: XbaI **CTAGA**; EcoRI **AATTC**; MspI **CGG**.
- **12a_EditHeaders.sh**: first in a set of three bash scripts to remove undigested reads. This first script edits the file headers.
- **12b_SaveHeaders.sh**: second in a set of three bash scripts to remove undigested reads. This second script saves the headers of reads with intact restriction sites. Assure that the correct restriction enzyme sequences are indicated; note that these sequence indications include the base pair before the cut site.
    - The first restriction site sequence is for the 1st enzyme (start) (e.g., XbaI or MspI).
    - The second restriction site sequence is for the 3rd enzyme (middle) (e.g., ClaI or NheI).
    - The third rescrition site sequence is for the 2nd enzyme (end, EcoRI). **XbaI** TCTAGA; **EcoRI** GAATTC; **MspI** CCGG; **ClaI** ATCGAT; **NheI** GCTAGC.
- **12c_3enzymesFilter.sh**: this in a set of three bash script to remove undigested reads. This third script filters out the reads indicated in the list created in the previous script.
- **Filter_reads.py**: python script to remove undigested read (referred to in `12c_3enzymesFilter.sh`).
- **13_final_fastqc.sh**: bash script to check reads quality using fastqc after all pre-processing steps. Output can then be compiled using multiqc.
- **14_final_mapping.sh**: bash script to map fully pre-processed reads to the _D. mawsoni_ reference genome. The _D. mawsoni_ reference genome is available from GenBank accession number [JAAKFY000000000](https://www.ncbi.nlm.nih.gov/nuccore/JAAKFY000000000).
- **15_convert_sam_to_bam.sh**: bash script employing [samtools view](https://www.htslib.org/doc/samtools-view.html) to convert .sam files generated from mapping to .bam files.
- **16_sort_bam.sh**: bash script employing [samtools sort](https://www.htslib.org/doc/samtools-sort.html) to sort .bam files.
- **coverage.sh**: bash script employing [samtools depth](https://www.htslib.org/doc/samtools-depth.html) to check post-preprocessing coverage of each library.
  
### SNP calling
- **Create popmap file(s)**: create as many popmap files as potential population configurations. This can be done in Excel, saving each popmap sheet as tab-delimited text file (.txt). Column 1 of the popmap file must contain the individual sample names EXACTLY as they are written for the .bam files. Column 2 contains the population number to which the individual belongs (e.g. 1, 2, 5, etc.).
- **popmap.txt**: example popmap file.
- **17_Stacks.sh**: bash script to run [STACKS](https://catchenlab.life.illinois.edu/stacks/comp/genotypes.php).
    - **inPath**: location of the .bam files which represent the reads mapped to the genome (only the .bam files to be processed should be in the input folder).
    - **outPath**: where you want to save the output files.
    - **popmap**: the location of the popmap file to be used.
    - **Refmap**: the location of the Refmap file, which is a [STACKS](https://catchenlab.life.illinois.edu/stacks/comp/genotypes.php) file. This is either located in the directory where [STACKS](https://catchenlab.life.illinois.edu/stacks/comp/genotypes.php) downloaded, or you can copy the file to your scripts folder.
    - **PREFIX**: how you want the output files to be labelled. This should be based on your popmap file name.
    - Each $Refmap run refers to a different run of [STACKS](https://catchenlab.life.illinois.edu/stacks/comp/genotypes.php).
    - The standard bash script runs [STACKS](https://catchenlab.life.illinois.edu/stacks/comp/genotypes.php) 3 times with 3 different sets of parameters. For each $Refmap line, change the name of the $popmap file after --popmap based on the name of the popmap file given in the script header.
- **[STACKS](https://catchenlab.life.illinois.edu/stacks/comp/genotypes.php) output files of note**:
    - **gstacks.log** is a summary of the first part of the [STACKS](https://catchenlab.life.illinois.edu/stacks/comp/genotypes.php) analysis which uses the software `gstacks`. This includes: 1) total number of loci; 2) average number of sites per locus; and 3) sequencing depth statistics: minimum, maximum, average, and standard deviation.
    - **populations.log** is a summary of the second part of the [STACKS](https://catchenlab.life.illinois.edu/stacks/comp/genotypes.php) analysis which uses the software `populations`. This includes: 1) population configurations analyzed (based on the popmap file); 2) loci kept; 3) sites identified on kept loci; 4) variant sites identified on kept loci; 5) genomic sites; 6) genomic sites covered by multiple loci; 7) percent of genomic sites covered by multiple loci; 8) average genotyped sites per locus in bp; 9) samples per locus; 10) nucleotide diversity or pi; 11) all sites identified on kept loci; 12) variant sites identified on kept loci; 13) polymorphic sites identified on kept loci; and 14) private alleles.
    - **populations.sumstats_summary.tsv** includes a lot of the info found in the **populations.log** file, as well as observed and expected hetero- and homozygosity.
    - **populations.snps.vcf** will be used for downstream filtering and subsequent population structure analyses.
- **Sort .vcf files** by running the following command for each .vcf file: `cat FILENAME.vcf | awk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1V -k2,2n"}' > FILENAME.SORTED.vcf`
- **Filter .vcf files** using [VCFtools](https://vcftools.github.io/index.html). Navigate to folder with .vcf files, and run each filtering command separately for each individual .vcf file. After each filtering step, count the number of SNPs remaining. To count SNPs in a .vcf file: `vcftools --vcf FILENAME.vcf`
    - **Minimum coverage**: minimum depth to call a genotype – reduces genotype miscalls. Check a minimum coverage of 10 and 15 to see how SNP numbers change. A minimum coverage of 10 is standard. `vcftools --vcf FILENAME.SORTED.vcf --min-meanDP 10 --minDP 10 --recode --stdout > FILENAME.SORTED_mincov10.vcf`
    - **Maximum coverage**: maximum depth to call a genotype – removes SNPs derived from RAD loci representing collapsed paralogs. Check maximum coverage at 80, 100, and 120. A maximum coverage of 120 is standard. `vcftools --vcf FILENAME.SORTED.vcf --max-meanDP 120 --maxDP 120 --recode --stdout > FILENAME.SORTED_maxcov120.vcf`
    - **Missingness**: excludes sites based on the proportion of missing data. Check 0.75, 0.8, 0.9, and 0.95, allowing 25%, 20%, 10%, and 5% of missing data at sites, respectively. A maximum of 25% missing data allowable at sites is standard. `vcftools --vcf FILENAME.SORTED.vcf --max-missing 0.75 --recode --stdout > FILENAME.SORTED_miss0.75.vcf`
    - **1 SNP per locus**: reduce linkage among SNPs. `vcftools --vcf FILENAME.SORTED.vcf --thin 500 --recode --stdout > FILENAME.SORTED_1SNPperlocus.vcf`
    - **Minimum Allele Frequency (MAF)**: include only sites with a MAF greater than or equal to the "--maf" value. Allele frequency is defined as the number of times an allele appears over all individuals at that site, divided by the total number of non-missing alleles at that site. Check MAF values of 0.01, 0.05, and 0.1. MAF = 0.01 is standard. This filtering step is not included in the combined filtering process, nor is it necessarily required for downstream analyses. `vcftools --vcf FILENAME.SORTED.vcf --maf 0.1 --recode --stdout > FILENAME.SORTED.vcf_maf0.1.vcf`
    - **Combine filtering steps**: once a set of filtering parameters has been decided on, perform filtering steps iteratively, e.g.,
        - Min coverage = 10 + Max coverage = 120 `vcftools --vcf FILENAME.SORTED.vcf --min-meanDP 10 --minDP 10 --max-meanDP 120 --maxDP 120 --recode --stdout > FILENAME.SORTED_min10max120.vcf`
        - Min coverage = 10 + Max coverage = 120 + Missingness = 0.75 `vcftools --vcf FILENAME.SORTED.vcf --max-missing 0.75 --min-meanDP 10 --minDP 10 --max-meanDP 120 --maxDP 120 --recode --stdout > FILENAME.SORTED_min10max120miss0.75.vcf`
        - Min coverage = 10 + Max coverage = 120 + Missingness = 0.75 + 1 SNP/locus `vcftools --vcf FILENAME.SORTED.vcf --max-missing 0.75 --min-meanDP 10 --minDP 10 --max-meanDP 120 --maxDP 120 --thin 500 --recode --stdout > FILENAME.SORTED_min10max120miss0.75_1SNPperlocus.vcf`
    - **Hardy-Weinberg Equilibrium (HWE)**: removes sites that depart from HWE for downstream demographic analyses. Perform HWE filter after min coverage, max coverage and missingness filters, but before 1 SNP/locus filter; do not include this filter in the combined iterative process described above. Use the software `perl`, and the relevant popmap file created for [STACKS](https://catchenlab.life.illinois.edu/stacks/comp/genotypes.php) `perl /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/05_HW_sites.pl -v /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/00_Stacks/FILENAME.SORTED_min10max120miss0.75.vcf -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/popmap_subarea.txt --hwe 0.01 -o FILENAME.SORTED_minmeanDPminDPmaxmeanDPmaxDPmiss0.75HWE`
    - **18_clean_related.sh**: bash script to clean related individuals using [plink2](https://www.cog-genomics.org/plink/2.0/). Downstream population structure analyses cannot include related individuals.
        - Update script:
            - **PREFIX**: with the relevant filename
            - **VCF_sorted**: with the file location (if needed)
            - **OUTpath**: with output file location
        - The 3 outputs files to use in downstream analyses:
            - FILENAME.vcf.KingClean.admix.fam
            - FILENAME.vcf.KingClean.admix.bim
            - FILENAME.vcf.KingClean.admix.bed
        - In addition to a log file (FILENAME.vcf.KingClean.admix.log) 01_clean_related.sh outputs 2 files that contain the sample IDs of individuals in the population that are unrelated (FILENAME.vcf.KingClean.admix.king.cutoff.in.id) and the sample IDs of individuals in the population that were removed due to being related to other individuals in the population (FILENAME.vcf.KingClean.admix.king.cutoff.out.id)
        - If there are no related individuals (indicated both in the FILENAME.vcf.KingClean.admix.king.cutoff.out.id  file, as well as in the FILENAME.vcf.KingClean.admix.log file), then subsequent steps can be carried out on the combined filtered vcf file created after combined filtering.
        - If there are related individuals, then filtering steps should be carried out on the .fam/.bim/.bed files created as outputs of the `01_clean_related.sh` script
     
### Population structure
#### Admixture
- Convert .fam/.bim/.bed (related individuals) files or .vcf (no related individuals) file to .ped file for analysis.
    - `.../plink --bfile FILENAME.SORTED_min10max120miss0.75_1SNPperlocus.vcf.KingClean.admix --double-id --allow-extra-chr --set-missing-var-ids @:# --recode 12 --out FILENAME.SORTED_min10max120miss0.75_1SNPperlocus.KingClean.admix`
    - `.../plink --vcf FILENAME.SORTED_min10max120miss0.75_1SNPperlocus.vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --make-bed --recode12 --out FILENAME.SORTED_min10max120miss0.75_1SNPperlocus`
- Create subfolders for different population configurations, Stacks parameters, and filter parameters (as needed).
- **Run_admixture.sh**: bash script to batch run Admixture.
    - Modify Path= to the folder where the .ped file is stored,
    - Admixture run can take from 30 minutes to 4 hours, depending on the number of SNPs in the .ped file
- **admixture-wrapper.py**: python script used to run Admixture (referred to in `Run_admixture.sh`).
- Output files include
    - Run log `admixture_wrapper.log`
    - Cross-validation error files: `FILENAME.CV_All.txt`, `FILENAME.CV_Avg.txt`
    - Output folder (with P and Q files) `Outputs-FILENAME`
        - In the `Outputs-FILENAME` folder there will be a P and a Q file for each k value of the Admixture run (normally k = 1 – 10). For each k value run, there are 5 replicates e.g. 4.1.Q – 4.5.Q).
    - In addition, there is `FILENAME.k.x.out` log file for each replicate of each k value replicate (x) run in admixture
- **cross_validation_plotting.R**: R script to plot the cross-validation (CV) errors using the `FILENAME.admix.CV_All.txt` file.
- **Rscript_PlotAdmixture.R**: R script to plot Admixture output.
    - Retain only the P and Q files of the first replicate of each k value run
    - Rename the retained P and Q files such that they end in FILENAME.1.P
    - Create the popfile.txt
        - Can use Excel to create a two-column Tab-delimited text file (.txt) with the first column listing the IDs of all individuals in the population, and the second column indicating the population to which each individual belongs
    - In the same folder containing the R script and appropriately-named P and Q files execute the following command `Rscript Rscript_PlotAdmixture.R -p .../INPUT -i .../popfile.txt -l pop1,pop2,pop3 -m 2 -k 10 -o .../PLOT
        - -p P and Q filename prefix
        - -i popfile
        - -m min k (population mixtures)
        - -k max k (population mixtures)
        - -l population subdivisions (the number of categories represented in the popfile.txt)
        - -o name of the plot file
- **popfile.txt**: example popfile.

#### Principal Components Analysis (PCA)
- **PCA.sh**: bash script to run PCA using [plink2](https://www.cog-genomics.org/plink/2.0/).
- Change the file extension of the FILENAME.eigenvec to FILENAME.txt
- Replace column 1 of FILENAME.txt with individual names and column 2 with population labels (label columns 1 and 2 “Individual” and “Population” respectively)
- **Rplot_PCA.R**: R script to plot PCA output.
    


## WGR
Scripts and files required for the analysis of high-output sequencing data produced using whole-genome resequencing (WGR).
