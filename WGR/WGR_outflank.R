setwd(".../INPUT_DIRECTORY")

library(vcfR)
library(OutFLANK)

obj.vcfR <- read.vcfR("FILENAME.vcf")
# Scanning file to determine attributes.
# File attributes:
#   meta lines: 1118
# header_line: 1119
# variant count: 2823321
# column count: 33
# Meta line 1118 read in.
# All meta lines processed.
# gt matrix initialized.
# Character matrix gt created.
# Character matrix gt rows: 2823321
# Character matrix gt cols: 33
# skip: 0
# nrows: 2823321
# row_num: 0
# Processed variant: 2823321
# All variants processed

### creation SNPmat
geno <- extract.gt(obj.vcfR) # Character matrix containing the genotypes
G <- matrix(NA, nrow = nrow(geno), ncol = ncol(geno))
G[geno %in% c("0/0", "0|0")] <- 0
G[geno  %in% c("0/1", "1/0", "1|0", "0|1")] <- 1
G[geno %in% c("1/1", "1|1")] <- 2
G[geno %in% NA] <- 9 # replace NA value by 9 

table(as.vector(G))
# 0        1        2        9 
# 40344406 17009368  6462703  3943227 
SNPmat_test<-t(G)

### creation lociNames
position <- getPOS(obj.vcfR) # Positions in bp
chromosome <- getCHROM(obj.vcfR) # Chromosome information
mat<-cbind(chromosome,position)

lociName_test<-apply(mat,1,paste,collapse="_")

#### creation list pop

#popNames_test<-c(rep(1:10,each=10),rep(11,9)) # I created artificial pop names as I did not known the composition of your  populations
# create list of population names to color points based on 11 temporal/geographic possible populations
popNames_real <- c("88.1_2020",
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

FstDataFrame<-MakeDiploidFSTMat(SNPmat_test,lociName_test,popNames_real)
# Calculating FSTs, may take a few minutes...
# [1] "10000 done of 2823321"
# [1] "20000 done of 2823321"
# [1] "30000 done of 2823321"
# [1] "40000 done of 2823321"
# [1] "50000 done of 2823321"
# [1] "60000 done of 2823321"
# [1] "70000 done of 2823321"
# [1] "80000 done of 2823321"
# [1] "90000 done of 2823321"
# [1] "100000 done of 2823321"
# [1] "110000 done of 2823321"
# [1] "120000 done of 2823321"
# [1] "130000 done of 2823321"
# [1] "140000 done of 2823321"
# [1] "150000 done of 2823321"
# [1] "160000 done of 2823321"
# [1] "170000 done of 2823321"
# [1] "180000 done of 2823321"
# [1] "190000 done of 2823321"
# [1] "200000 done of 2823321"
# [1] "210000 done of 2823321"
# [1] "220000 done of 2823321"
# [1] "230000 done of 2823321"
# [1] "240000 done of 2823321"
# [1] "250000 done of 2823321"
# [1] "260000 done of 2823321"
# [1] "270000 done of 2823321"
# [1] "280000 done of 2823321"
# [1] "290000 done of 2823321"
# [1] "300000 done of 2823321"
# [1] "310000 done of 2823321"
# [1] "320000 done of 2823321"
# [1] "330000 done of 2823321"
# [1] "340000 done of 2823321"
# [1] "350000 done of 2823321"
# [1] "360000 done of 2823321"
# [1] "370000 done of 2823321"
# [1] "380000 done of 2823321"
# [1] "390000 done of 2823321"
# [1] "400000 done of 2823321"
# [1] "410000 done of 2823321"
# [1] "420000 done of 2823321"
# [1] "430000 done of 2823321"
# [1] "440000 done of 2823321"
# [1] "450000 done of 2823321"
# [1] "460000 done of 2823321"
# [1] "470000 done of 2823321"
# [1] "480000 done of 2823321"
# [1] "490000 done of 2823321"
# [1] "500000 done of 2823321"
# [1] "510000 done of 2823321"
# [1] "520000 done of 2823321"
# [1] "530000 done of 2823321"
# [1] "540000 done of 2823321"
# [1] "550000 done of 2823321"
# [1] "560000 done of 2823321"
# [1] "570000 done of 2823321"
# [1] "580000 done of 2823321"
# [1] "590000 done of 2823321"
# [1] "600000 done of 2823321"
# [1] "610000 done of 2823321"
# [1] "620000 done of 2823321"
# [1] "630000 done of 2823321"
# [1] "640000 done of 2823321"
# [1] "650000 done of 2823321"
# [1] "660000 done of 2823321"
# [1] "670000 done of 2823321"
# [1] "680000 done of 2823321"
# [1] "690000 done of 2823321"
# [1] "700000 done of 2823321"
# [1] "710000 done of 2823321"
# [1] "720000 done of 2823321"
# [1] "730000 done of 2823321"
# [1] "740000 done of 2823321"
# [1] "750000 done of 2823321"
# [1] "760000 done of 2823321"
# [1] "770000 done of 2823321"
# [1] "780000 done of 2823321"
# [1] "790000 done of 2823321"
# [1] "800000 done of 2823321"
# [1] "810000 done of 2823321"
# [1] "820000 done of 2823321"
# [1] "830000 done of 2823321"
# [1] "840000 done of 2823321"
# [1] "850000 done of 2823321"
# [1] "860000 done of 2823321"
# [1] "870000 done of 2823321"
# [1] "880000 done of 2823321"
# [1] "890000 done of 2823321"
# [1] "900000 done of 2823321"
# [1] "910000 done of 2823321"
# [1] "920000 done of 2823321"
# [1] "930000 done of 2823321"
# [1] "940000 done of 2823321"
# [1] "950000 done of 2823321"
# [1] "960000 done of 2823321"
# [1] "970000 done of 2823321"
# [1] "980000 done of 2823321"
# [1] "990000 done of 2823321"
# [1] "1000000 done of 2823321"
# [1] "1010000 done of 2823321"
# [1] "1020000 done of 2823321"
# [1] "1030000 done of 2823321"
# [1] "1040000 done of 2823321"
# [1] "1050000 done of 2823321"
# [1] "1060000 done of 2823321"
# [1] "1070000 done of 2823321"
# [1] "1080000 done of 2823321"
# [1] "1090000 done of 2823321"
# [1] "1100000 done of 2823321"
# [1] "1110000 done of 2823321"
# [1] "1120000 done of 2823321"
# [1] "1130000 done of 2823321"
# [1] "1140000 done of 2823321"
# [1] "1150000 done of 2823321"
# [1] "1160000 done of 2823321"
# [1] "1170000 done of 2823321"
# [1] "1180000 done of 2823321"
# [1] "1190000 done of 2823321"
# [1] "1200000 done of 2823321"
# [1] "1210000 done of 2823321"
# [1] "1220000 done of 2823321"
# [1] "1230000 done of 2823321"
# [1] "1240000 done of 2823321"
# [1] "1250000 done of 2823321"
# [1] "1260000 done of 2823321"
# [1] "1270000 done of 2823321"
# [1] "1280000 done of 2823321"
# [1] "1290000 done of 2823321"
# [1] "1300000 done of 2823321"
# [1] "1310000 done of 2823321"
# [1] "1320000 done of 2823321"
# [1] "1330000 done of 2823321"
# [1] "1340000 done of 2823321"
# [1] "1350000 done of 2823321"
# [1] "1360000 done of 2823321"
# [1] "1370000 done of 2823321"
# [1] "1380000 done of 2823321"
# [1] "1390000 done of 2823321"
# [1] "1400000 done of 2823321"
# [1] "1410000 done of 2823321"
# [1] "1420000 done of 2823321"
# [1] "1430000 done of 2823321"
# [1] "1440000 done of 2823321"
# [1] "1450000 done of 2823321"
# [1] "1460000 done of 2823321"
# [1] "1470000 done of 2823321"
# [1] "1480000 done of 2823321"
# [1] "1490000 done of 2823321"
# [1] "1500000 done of 2823321"
# [1] "1510000 done of 2823321"
# [1] "1520000 done of 2823321"
# [1] "1530000 done of 2823321"
# [1] "1540000 done of 2823321"
# [1] "1550000 done of 2823321"
# [1] "1560000 done of 2823321"
# [1] "1570000 done of 2823321"
# [1] "1580000 done of 2823321"
# [1] "1590000 done of 2823321"
# [1] "1600000 done of 2823321"
# [1] "1610000 done of 2823321"
# [1] "1620000 done of 2823321"
# [1] "1630000 done of 2823321"
# [1] "1640000 done of 2823321"
# [1] "1650000 done of 2823321"
# [1] "1660000 done of 2823321"
# [1] "1670000 done of 2823321"
# [1] "1680000 done of 2823321"
# [1] "1690000 done of 2823321"
# [1] "1700000 done of 2823321"
# [1] "1710000 done of 2823321"
# [1] "1720000 done of 2823321"
# [1] "1730000 done of 2823321"
# [1] "1740000 done of 2823321"
# [1] "1750000 done of 2823321"
# [1] "1760000 done of 2823321"
# [1] "1770000 done of 2823321"
# [1] "1780000 done of 2823321"
# [1] "1790000 done of 2823321"
# [1] "1800000 done of 2823321"
# [1] "1810000 done of 2823321"
# [1] "1820000 done of 2823321"
# [1] "1830000 done of 2823321"
# [1] "1840000 done of 2823321"
# [1] "1850000 done of 2823321"
# [1] "1860000 done of 2823321"
# [1] "1870000 done of 2823321"
# [1] "1880000 done of 2823321"
# [1] "1890000 done of 2823321"
# [1] "1900000 done of 2823321"
# [1] "1910000 done of 2823321"
# [1] "1920000 done of 2823321"
# [1] "1930000 done of 2823321"
# [1] "1940000 done of 2823321"
# [1] "1950000 done of 2823321"
# [1] "1960000 done of 2823321"
# [1] "1970000 done of 2823321"
# [1] "1980000 done of 2823321"
# [1] "1990000 done of 2823321"
# [1] "2000000 done of 2823321"
# [1] "2010000 done of 2823321"
# [1] "2020000 done of 2823321"
# [1] "2030000 done of 2823321"
# [1] "2040000 done of 2823321"
# [1] "2050000 done of 2823321"
# [1] "2060000 done of 2823321"
# [1] "2070000 done of 2823321"
# [1] "2080000 done of 2823321"
# [1] "2090000 done of 2823321"
# [1] "2100000 done of 2823321"
# [1] "2110000 done of 2823321"
# [1] "2120000 done of 2823321"
# [1] "2130000 done of 2823321"
# [1] "2140000 done of 2823321"
# [1] "2150000 done of 2823321"
# [1] "2160000 done of 2823321"
# [1] "2170000 done of 2823321"
# [1] "2180000 done of 2823321"
# [1] "2190000 done of 2823321"
# [1] "2200000 done of 2823321"
# [1] "2210000 done of 2823321"
# [1] "2220000 done of 2823321"
# [1] "2230000 done of 2823321"
# [1] "2240000 done of 2823321"
# [1] "2250000 done of 2823321"
# [1] "2260000 done of 2823321"
# [1] "2270000 done of 2823321"
# [1] "2280000 done of 2823321"
# [1] "2290000 done of 2823321"
# [1] "2300000 done of 2823321"
# [1] "2310000 done of 2823321"
# [1] "2320000 done of 2823321"
# [1] "2330000 done of 2823321"
# [1] "2340000 done of 2823321"
# [1] "2350000 done of 2823321"
# [1] "2360000 done of 2823321"
# [1] "2370000 done of 2823321"
# [1] "2380000 done of 2823321"
# [1] "2390000 done of 2823321"
# [1] "2400000 done of 2823321"
# [1] "2410000 done of 2823321"
# [1] "2420000 done of 2823321"
# [1] "2430000 done of 2823321"
# [1] "2440000 done of 2823321"
# [1] "2450000 done of 2823321"
# [1] "2460000 done of 2823321"
# [1] "2470000 done of 2823321"
# [1] "2480000 done of 2823321"
# [1] "2490000 done of 2823321"
# [1] "2500000 done of 2823321"
# [1] "2510000 done of 2823321"
# [1] "2520000 done of 2823321"
# [1] "2530000 done of 2823321"
# [1] "2540000 done of 2823321"
# [1] "2550000 done of 2823321"
# [1] "2560000 done of 2823321"
# [1] "2570000 done of 2823321"
# [1] "2580000 done of 2823321"
# [1] "2590000 done of 2823321"
# [1] "2600000 done of 2823321"
# [1] "2610000 done of 2823321"
# [1] "2620000 done of 2823321"
# [1] "2630000 done of 2823321"
# [1] "2640000 done of 2823321"
# [1] "2650000 done of 2823321"
# [1] "2660000 done of 2823321"
# [1] "2670000 done of 2823321"
# [1] "2680000 done of 2823321"
# [1] "2690000 done of 2823321"
# [1] "2700000 done of 2823321"
# [1] "2710000 done of 2823321"
# [1] "2720000 done of 2823321"
# [1] "2730000 done of 2823321"
# [1] "2740000 done of 2823321"
# [1] "2750000 done of 2823321"
# [1] "2760000 done of 2823321"
# [1] "2770000 done of 2823321"
# [1] "2780000 done of 2823321"
# [1] "2790000 done of 2823321"
# [1] "2800000 done of 2823321"
# [1] "2810000 done of 2823321"
# [1] "2820000 done of 2823321"

head(FstDataFrame)
# LocusName        He          FST           T1         T2 FSTNoCorr   T1NoCorr   T2NoCorr
# 1 HiC_scaffold_1093_2618765 0.1527778 -0.044375457 -0.003460355 0.07797904 0.1613010 0.01268797 0.07866019
# 2 HiC_scaffold_1093_2618772 0.1527778 -0.044375457 -0.003460355 0.07797904 0.1613010 0.01268797 0.07866019
# 3 HiC_scaffold_1093_2618817 0.2777778 -0.076487252 -0.010765550 0.14074960 0.1192053 0.01691729 0.14191729
# 4 HiC_scaffold_1093_2618823 0.2777778 -0.076487252 -0.010765550 0.14074960 0.1192053 0.01691729 0.14191729
# 5 HiC_scaffold_1093_2618842 0.4243827  0.007462687  0.001623377 0.21753247 0.1758818 0.03853383 0.21908939
# 6     HiC_scaffold_10_51626 0.4687500 -0.023248504 -0.005516989 0.23730514 0.1037885 0.02484472 0.23937845
# meanAlleleFreq
# 1      0.9166667
# 2      0.9166667
# 3      0.8333333
# 4      0.8333333
# 5      0.6944444
# 6      0.6250000

pdf("FILENAME_Heterozygosity_FST.pdf")
plot(FstDataFrame$He, FstDataFrame$FST)
dev.off()

pdf("FILENAME_FST_FSTNoCorr.pdf")
plot(FstDataFrame$FST, FstDataFrame$FSTNoCorr)
abline(0,1)
dev.off()

output<-OutFLANK(FstDataFrame,LeftTrimFraction=0.05, RightTrimFraction=0.05, Hmin=0.1, NumberOfSamples=11, qthreshold=0.05)

str(output)
# List of 6
# $ FSTbar               : num 0.0181
# $ FSTNoCorrbar         : num 0.168
# $ dfInferred           : num 6.64
# $ numberLowFstOutliers : int 0
# $ numberHighFstOutliers: int 0
# $ results              :'data.frame':	2823321 obs. of  15 variables:
#   ..$ LocusName       : chr [1:2823321] "HiC_scaffold_1093_2618765" "HiC_scaffold_1093_2618772" "HiC_scaffold_1093_2618817" "HiC_scaffold_1093_2618823" ...
# ..$ He              : num [1:2823321] 0.153 0.153 0.278 0.278 0.424 ...
# ..$ FST             : num [1:2823321] -0.04438 -0.04438 -0.07649 -0.07649 0.00746 ...
# ..$ T1              : num [1:2823321] -0.00346 -0.00346 -0.01077 -0.01077 0.00162 ...
# ..$ T2              : num [1:2823321] 0.078 0.078 0.141 0.141 0.218 ...
# ..$ FSTNoCorr       : num [1:2823321] 0.161 0.161 0.119 0.119 0.176 ...
# ..$ T1NoCorr        : num [1:2823321] 0.0127 0.0127 0.0169 0.0169 0.0385 ...
# ..$ T2NoCorr        : num [1:2823321] 0.0787 0.0787 0.1419 0.1419 0.2191 ...
# ..$ meanAlleleFreq  : num [1:2823321] 0.917 0.917 0.833 0.833 0.694 ...
# ..$ indexOrder      : int [1:2823321] 1 2 3 4 5 6 7 8 9 10 ...
# ..$ GoodH           : chr [1:2823321] "goodH" "goodH" "goodH" "goodH" ...
# ..$ qvalues         : num [1:2823321] 0.884 0.884 0.884 0.884 0.884 ...
# ..$ pvalues         : num [1:2823321] 0.91 0.91 0.688 0.688 0.787 ...
# ..$ pvaluesRightTail: num [1:2823321] 0.455 0.455 0.656 0.656 0.394 ...
# ..$ OutlierFlag     : logi [1:2823321] FALSE FALSE FALSE FALSE FALSE FALSE ...

head(output$results)
# LocusName        He          FST           T1         T2 FSTNoCorr   T1NoCorr   T2NoCorr
# 1 HiC_scaffold_1093_2618765 0.1527778 -0.044375457 -0.003460355 0.07797904 0.1613010 0.01268797 0.07866019
# 2 HiC_scaffold_1093_2618772 0.1527778 -0.044375457 -0.003460355 0.07797904 0.1613010 0.01268797 0.07866019
# 3 HiC_scaffold_1093_2618817 0.2777778 -0.076487252 -0.010765550 0.14074960 0.1192053 0.01691729 0.14191729
# 4 HiC_scaffold_1093_2618823 0.2777778 -0.076487252 -0.010765550 0.14074960 0.1192053 0.01691729 0.14191729
# 5 HiC_scaffold_1093_2618842 0.4243827  0.007462687  0.001623377 0.21753247 0.1758818 0.03853383 0.21908939
# 6     HiC_scaffold_10_51626 0.4687500 -0.023248504 -0.005516989 0.23730514 0.1037885 0.02484472 0.23937845
# meanAlleleFreq indexOrder GoodH   qvalues   pvalues pvaluesRightTail OutlierFlag
# 1      0.9166667          1 goodH 0.8842727 0.9100128        0.4550064       FALSE
# 2      0.9166667          2 goodH 0.8842727 0.9100128        0.4550064       FALSE
# 3      0.8333333          3 goodH 0.8842727 0.6884839        0.6557580       FALSE
# 4      0.8333333          4 goodH 0.8842727 0.6884839        0.6557580       FALSE
# 5      0.6944444          5 goodH 0.8842727 0.7874188        0.3937094       FALSE
# 6      0.6250000          6 goodH 0.8842727 0.5350248        0.7324876       FALSE

readr::write_tsv(output$results, file = "FILENAME_OutFLANK_results.txt")
# 0 outiers flagged as TRUE; 0 outliers detected

pdf("FILENAME_OutFLANKResultsPlot.pdf")
OutFLANKResultsPlotter(output,withOutliers=TRUE,NoCorr=TRUE,Hmin=0.1,binwidth=0.005,Zoom=FALSE,RightZoomFraction=0.05,titletext=NULL)
dev.off()

pdf("FILENAME_PvaluesRightTail_histogram.pdf")
hist(output$results$pvaluesRightTail)
dev.off()

pdf("FILENAME_Pvalues_histogram.pdf")
hist(output$results$pvalues)
dev.off()

P1 <- pOutlierFinderChiSqNoCorr(FstDataFrame, Fstbar = output$FSTNoCorrbar, dfInferred = output$dfInferred, qthreshold = 0.05, Hmin = 0.1)
head(P1)
# LocusName        He          FST           T1         T2 FSTNoCorr   T1NoCorr   T2NoCorr
# 1 HiC_scaffold_1093_2618765 0.1527778 -0.044375457 -0.003460355 0.07797904 0.1613010 0.01268797 0.07866019
# 2 HiC_scaffold_1093_2618772 0.1527778 -0.044375457 -0.003460355 0.07797904 0.1613010 0.01268797 0.07866019
# 3 HiC_scaffold_1093_2618817 0.2777778 -0.076487252 -0.010765550 0.14074960 0.1192053 0.01691729 0.14191729
# 4 HiC_scaffold_1093_2618823 0.2777778 -0.076487252 -0.010765550 0.14074960 0.1192053 0.01691729 0.14191729
# 5 HiC_scaffold_1093_2618842 0.4243827  0.007462687  0.001623377 0.21753247 0.1758818 0.03853383 0.21908939
# 6     HiC_scaffold_10_51626 0.4687500 -0.023248504 -0.005516989 0.23730514 0.1037885 0.02484472 0.23937845
# meanAlleleFreq   pvalues pvaluesRightTail   qvalues OutlierFlag
# 1      0.9166667 0.9100128        0.4550064 0.8842727       FALSE
# 2      0.9166667 0.9100128        0.4550064 0.8842727       FALSE
# 3      0.8333333 0.6884839        0.6557580 0.8842727       FALSE
# 4      0.8333333 0.6884839        0.6557580 0.8842727       FALSE
# 5      0.6944444 0.7874188        0.3937094 0.8842727       FALSE
# 6      0.6250000 0.5350248        0.7324876 0.8842727       FALSE
tail(P1)
# LocusName         He          FST            T1         T2 FSTNoCorr    T1NoCorr
# 2823103 HiC_scaffold_1092_445687 0.09972299  0.038594902  0.0019883485 0.05151842 0.1595774 0.008244681
# 2823208  HiC_scaffold_1094_95387 0.09500000 -0.109935187 -0.0052697813 0.04793535 0.1055298 0.005112474
# 2823211  HiC_scaffold_1094_96498 0.09972299  0.181384248  0.0095238095 0.05250627 0.3026093 0.015986395
# 2823222 HiC_scaffold_1094_100666 0.09500000 -0.008544922 -0.0004154796 0.04862298 0.1728201 0.008487654
# 2823288 HiC_scaffold_1094_112365 0.09500000 -0.089240399 -0.0042802661 0.04796332 0.1243579 0.006065401
# 2823296 HiC_scaffold_1094_113953 0.09500000  0.217056102  0.0109292881 0.05035237 0.3217158 0.016304348
# T2NoCorr meanAlleleFreq pvalues pvaluesRightTail qvalues OutlierFlag
# 2823103 0.05166573      0.9473684      NA               NA      NA          NA
# 2823208 0.04844581      0.9500000      NA               NA      NA          NA
# 2823211 0.05282850      0.9473684      NA               NA      NA          NA
# 2823222 0.04911265      0.9500000      NA               NA      NA          NA
# 2823288 0.04877373      0.9500000      NA               NA      NA          NA
# 2823296 0.05067935      0.9500000      NA               NA      NA          NA

my_out <- P1$OutlierFlag==TRUE

pdf("FILENAME_Heterozygosity_FST2.pdf")
plot(P1$He, P1$FST, pch=19, col=rgb(0,0,0,0.1))
points(P1$He[my_out], P1$FST[my_out], col="blue")
dev.off()

pdf("FILENAME_PvaluesRightTail_histogram2.pdf")
hist(P1$pvaluesRightTail)
dev.off()

pdf("FILENAME_Pvalues_histogram2.pdf")
hist(P1$pvalues)
dev.off()
