# Script to prepare input file for bayescan following Laura Benestan's tutorial
# https://rpubs.com/lbenestan/outlier

# Load the necessary packages (install if not already installed)
if(!require(vcfR)){
  install.packages("vcfR")
  library(vcfR)
}
if(!require(adegenet)){
  install.packages("adegenet")
  library(adegenet)
}
if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}
if(!require(radiator)){
  install.packages("radiator")
  library(radiator)
}
# if(!require(hierfstat)){
#   install.packages("hierfstat")
#   library(hierfstat)
# }
# The "if" function didn't work for the package hierfstat, needed to use classic installation method
install.packages('hierfstat')
library(hierfstat)

# Set working directory as the location of your vcf file
setwd(".../INPUT_DIRECTORY")
toothfish <- genomic_converter(
  data = "FILENAME.vcf", strata = "popmap.txt",
  output = c("bayescan"), filename="FILENAME.geste")
# ################################################################################
# ######################### radiator::genomic_converter ##########################
# ################################################################################
# Execution date@time: 20230918@2120
# Folder created: 01_radiator_genomic_converter_20230918@2120
# Function call and arguments stored in: radiator_genomic_converter_args_20230918@2120.tsv
# Filters parameters file generated: filters_parameters_20230918@2120.tsv
# ✔ Reading VCF [27.3s]                                               
# ℹ Importing data: vcf.file
# Cleaning VCF
# LOCUS field empty... adding unique id instead
# 
# Filter monomorphic markers
# Number of individuals / strata / chrom / locus / SNP:
#   Blacklisted: 0 / 0 / 0 / 0 / 0
# 
# Filter common markers:
#   Number of individuals / strata / chrom / locus / SNP:
#   Blacklisted: 0 / 0 / 0 / 1 / 1
# 
# VCF statistics per individuals and markers
# Generating statistics
# ✔ SNPs per locus [5.8s]   
# ✔ Missing genotypes [1.9s]
# ✔ Heterozygosity [20.1s]  
# ✔ MAC [3s]                
# ✔ Coverage ... [2m 50.8s] 
# ✔ Generating figures [7s] 
# ✔ Writing files [1.4s]                                              
# ℹ Importing data: vcf.file
# VCF info:
#   Number of chromosome/contig/scaffold: 93
# Number of locus: 609097
# Number of markers: 609097
# Number of strata: 3
# Number of individuals: 37
# 
# Number of ind/strata:
#   88 = 18
# 48 = 11
# 58 = 8
# 
# Number of duplicate id: 0
# radiator Genomic Data Structure (GDS) file: radiator_20230918@2121.gds
# 
# Genotypes formats generated with 609097 SNPs: 
#   GT_BIN (the dosage of ALT allele: 0, 1, 2 NA): TRUE
# GT_VCF (the genotype coding VCFs: 0/0, 0/1, 1/1, ./.): TRUE
# GT_VCF_NUC (the genotype coding in VCFs, but with nucleotides: A/C, ./.): TRUE
# GT (the genotype coding 'a la genepop': 001002, 001001, 000000): TRUE
# LOCUS field empty... adding unique id instead
# DP column: cleaning and renaming to READ_DEPTH
# AD column: splitting into ALLELE_REF_DEPTH and ALLELE_ALT_DEPTH
# GQ column: Genotype Quality
# 
# 
# Stacks problem detected
# missing allele depth info
# number of genotypes with problem: 5130580 (prop: 0.2947)
# correcting problem by adding the read depth info into AD fields...
# 
# 
# fstcore package v0.9.14
# (OpenMP was not detected, using single threaded mode)
# 
# Tidy data file written: radiator_20230918@2126.rad
# 
# Computation time, overall: 388 sec
# 
# Writing tidy data set:
#   2x_unlinked_TOA_only_filtered_SNPs_all.geste.rad
# ✔ Importing data: vcf.file [7m 41.9s]
# Data is bi-allelic
# ✔ Preparing data [70ms]
# Calibrating REF/ALT alleles...equired for conversion
# ✔ Generating genotype format required for conversion [40.5s]
# Generating BayeScan file...
# ################################################################################
# ####################### radiator::filter_common_markers ########################
# ################################################################################
# Execution date@time: 20230918@2129
# Scanning for common markers...
# 
# Computation time, overall: 19 sec
# ####################### completed filter_common_markers ########################
# ################################################################################
# ######################### radiator::filter_monomorphic #########################
# ################################################################################
# Execution date@time: 20230918@2129
# Scanning for monomorphic markers...
# 
# Computation time, overall: 19 sec
# ######################### completed filter_monomorphic #########################
# Calibrating REF/ALT alleles...
# Generating new genotypes coding
# writing BayeScan file with:
#   Number of populations: 3
# Number of individuals: 37
# Number of biallelic markers: 609097
# Writting populations dictionary                                     
# Writting markers dictionary                                         
# ################################### RESULTS ####################################
# Data format of input: vcf.file
# Biallelic data
# Number of markers: 609097
# Number of chromosome/contig/scaffold: 93
# Number of strata: 3
# Number of individuals: 37
# 
# Computation time, overall: 609 sec
# ######################### completed genomic_converter ##########################
# ✔ Generating BayeScan [1m 46s]
