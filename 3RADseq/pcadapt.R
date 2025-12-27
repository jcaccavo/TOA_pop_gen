# outlier analysis using pcadapt https://bcm-uga.github.io/pcadapt/articles/pcadapt.html

install.packages("pcadapt")
library(pcadapt)

# Using bed file and associated bim/fam files created using plink in preparation for use in Admixture
# Using 3 population division hypothesis, with basic (p1r0.6) Stacks output, with basic filtering parameters:
# min10
# max120
# miss0.75
# 1SNPperlocus

# designate the path to the bed/bim/fam file as a variable called 'path_to_file'
path_to_file <- "/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/3RAD_outlier_analysis/pcadapt/3_subarea_p3_p1r0.6_populations.snps.SORTED_min10max120miss0.75_1SNPperlocus.vcf.KingClean.admix.bed"

# read in genotype data
file1 <- read.pcadapt(path_to_file, type = c("bed"))

# run pca to determine the best value k to use in the analysis
x <- pcadapt(input=file1, K=20)
# error that I was getting when I typed file1 <- read.pcadapt(path_to_file, type = "bed"), as indicated in the github manual, as opposed to the format shown above
# Error: Can't compute SVD.
# Are there SNPs or individuals with missing values only?
# You should use PLINK for proper data quality control.
x$singular.values
# [1] 0.1202069 0.1193419 0.1192534 0.1180544 0.1177948 0.1170420 0.1166564 0.1162259 0.1159726 0.1159178 0.1153148 0.1148809 0.1146769
# [14] 0.1146465 0.1140552 0.1135495 0.1133953 0.1130926 0.1130163 0.1127589

# visualize pca usign plots to determine the best value of k

# Scree plot
# The ‘scree plot’ displays in decreasing order the percentage of variance explained by each PC. 
# Up to a constant, it corresponds to the eigenvalues in decreasing order. 
# Recommend to keep PCs that correspond to eigenvalues to the left of the straight line (Cattell’s rule).
plot(x, option = c("screeplot"))
# plot with fewer K values
plot(x, option = c("screeplot"), K=10)

# Score plot
# The score plot displays the projections of the individuals onto the specified principal components. 
# Using the score plot, the choice of K can be limited to the values of K that correspond to a relevant level of population structure.
# create list of population names to color points based on 3 population subdivision (CCAMLR subarea)
poplist.names <- c(rep("48.1",40), rep("48.2",41), rep("48.4",27))
# By default, plot is done on the first 2 PCs
plot(x, option = c("scores"), pop = poplist.names)
# To plot on other PCs, specify with i and j for the x and y axes respectively
plot(x, option = c("scores"), pop = poplist.names, i = 3, j = 4)
# K = 2 best explain structure

# Running PCA again with the optimal number of values K (K = 2)
xK2 <- pcadapt(input=file1, K=2)
xK2$singular.values
# [1] 0.1202270 0.1193406
summary(xK2)
# Length Class  Mode   
# scores            216  -none- numeric
# singular.values     2  -none- numeric
# loadings        39788  -none- numeric
# zscores         39788  -none- numeric
# af              19894  -none- numeric
# maf             19894  -none- numeric
# chi2.stat       19894  -none- numeric
# stat            19894  -none- numeric
# gif                 1  -none- numeric
# pvalues         19894  -none- numeric
# pass             4324  -none- numeric

# use a Manhattan plot to display -log10 of the p-values
plot(xK2, option = c("manhattan"))

# use a Q-Q plot to check the expected uniform distribution of the p-values
plot(xK2, option = c("qqplot"))
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
hist(xK2$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))

# outliers can also be visualized by plotting a histogram of the test statistic Dj
plot(xK2, option = c("stat.distribution"))

# create a list of outliers

# Using q values

# install qvalue
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.16")
BiocManager::install(c("biocLite.R"))
install_github("jdstorey/qvalue")
library(qvalue)

# For a given alpha (real valued number between 0 and 1), SNPs with q-values less than alpha will be considered as outliers with an expected false discovery rate bounded by alpha. 
# The false discovery rate is defined as the percentage of false discoveries among the list of candidate SNPs. 
# In order to provide a list of candidate SNPs for the data at an expected false discovery rate lower than 10%:
qval <- qvalue(xK2$pvalues)$qvalues
alphaQ <- 0.1
outliersQ <- which(qval < alphaQ)
length(outliersQ)
# [1] 4
outliersQ
# [1]   377  4248 17343 17692

# subset outliers defined based on q values
# ...
# according to https://onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2Fmec.16822&file=mec16822-sup-0002-AppendixS2.pdf
# subsetting was done in R, but using a genlight-style file conversion of their original data
# their original data is a .csv file for some reason, but normally radiator accepts .vcf files
# however radiator isn't working at the moment
# so if it's not possible to load in the original file, it's not possible to subset it in R

# Using Benjamini-Hochberg Procedure
padjBH <- p.adjust(xK2$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH <- which(padjBH < alphaBH)
length(outliersBH)
# [1] 4
outliersBH
# [1]   377  4248 17343 17692

# Using Bonferroni correction
padjB <- p.adjust(xK2$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB <- which (padjB < alphaB)
length(outliersB)
# [1] 2
outliersB
# [1] 17343 17692

# Linkage Disequilibrium thinning
# create two plots in one window
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK2$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
# no indication of linkage disequilibrium in the dataset
# return settings to 1 plot per window
par(mfrow = c(1,1))


# how many outliers would we identify with 1 PC?
# Running PCA again with K = 1
xK1 <- pcadapt(input=file1, K=1)
summary(xK1)
# Length Class  Mode   
# scores            108  -none- numeric
# singular.values     1  -none- numeric
# loadings        19894  -none- numeric
# zscores         19894  -none- numeric
# af              19894  -none- numeric
# maf             19894  -none- numeric
# chi2.stat       19894  -none- numeric
# stat            19894  -none- numeric
# gif                 1  -none- numeric
# pvalues         19894  -none- numeric
# pass             4324  -none- numeric

# use a Manhattan plot to display -log10 of the p-values
plot(xK1, option = c("manhattan"))

# use a Q-Q plot to check the expected uniform distribution of the p-values
plot(xK1, option = c("qqplot"))
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
hist(xK1$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("blue"))

# outliers can also be visualized by plotting a histogram of the test statistic Dj
plot(xK1, option = c("stat.distribution"))

# create a list of outliers

# Using q values

# install qvalue
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.16")
BiocManager::install(c("biocLite.R"))
install_github("jdstorey/qvalue")
library(qvalue)

# For a given alpha (real valued number between 0 and 1), SNPs with q-values less than alpha will be considered as outliers with an expected false discovery rate bounded by alpha. 
# The false discovery rate is defined as the percentage of false discoveries among the list of candidate SNPs. 
# In order to provide a list of candidate SNPs for the data at an expected false discovery rate lower than 10%:
qval1 <- qvalue(xK1$pvalues)$qvalues
alphaQ1 <- 0.1
outliersQ1 <- which(qval1 < alphaQ1)
length(outliersQ1)
# [1] 2
outliersQ1
# [1]  4248 17692

# Using Benjamini-Hochberg Procedure
padjBH1 <- p.adjust(xK1$pvalues, method = c("BH"))
alphaBH1 <- 0.1
outliersBH1 <- which(padjBH1 < alphaBH1)
length(outliersBH1)
# [1] 2
outliersBH1
# [1]  4248 17692

# Using Bonferroni correction
padjB1 <- p.adjust(xK1$pvalues, method = c("bonferroni"))
alphaB1 <- 0.1
outliersB1 <- which (padjB1 < alphaB1)
length(outliersB1)
# [1] 1
outliersB1
# [1] 17692

# Linkage Disequilibrium thinning
for (i in 1:1)
  plot(xK1$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
# no indication of linkage disequilibrium in the dataset

# what if we try a crazy number of PCs?
x100 <- pcadapt(input=file1, K=100)
plot(x100, option = c("screeplot"))
plot(x100, option = c("manhattan"))
plot(x100, option = c("qqplot"))
hist(x100$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("red"))
plot(x100, option = c("stat.distribution"))
# outliers using q values
qval100 <- qvalue(x100$pvalues)$qvalues
alphaQ100 <- 0.1
outliersQ100 <- which(qval100 < alphaQ100)
length(outliersQ100)
# [1] 1268
# outliers using Benjamini-Hochberg Procedure
padjBH100 <- p.adjust(x100$pvalues, method = c("BH"))
alphaBH100 <- 0.1
outliersBH100 <- which(padjBH100 < alphaBH100)
length(outliersBH100)
# [1] 1268
# outliers using Bonferroni correction
padjB100 <- p.adjust(x100$pvalues, method = c("bonferroni"))
alphaB100 <- 0.1
outliersB100 <- which (padjB100 < alphaB100)
length(outliersB100)
# [1] 862
# Linkage Disequilibrium thinning
for (i in 1:1)
  plot(x100$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
# no indication of linkage disequilibrium in the dataset

# Clearly using an exaggerated number of PCs exaggerates the number of outliers
# It is thus best to be conservative and use the least number of PCs, thus 1 or 2.