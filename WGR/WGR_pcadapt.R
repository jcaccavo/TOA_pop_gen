# WGR outlier analysis using pcadapt https://bcm-uga.github.io/pcadapt/articles/pcadapt.html

# Using bed file and associated bim/fam files created using plink2
# https://www.cog-genomics.org/plink/2.0/data#make_pgen
# plink2 --vcf INPUT.vcf --make-bed --allow-extra-chr --out OUTPUT

# navigate to folder with the .bed files
# use the script below in R

install.packages("pcadapt")
library(pcadapt)

# read in genotype data
path_to_file <- ("/.../FILENAME.bed")
filename <- read.pcadapt(path_to_file, type = "bed")

# run pca to determine the best value k to use in the analysis
x <- pcadapt(input=filename, K=20)
x$singular.values
# [1] 0.2844446 0.2283367 0.2217748 0.2212097 0.2202208 0.2196951 0.2175869 0.2171303 0.2167701 0.2167051 0.2164382 0.2162280 0.2160057 0.2157430 0.2154839 0.2150240 0.2145254 0.2142796 0.2138938 0.2130815

# visualize pca usign plots to determine the best value of k

# Scree plot
setwd("/.../scree_plots")
#create pdf file
pdf("FILENAME_scree_all.pdf")
# The ‘scree plot’ displays in decreasing order the percentage of variance explained by each PC. 
# Up to a constant, it corresponds to the eigenvalues in decreasing order. 
# Recommend to keep PCs that correspond to eigenvalues to the left of the straight line (Cattell’s rule).
plot(x, option = c("screeplot"))
dev.off()
# plot with fewer K values
#create pdf file
pdf("FILENAME_scree_10.pdf")
plot(x, option = c("screeplot"), K=10)
dev.off()

# Score plot
setwd(".../score_plots")
# The score plot displays the projections of the individuals onto the specified principal components. 
# Using the score plot, the choice of K can be limited to the values of K that correspond to a relevant level of population structure.

# create list of population names to color points based on 3 circumpolar CCAMLR areas
poplist3 <- c("88",
              "48",
              "48",
              "48",
              "48",
              "48",
              "88",
              "88",
              "88",
              "58",
              "58",
              "88",
              "58",
              "88",
              "88",
              "48",
              "48",
              "58",
              "88",
              "88",
              "88",
              "88",
              "88",
              "88")
# By default, plot is done on the first 2 PCs
pdf("FILENAME_score_PC1_PC2_3pops.pdf")
plot(x, option = c("scores"), pop = poplist3)
dev.off()
# To plot on other PCs, specify with i and j for the x and y axes respectively
pdf("FILENAME_score_PC2_PC3_3pops.pdf")
plot(x, option = c("scores"), pop = poplist3, i = 2, j = 3)
dev.off()
pdf("FILENAME_score_PC3_PC4_3pops.pdf")
plot(x, option = c("scores"), pop = poplist3, i = 3, j = 4)
dev.off()

# Testing various optimal values of K

######################################################### K = 1
setwd(".../k1")
# Running PCA with the optimal number of values K (K = 1)
xK1 <- pcadapt(input=filename, K=1)
xK1$singular.values
# [1] 0.2748956
summary(xK1)
# Length  Class  Mode   
# scores               24 -none- numeric
# singular.values       1 -none- numeric
# loadings        2359009 -none- numeric
# zscores         2359009 -none- numeric
# af              2359009 -none- numeric
# maf             2359009 -none- numeric
# chi2.stat       2359009 -none- numeric
# stat            2359009 -none- numeric
# gif                   1 -none- numeric
# pvalues         2359009 -none- numeric
# pass            2359009 -none- numeric

# use a Manhattan plot to display -log10 of the p-values
pdf("FILENAME_manhattan_k1.pdf")
plot(xK1, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("FILENAME_qq_k1.pdf")
plot(xK1, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("FILENAME_pval_hist_k1.pdf")
hist(xK1$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("FILENAME_test_stat_dj_histogram_k1.pdf")
plot(xK1, option = c("stat.distribution"))
dev.off()

# create a list of outliers

# Using q values

# install qvalue
#if (!require("BiocManager", quietly = TRUE))
install.packages("BiocManager")
#BiocManager::install(version = "3.16")
#BiocManager::install(c("biocLite.R"))
#install_github("jdstorey/qvalue")
#BiocManager::install("qvalue")
library(qvalue)

# For a given alpha (real valued number between 0 and 1), SNPs with q-values less than alpha will be considered as outliers with an expected false discovery rate bounded by alpha. 
# The false discovery rate is defined as the percentage of false discoveries among the list of candidate SNPs. 
# In order to provide a list of candidate SNPs for the data at an expected false discovery rate lower than 10%:
qval1 <- qvalue(xK1$pvalues)$qvalues
alphaQ <- 0.1
outliersQ1 <- which(qval1 < alphaQ)
length(outliersQ1)
# [1] 65887
#to view the outlier SNPs
outliersQ1

# Using Benjamini-Hochberg Procedure
padjBH1 <- p.adjust(xK1$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH1 <- which(padjBH1 < alphaBH)
length(outliersBH1)
# [1] 65887
#to view the outlier SNPs
outliersBH1

# Using Bonferroni correction
padjB1 <- p.adjust(xK1$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB1 <- which (padjB1 < alphaB)
length(outliersB1)
# [1] 17698
outliersB1

# Repeat for K = n populations
