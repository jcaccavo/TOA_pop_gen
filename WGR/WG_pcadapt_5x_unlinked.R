# WG outlier analysis using pcadapt https://bcm-uga.github.io/pcadapt/articles/pcadapt.html

# Using bed file and associated bim/fam files created using plink2
# https://www.cog-genomics.org/plink/2.0/data#make_pgen
# plink2 --vcf INPUT.vcf --make-bed --allow-extra-chr --out OUTPUT
# looped in script 26_convert_vcf_to_bed.sh

# navigate to folder with the .bed files on the server
# open R
# use the script below in R opened in terminal on the server

install.packages("pcadapt")
library(pcadapt)

# read in genotype data
path_to_file <- ("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/5x_TOA_only_filtered_SNPs_all_unlinked.bed")
filename <- read.pcadapt(path_to_file, type = "bed")

# run pca to determine the best value k to use in the analysis
x <- pcadapt(input=filename, K=20)
x$singular.values
# [1] 0.2844446 0.2283367 0.2217748 0.2212097 0.2202208 0.2196951 0.2175869 0.2171303 0.2167701 0.2167051 0.2164382 0.2162280 0.2160057 0.2157430 0.2154839 0.2150240 0.2145254 0.2142796 0.2138938 0.2130815

# visualize pca usign plots to determine the best value of k

# Scree plot
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/scree_plots")
#create pdf file
pdf("5x_unlinked_TOA_only_scree_all.pdf")
# The ‘scree plot’ displays in decreasing order the percentage of variance explained by each PC. 
# Up to a constant, it corresponds to the eigenvalues in decreasing order. 
# Recommend to keep PCs that correspond to eigenvalues to the left of the straight line (Cattell’s rule).
plot(x, option = c("screeplot"))
dev.off()
# plot with fewer K values
#create pdf file
pdf("5x_unlinked_TOA_only_scree_10.pdf")
plot(x, option = c("screeplot"), K=10)
dev.off()

# Score plot
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/score_plots")
# The score plot displays the projections of the individuals onto the specified principal components. 
# Using the score plot, the choice of K can be limited to the values of K that correspond to a relevant level of population structure.
# create list of population names to color points based on 11 temporal/geographic possible populations
poplist11 <- c("88.1_2020",
               "48.2_2019",
               "48.5_2013",
               "48.5_2013",
               "48.5_2013",
               "48.5_2013",
               "88.1_2020",
               "88.1_2020",
               "88.1_2020",
               "58.4.2_2019",
               "58.4.2_2019",
               "88.1_2020",
               "58.4.2_2019",
               "88.1_2020",
               "88.1_2020",
               "48.2_2019",
               "48.1_2001",
               "58.4.2_2001",
               "88.1_2001",
               "88.1_2001",
               "88.1_2001",
               "88.1_2001",
               "88.1_2001",
               "88.1_2001")
# By default, plot is done on the first 2 PCs
pdf("5x_unlinked_TOA_only_score_PC1_PC2_11pops.pdf")
plot(x, option = c("scores"), pop = poplist11)
dev.off()
# To plot on other PCs, specify with i and j for the x and y axes respectively
pdf("5x_unlinked_TOA_only_score_PC2_PC3_11pops.pdf")
plot(x, option = c("scores"), pop = poplist11, i = 2, j = 3)
dev.off()
pdf("5x_unlinked_TOA_only_score_PC3_PC4_11pops.pdf")
plot(x, option = c("scores"), pop = poplist11, i = 3, j = 4)
dev.off()
# unclear which k best explains the structure

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
pdf("5x_unlinked_TOA_only_score_PC1_PC2_3pops.pdf")
plot(x, option = c("scores"), pop = poplist3)
dev.off()
# To plot on other PCs, specify with i and j for the x and y axes respectively
pdf("5x_unlinked_TOA_only_score_PC2_PC3_3pops.pdf")
plot(x, option = c("scores"), pop = poplist3, i = 2, j = 3)
dev.off()
pdf("5x_unlinked_TOA_only_score_PC3_PC4_3pops.pdf")
plot(x, option = c("scores"), pop = poplist3, i = 3, j = 4)
dev.off()
# unclear which k best explains the structure

# Testing various optimal values of K

######################################################### K = 1
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/k1")
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
pdf("5x_unlinked_TOA_only_manhattan_k1.pdf")
plot(xK1, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("5x_unlinked_TOA_only_qq_k1.pdf")
plot(xK1, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("5x_unlinked_TOA_only_pval_hist_k1.pdf")
hist(xK1$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("5x_unlinked_TOA_only_test_stat_dj_histogram_k1.pdf")
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

# Linkage Disequilibrium thinning
# create two plots in one window
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK1$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
# Error in (function (cond)  : 
#             error in evaluating the argument 'x' in selecting a method for function 'plot': subscript out of bounds
# return settings to 1 plot per window
par(mfrow = c(1,1))

######################################################### K = 2
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/k2")
# Running PCA with the optimal number of values K (K = 2)
xK2 <- pcadapt(input=filename, K=2)
xK2$singular.values
# [1] 0.2748956 0.2206713
summary(xK2)
# Length  Class  Mode   
# scores               48 -none- numeric
# singular.values       2 -none- numeric
# loadings        4718018 -none- numeric
# zscores         4718018 -none- numeric
# af              2359009 -none- numeric
# maf             2359009 -none- numeric
# chi2.stat       2359009 -none- numeric
# stat            2359009 -none- numeric
# gif                   1 -none- numeric
# pvalues         2359009 -none- numeric
# pass            2359009 -none- numeric

# use a Manhattan plot to display -log10 of the p-values
pdf("5x_unlinked_TOA_only_manhattan_k2.pdf")
plot(xK2, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("5x_unlinked_TOA_only_qq_k2.pdf")
plot(xK2, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("5x_unlinked_TOA_only_pval_hist_k2.pdf")
hist(xK2$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("5x_unlinked_TOA_only_test_stat_dj_histogram_k2.pdf")
plot(xK2, option = c("stat.distribution"))
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
qval2 <- qvalue(xK2$pvalues)$qvalues
alphaQ <- 0.1
outliersQ2 <- which(qval2 < alphaQ)
length(outliersQ2)
# [1] 145927
#to view the outlier SNPs
#outliersQ2
#to save outliers to a text file
write.table(outliersQ2, "5x_unlinked_k2_Q_outliers.txt")

# Using Benjamini-Hochberg Procedure
padjBH2 <- p.adjust(xK2$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH2 <- which(padjBH2 < alphaBH)
length(outliersBH2)
# [1] 133954
#to view the outlier SNPs
#outliersBH2
#to save outliers to a text file
write.table(outliersBH2, "5x_unlinked_k2_BH_outliers.txt")

# Using Bonferroni correction
padjB2 <- p.adjust(xK2$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB2 <- which (padjB2 < alphaB)
length(outliersB2)
# [1] 26649
#outliersB2
#to save outliers to a text file
write.table(outliersB2, "5x_unlinked_k2_B_outliers.txt")

# Linkage Disequilibrium thinning
# create two plots in one window
pdf("5x_unlinked_TOA_only_linkage_disequilibrium_k2.pdf")
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK2$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
dev.off()
# no indication of linkage disequilibrium in the dataset
# return settings to 1 plot per window
par(mfrow = c(1,1))

######################################################### K = 3
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/k3")
# Running PCA with the optimal number of values K (K = 3)
xK3 <- pcadapt(input=filename, K=3)
xK3$singular.values
# [1] 0.2748956 0.2206713 0.2143296
summary(xK3)
# Length  Class  Mode   
# scores               72 -none- numeric
# singular.values       3 -none- numeric
# loadings        7077027 -none- numeric
# zscores         7077027 -none- numeric
# af              2359009 -none- numeric
# maf             2359009 -none- numeric
# chi2.stat       2359009 -none- numeric
# stat            2359009 -none- numeric
# gif                   1 -none- numeric
# pvalues         2359009 -none- numeric
# pass            2359009 -none- numeric

# use a Manhattan plot to display -log10 of the p-values
pdf("5x_unlinked_TOA_only_manhattan_k3.pdf")
plot(xK3, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("5x_unlinked_TOA_only_qq_k3.pdf")
plot(xK3, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("5x_unlinked_TOA_only_pval_hist_k3.pdf")
hist(xK3$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("5x_unlinked_TOA_only_test_stat_dj_histogram_k3.pdf")
plot(xK3, option = c("stat.distribution"))
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
qval3 <- qvalue(xK3$pvalues)$qvalues
alphaQ <- 0.1
outliersQ3 <- which(qval3 < alphaQ)
length(outliersQ3)
# [1] 179188
#to view the outlier SNPs
#outliersQ3
#to save outliers to a text file
write.table(outliersQ3, "5x_unlinked_k3_Q_outliers.txt")

# Using Benjamini-Hochberg Procedure
padjBH3 <- p.adjust(xK3$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH3 <- which(padjBH3 < alphaBH)
length(outliersBH3)
# [1] 175483
#to view the outlier SNPs
#outliersBH3
#to save outliers to a text file
write.table(outliersBH3, "5x_unlinked_k3_BH_outliers.txt")

# Using Bonferroni correction
padjB3 <- p.adjust(xK3$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB3 <- which (padjB3 < alphaB)
length(outliersB3)
# [1] 34035
#outliersB3
#to save outliers to a text file
write.table(outliersB3, "5x_unlinked_k3_B_outliers.txt")

# Linkage Disequilibrium thinning
# create two plots in one window
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK3$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
# Error in plot.new() : figure margins too large
# return settings to 1 plot per window
par(mfrow = c(1,1))

######################################################### K = 4
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/k4")
# Running PCA with the optimal number of values K (K = 4)
xK4 <- pcadapt(input=filename, K=4)
xK4$singular.values
# [1] 0.2748956 0.2206713 0.2143296 0.2137835
summary(xK4)
# Length  Class  Mode   
# scores               96 -none- numeric
# singular.values       4 -none- numeric
# loadings        9436036 -none- numeric
# zscores         9436036 -none- numeric
# af              2359009 -none- numeric
# maf             2359009 -none- numeric
# chi2.stat       2359009 -none- numeric
# stat            2359009 -none- numeric
# gif                   1 -none- numeric
# pvalues         2359009 -none- numeric
# pass            2359009 -none- numeric

# use a Manhattan plot to display -log10 of the p-values
pdf("5x_unlinked_TOA_only_manhattan_k4.pdf")
plot(xK4, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("5x_unlinked_TOA_only_qq_k4.pdf")
plot(xK4, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("5x_unlinked_TOA_only_pval_hist_k4.pdf")
hist(xK4$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("5x_unlinked_TOA_only_test_stat_dj_histogram_k4.pdf")
plot(xK4, option = c("stat.distribution"))
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
qval4 <- qvalue(xK4$pvalues)$qvalues
alphaQ <- 0.1
outliersQ4 <- which(qval4 < alphaQ)
length(outliersQ4)
# [1] 186524
#to view the outlier SNPs
outliersQ4

# Using Benjamini-Hochberg Procedure
padjBH4 <- p.adjust(xK4$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH4 <- which(padjBH4 < alphaBH)
length(outliersBH4)
# [1] 74396
#to view the outlier SNPs
outliersBH4

# Using Bonferroni correction
padjB4 <- p.adjust(xK4$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB4 <- which (padjB4 < alphaB)
length(outliersB4)
# [1] 39669
outliersB4

# Linkage Disequilibrium thinning
# create two plots in one window
pdf("5x_unlinked_TOA_only_linkage_disequilibrium_k4.pdf")
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK4$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
dev.off()
# no indication of linkage disequilibrium in the dataset
# return settings to 1 plot per window
par(mfrow = c(1,1))

######################################################### K = 5
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/k5")
# Running PCA with the optimal number of values K (K = 5)
xK5 <- pcadapt(input=filename, K=5)
xK5$singular.values
# [1] 0.2748956 0.2206713 0.2143296 0.2137835 0.2128278
summary(xK5)
# Length   Class  Mode   
# scores               120 -none- numeric
# singular.values        5 -none- numeric
# loadings        11795045 -none- numeric
# zscores         11795045 -none- numeric
# af               2359009 -none- numeric
# maf              2359009 -none- numeric
# chi2.stat        2359009 -none- numeric
# stat             2359009 -none- numeric
# gif                    1 -none- numeric
# pvalues          2359009 -none- numeric
# pass             2359009 -none- numeric

# use a Manhattan plot to display -log10 of the p-values
pdf("5x_unlinked_TOA_only_manhattan_k5.pdf")
plot(xK5, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("5x_unlinked_TOA_only_qq_k5.pdf")
plot(xK5, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("5x_unlinked_TOA_only_pval_hist_k5.pdf")
hist(xK5$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("5x_unlinked_TOA_only_test_stat_dj_histogram_k5.pdf")
plot(xK5, option = c("stat.distribution"))
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
qval5 <- qvalue(xK5$pvalues)$qvalues
alphaQ <- 0.1
outliersQ5 <- which(qval5 < alphaQ)
length(outliersQ5)
# [1] 218359
#to view the outlier SNPs
outliersQ5

# Using Benjamini-Hochberg Procedure
padjBH5 <- p.adjust(xK5$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH5 <- which(padjBH5 < alphaBH)
length(outliersBH5)
# [1] 218359
#to view the outlier SNPs
outliersBH5

# Using Bonferroni correction
padjB5 <- p.adjust(xK5$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB5 <- which (padjB5 < alphaB)
length(outliersB5)
# [1] 45035
outliersB5

# Linkage Disequilibrium thinning
# create two plots in one window
pdf("5x_unlinked_TOA_only_linkage_disequilibrium_k5.pdf")
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK5$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
dev.off()
# no indication of linkage disequilibrium in the dataset
# return settings to 1 plot per window
par(mfrow = c(1,1))

######################################################### K = 6
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/k6")
# Running PCA with the optimal number of values K (K = 6)
xK6 <- pcadapt(input=filename, K=6)
xK6$singular.values
# [1] 0.2748956 0.2206713 0.2143296 0.2137835 0.2128278 0.2123197
summary(xK6)
# Length   Class  Mode   
# scores               144 -none- numeric
# singular.values        6 -none- numeric
# loadings        14154054 -none- numeric
# zscores         14154054 -none- numeric
# af               2359009 -none- numeric
# maf              2359009 -none- numeric
# chi2.stat        2359009 -none- numeric
# stat             2359009 -none- numeric
# gif                    1 -none- numeric
# pvalues          2359009 -none- numeric
# pass             2359009 -none- numeric

# use a Manhattan plot to display -log10 of the p-values
pdf("5x_unlinked_TOA_only_manhattan_k6.pdf")
plot(xK6, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("5x_unlinked_TOA_only_qq_k6.pdf")
plot(xK6, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("5x_unlinked_TOA_only_pval_hist_k6.pdf")
hist(xK6$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("5x_unlinked_TOA_only_test_stat_dj_histogram_k6.pdf")
plot(xK6, option = c("stat.distribution"))
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
qval6 <- qvalue(xK6$pvalues)$qvalues
alphaQ <- 0.1
outliersQ6 <- which(qval6 < alphaQ)
length(outliersQ6)
# [1] 260345
#to view the outlier SNPs
outliersQ6

# Using Benjamini-Hochberg Procedure
padjBH6 <- p.adjust(xK6$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH6 <- which(padjBH6 < alphaBH)
length(outliersBH6)
# [1] 260345
#to view the outlier SNPs
outliersBH6

# Using Bonferroni correction
padjB6 <- p.adjust(xK6$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB6 <- which (padjB6 < alphaB)
length(outliersB6)
# [1] 58025
outliersB6

# Linkage Disequilibrium thinning
# create two plots in one window
pdf("5x_unlinked_TOA_only_linkage_disequilibrium_k6.pdf")
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK6$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
dev.off()
# no indication of linkage disequilibrium in the dataset
# return settings to 1 plot per window
par(mfrow = c(1,1))

######################################################### K = 7
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/k7")
# Running PCA with the optimal number of values K (K = 7)
xK7 <- pcadapt(input=filename, K=7)
xK7$singular.values
# [1] 0.2748956 0.2206713 0.2143296 0.2137835 0.2128278 0.2123197 0.2102824
summary(xK7)
# Length   Class  Mode   
# scores               168 -none- numeric
# singular.values        7 -none- numeric
# loadings        16513063 -none- numeric
# zscores         16513063 -none- numeric
# af               2359009 -none- numeric
# maf              2359009 -none- numeric
# chi2.stat        2359009 -none- numeric
# stat             2359009 -none- numeric
# gif                    1 -none- numeric
# pvalues          2359009 -none- numeric
# pass             2359009 -none- numeric

# use a Manhattan plot to display -log10 of the p-values
pdf("5x_unlinked_TOA_only_manhattan_k7.pdf")
plot(xK7, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("5x_unlinked_TOA_only_qq_k7.pdf")
plot(xK7, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("5x_unlinked_TOA_only_pval_hist_k7.pdf")
hist(xK7$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("5x_unlinked_TOA_only_test_stat_dj_histogram_k7.pdf")
plot(xK7, option = c("stat.distribution"))
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
qval7 <- qvalue(xK7$pvalues)$qvalues
alphaQ <- 0.1
outliersQ7 <- which(qval7 < alphaQ)
length(outliersQ7)
# [1] 300050
#to view the outlier SNPs
outliersQ7

# Using Benjamini-Hochberg Procedure
padjBH7 <- p.adjust(xK7$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH7 <- which(padjBH7 < alphaBH)
length(outliersBH7)
# [1] 300050
#to view the outlier SNPs
outliersBH7

# Using Bonferroni correction
padjB7 <- p.adjust(xK7$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB7 <- which (padjB7 < alphaB)
length(outliersB7)
# [1] 66182
outliersB7

# Linkage Disequilibrium thinning
# create two plots in one window
pdf("5x_unlinked_TOA_only_linkage_disequilibrium_k7.pdf")
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK7$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
dev.off()
# no indication of linkage disequilibrium in the dataset
# return settings to 1 plot per window
par(mfrow = c(1,1))

######################################################### K = 8
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/k8")
# Running PCA with the optimal number of values K (K = 8)
xK8 <- pcadapt(input=filename, K=8)
xK8$singular.values
# [1] 0.2748956 0.2206713 0.2143296 0.2137835 0.2128278 0.2123197 0.2102824 0.2098367
summary(xK8)
# Length   Class  Mode   
# scores               192 -none- numeric
# singular.values        8 -none- numeric
# loadings        18872072 -none- numeric
# zscores         18872072 -none- numeric
# af               2359009 -none- numeric
# maf              2359009 -none- numeric
# chi2.stat        2359009 -none- numeric
# stat             2359009 -none- numeric
# gif                    1 -none- numeric
# pvalues          2359009 -none- numeric
# pass             2359009 -none- numeric

# use a Manhattan plot to display -log10 of the p-values
pdf("5x_unlinked_TOA_only_manhattan_k8.pdf")
plot(xK8, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("5x_unlinked_TOA_only_qq_k8.pdf")
plot(xK8, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("5x_unlinked_TOA_only_pval_hist_k8.pdf")
hist(xK8$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("5x_unlinked_TOA_only_test_stat_dj_histogram_k8.pdf")
plot(xK8, option = c("stat.distribution"))
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
qval8 <- qvalue(xK8$pvalues)$qvalues
alphaQ <- 0.1
outliersQ8 <- which(qval8 < alphaQ)
length(outliersQ8)
# [1] 323429
#to view the outlier SNPs
outliersQ8

# Using Benjamini-Hochberg Procedure
padjBH8 <- p.adjust(xK8$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH8 <- which(padjBH8 < alphaBH)
length(outliersBH8)
# [1] 323429
#to view the outlier SNPs
outliersBH8

# Using Bonferroni correction
padjB8 <- p.adjust(xK8$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB8 <- which (padjB8 < alphaB)
length(outliersB8)
# [1] 72515
outliersB8

# Linkage Disequilibrium thinning
# create two plots in one window
pdf("5x_unlinked_TOA_only_linkage_disequilibrium_k8.pdf")
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK8$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
dev.off()
# no indication of linkage disequilibrium in the dataset
# return settings to 1 plot per window
par(mfrow = c(1,1))

######################################################### K = 9
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/k9")
# Running PCA with the optimal number of values K (K = 9)
xK9 <- pcadapt(input=filename, K=9)
xK9$singular.values
# [1] 0.2748956 0.2206713 0.2143296 0.2137835 0.2128278 0.2123197 0.2102824 0.2098367 0.2094865
summary(xK9)
# Length   Class  Mode   
# scores               216 -none- numeric
# singular.values        9 -none- numeric
# loadings        21231081 -none- numeric
# zscores         21231081 -none- numeric
# af               2359009 -none- numeric
# maf              2359009 -none- numeric
# chi2.stat        2359009 -none- numeric
# stat             2359009 -none- numeric
# gif                    1 -none- numeric
# pvalues          2359009 -none- numeric
# pass             2359009 -none- numeric

# use a Manhattan plot to display -log10 of the p-values
pdf("5x_unlinked_TOA_only_manhattan_k9.pdf")
plot(xK9, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("5x_unlinked_TOA_only_qq_k9.pdf")
plot(xK9, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("5x_unlinked_TOA_only_pval_hist_k9.pdf")
hist(xK9$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("5x_unlinked_TOA_only_test_stat_dj_histogram_k9.pdf")
plot(xK9, option = c("stat.distribution"))
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
qval9 <- qvalue(xK9$pvalues)$qvalues
alphaQ <- 0.1
outliersQ9 <- which(qval9 < alphaQ)
length(outliersQ9)
# [1] 333452
#to view the outlier SNPs
outliersQ9

# Using Benjamini-Hochberg Procedure
padjBH9 <- p.adjust(xK9$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH9 <- which(padjBH9 < alphaBH)
length(outliersBH9)
# [1] 333452
#to view the outlier SNPs
outliersBH9

# Using Bonferroni correction
padjB9 <- p.adjust(xK9$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB9 <- which (padjB9 < alphaB)
length(outliersB9)
# [1] 80055
outliersB9

# Linkage Disequilibrium thinning
# create two plots in one window
pdf("5x_unlinked_TOA_only_linkage_disequilibrium_k9.pdf")
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK9$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
dev.off()
# no indication of linkage disequilibrium in the dataset
# return settings to 1 plot per window
par(mfrow = c(1,1))

######################################################### K = 10
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/k10")
# Running PCA with the optimal number of values K (K = 10)
xK10 <- pcadapt(input=filename, K=10)
xK10$singular.values
# [1] 0.2748956 0.2206713 0.2143296 0.2137835 0.2128278 0.2123197 0.2102824 0.2098393 0.2094893 0.2094301
summary(xK10)
# Length   Class  Mode   
# scores               240 -none- numeric
# singular.values       10 -none- numeric
# loadings        23590090 -none- numeric
# zscores         23590090 -none- numeric
# af               2359009 -none- numeric
# maf              2359009 -none- numeric
# chi2.stat        2359009 -none- numeric
# stat             2359009 -none- numeric
# gif                    1 -none- numeric
# pvalues          2359009 -none- numeric
# pass             2359009 -none- numeric

# use a Manhattan plot to display -log10 of the p-values
pdf("5x_unlinked_TOA_only_manhattan_k10.pdf")
plot(xK10, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("5x_unlinked_TOA_only_qq_k10.pdf")
plot(xK10, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("5x_unlinked_TOA_only_pval_hist_k10.pdf")
hist(xK10$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("5x_unlinked_TOA_only_test_stat_dj_histogram_k10.pdf")
plot(xK10, option = c("stat.distribution"))
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
qval10 <- qvalue(xK10$pvalues)$qvalues
alphaQ <- 0.1
outliersQ10 <- which(qval10 < alphaQ)
length(outliersQ10)
# [1] 369548
#to view the outlier SNPs
outliersQ10

# Using Benjamini-Hochberg Procedure
padjBH10 <- p.adjust(xK10$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH10 <- which(padjBH10 < alphaBH)
length(outliersBH10)
# [1] 369548
#to view the outlier SNPs
outliersBH10

# Using Bonferroni correction
padjB10 <- p.adjust(xK10$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB10 <- which (padjB10 < alphaB)
length(outliersB10)
# [1] 94770
outliersB10

# Linkage Disequilibrium thinning
# create two plots in one window
pdf("5x_unlinked_TOA_only_linkage_disequilibrium_k10.pdf")
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK10$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
dev.off()
# no indication of linkage disequilibrium in the dataset
# return settings to 1 plot per window
par(mfrow = c(1,1))

######################################################### K = 11
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/WG_outlier_analysis/WG_pcadapt/unlinked_SNPs/downsampled_5X/k11")
# Running PCA with the optimal number of values K (K = 11)
xK11 <- pcadapt(input=filename, K=11)
xK11$singular.values
# [1] 0.2748956 0.2206713 0.2143296 0.2137835 0.2128278 0.2123197 0.2102824 0.2098410 0.2094929 0.2094318 0.2091729
summary(xK11)
# Length   Class  Mode   
# scores               264 -none- numeric
# singular.values       11 -none- numeric
# loadings        25949099 -none- numeric
# zscores         25949099 -none- numeric
# af               2359009 -none- numeric
# maf              2359009 -none- numeric
# chi2.stat        2359009 -none- numeric
# stat             2359009 -none- numeric
# gif                    1 -none- numeric
# pvalues          2359009 -none- numeric
# pass             2359009 -none- numeric

# use a Manhattan plot to display -log10 of the p-values
pdf("5x_unlinked_TOA_only_manhattan_k11.pdf")
plot(xK11, option = c("manhattan"))
dev.off()
# use a Q-Q plot to check the expected uniform distribution of the p-values
pdf("5x_unlinked_TOA_only_qq_k11.pdf")
plot(xK11, option = c("qqplot"))
dev.off()
# an excess of small p-values indicates the presence of outliers
# this can be visualized with a histogram
pdf("5x_unlinked_TOA_only_pval_hist_k11.pdf")
hist(xK11$pvalues, xlab = c("p-values"), main = NULL, breaks = 50, col = c("orange"))
dev.off()
# outliers can also be visualized by plotting a histogram of the test statistic Dj
pdf("5x_unlinked_TOA_only_test_stat_dj_histogram_k11.pdf")
plot(xK11, option = c("stat.distribution"))
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
qval11 <- qvalue(xK11$pvalues)$qvalues
alphaQ <- 0.1
outliersQ11 <- which(qval11 < alphaQ)
length(outliersQ11)
# [1] 386178
#to view the outlier SNPs
outliersQ11

# Using Benjamini-Hochberg Procedure
padjBH11 <- p.adjust(xK11$pvalues, method = c("BH"))
alphaBH <- 0.1
outliersBH11 <- which(padjBH11 < alphaBH)
length(outliersBH11)
# [1] 386178
#to view the outlier SNPs
outliersBH11

# Using Bonferroni correction
padjB11 <- p.adjust(xK11$pvalues, method = c("bonferroni"))
alphaB <- 0.1
outliersB11 <- which (padjB11 < alphaB)
length(outliersB11)
# [1] 101709
outliersB11

# Linkage Disequilibrium thinning
# create two plots in one window
pdf("5x_unlinked_TOA_only_linkage_disequilibrium_k11.pdf")
par(mfrow = c(2,1))
for (i in 1:2)
  plot(xK11$loadings[, i], pch = 19, cex = .3, ylab = paste0("Loadings PC", i))
dev.off()
# no indication of linkage disequilibrium in the dataset
# return settings to 1 plot per window
par(mfrow = c(1,1))