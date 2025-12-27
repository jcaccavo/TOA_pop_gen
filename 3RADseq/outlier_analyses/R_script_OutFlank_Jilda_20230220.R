setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/3RAD_outlier_analysis/OutFLANK")

library(vcfR)
library(OutFLANK)

obj.vcfR <- read.vcfR("3_subarea_p3_p1r0.6_populations.snps.SORTED_min10max120miss0.75_1SNPperlocus.vcf")

### creation SNPmat
geno <- extract.gt(obj.vcfR) # Character matrix containing the genotypes
G <- matrix(NA, nrow = nrow(geno), ncol = ncol(geno))
G[geno %in% c("0/0", "0|0")] <- 0
G[geno  %in% c("0/1", "1/0", "1|0", "0|1")] <- 1
G[geno %in% c("1/1", "1|1")] <- 2
G[geno %in% NA] <- 9 # replace NA value by 9 

table(as.vector(G))
# 0       1       2       9 
# 1884463  147431   27511  109041 
SNPmat_test<-t(G)

### creation lociNames
position <- getPOS(obj.vcfR) # Positions in bp
chromosome <- getCHROM(obj.vcfR) # Chromosome information
mat<-cbind(chromosome,position)

lociName_test<-apply(mat,1,paste,collapse="_")

#### creation list pop

#popNames_test<-c(rep(1:10,each=10),rep(11,9)) # I created artificial pop names as I did not known the composition of your  populations
popNames_real<-c(rep("48.1",40),rep("48.2",41),rep("48.4",28))

FstDataFrame<-MakeDiploidFSTMat(SNPmat_test,lociName_test,popNames_real)
# Calculating FSTs, may take a few minutes...
# [1] "10000 done of 19894"

head(FstDataFrame)
# LocusName          He          FST            T1          T2  FSTNoCorr     T1NoCorr    T2NoCorr meanAlleleFreq
# 1  scaffold1_18101 0.009302122  0.013470001  6.301413e-05 0.004678109 0.06356321 0.0002973616 0.004678203      0.9953271
# 2  scaffold1_61650 0.009851975 -0.005452486 -2.698036e-05 0.004948267 0.04961537 0.0002455213 0.004948492      0.9950495
# 3  scaffold1_75704 0.105860774  0.035716292  1.906057e-03 0.053366608 0.08984999 0.0047950435 0.053367214      0.9439252
# 4  scaffold1_86582 0.440088757  0.005226061  1.155287e-03 0.221062695 0.05066479 0.0112004433 0.221069567      0.6730769
# 5 scaffold1_134543 0.139551442 -0.016304909 -1.141124e-03 0.069986538 0.03322861 0.0023256067 0.069988080      0.9245283
# 6 scaffold1_207581 0.055001780 -0.020741244 -5.729892e-04 0.027625593 0.04977654 0.0013751496 0.027626460      0.9716981

plot(FstDataFrame$He, FstDataFrame$FST)

plot(FstDataFrame$FST, FstDataFrame$FSTNoCorr)
abline(0,1)

output<-OutFLANK(FstDataFrame,LeftTrimFraction=0.05, RightTrimFraction=0.05, Hmin=0.1, NumberOfSamples=3, qthreshold=0.05)

str(output)
# List of 6
# $ FSTbar               : num 0.000678
# $ FSTNoCorrbar         : num 0.0169
# $ dfInferred           : num 2.14
# $ numberLowFstOutliers : int 0
# $ numberHighFstOutliers: int 0
# $ results              :'data.frame':	19894 obs. of  15 variables:
#   ..$ LocusName       : chr [1:19894] "scaffold1_18101" "scaffold1_61650" "scaffold1_75704" "scaffold1_86582" ...
# ..$ He              : num [1:19894] 0.0093 0.00985 0.10586 0.44009 0.13955 ...
# ..$ FST             : num [1:19894] 0.006968 -0.002621 -0.000877 0.000401 -0.011276 ...
# ..$ T1              : num [1:19894] 3.26e-05 -1.30e-05 -4.66e-05 8.85e-05 -7.87e-04 ...
# ..$ T2              : num [1:19894] 0.00468 0.00495 0.05319 0.221 0.06982 ...
# ..$ FSTNoCorr       : num [1:19894] 0.02103 0.01245 0.01506 0.01304 0.00224 ...
# ..$ T1NoCorr        : num [1:19894] 9.85e-05 6.16e-05 8.01e-04 2.88e-03 1.56e-04 ...
# ..$ T2NoCorr        : num [1:19894] 0.00468 0.00495 0.0532 0.22102 0.06983 ...
# ..$ meanAlleleFreq  : num [1:19894] 0.995 0.995 0.944 0.673 0.925 ...
# ..$ indexOrder      : int [1:19894] 1 2 3 4 5 6 7 8 9 10 ...
# ..$ GoodH           : chr [1:19894] "lowH" "lowH" "goodH" "goodH" ...
# ..$ qvalues         : num [1:19894] NA NA 0.995 0.995 0.995 ...
# ..$ pvalues         : num [1:19894] NA NA 0.83 0.939 0.223 ...
# ..$ pvaluesRightTail: num [1:19894] NA NA 0.415 0.469 0.888 ...
# ..$ OutlierFlag     : logi [1:19894] FALSE FALSE FALSE FALSE FALSE FALSE ...

head(output$results)
# LocusName          He           FST            T1          T2   FSTNoCorr     T1NoCorr    T2NoCorr meanAlleleFreq indexOrder
# 1  scaffold1_18101 0.009302122  0.0069680631  3.263772e-05 0.004683901 0.021031218 9.852896e-05 0.004684891      0.9953271          1
# 2  scaffold1_61650 0.009851975 -0.0026209598 -1.296372e-05 0.004946172 0.012445649 6.156769e-05 0.004946925      0.9950495          2
# 3  scaffold1_75704 0.105860774 -0.0008765820 -4.662862e-05 0.053193680 0.015061015 8.013059e-04 0.053203975      0.9439252          3
# 4  scaffold1_86582 0.440088757  0.0004005375  8.851745e-05 0.220996640 0.013037983 2.881697e-03 0.221023239      0.6730769          4
# 5 scaffold1_134543 0.139551442 -0.0112758357 -7.872343e-04 0.069816046 0.002236285 1.561580e-04 0.069829228      0.9245283          5
# 6 scaffold1_207581 0.055001780  0.0009232177  2.555606e-05 0.027681516 0.019772345 5.474506e-04 0.027687694      0.9716981          6
# GoodH   qvalues   pvalues pvaluesRightTail OutlierFlag
# 1  lowH        NA        NA               NA       FALSE
# 2  lowH        NA        NA               NA       FALSE
# 3 goodH 0.9953709 0.8304794        0.4152397       FALSE
# 4 goodH 0.9953709 0.9387845        0.4693923       FALSE
# 5 goodH 0.9953709 0.2234951        0.8882525       FALSE
# 6  lowH        NA        NA               NA       FALSE

readr::write_tsv(output$results, file = "OutFLANK_results1.txt")

OutFLANKResultsPlotter(output,withOutliers=TRUE,NoCorr=TRUE,Hmin=0.1,binwidth=0.005,Zoom=FALSE,RightZoomFraction=0.05,titletext=NULL)

hist(output$results$pvaluesRightTail)
hist(output$results$pvalues)

P1 <- pOutlierFinderChiSqNoCorr(FstDataFrame, Fstbar = output$FSTNoCorrbar, dfInferred = output$dfInferred, qthreshold = 0.05, Hmin = 0.1)
head(P1)
# LocusName        He           FST            T1         T2   FSTNoCorr     T1NoCorr   T2NoCorr meanAlleleFreq   pvalues
# 3   scaffold1_75704 0.1058608 -0.0008765820 -4.662862e-05 0.05319368 0.015061015 0.0008013059 0.05320397      0.9439252 0.8304794
# 4   scaffold1_86582 0.4400888  0.0004005375  8.851745e-05 0.22099664 0.013037983 0.0028816972 0.22102324      0.6730769 0.9387845
# 5  scaffold1_134543 0.1395514 -0.0112758357 -7.872343e-04 0.06981605 0.002236285 0.0001561580 0.06982923      0.9245283 0.2234951
# 11 scaffold1_384207 0.1800000 -0.0326133114 -2.936045e-03 0.09002596 0.002310438 0.0002081043 0.09007137      0.9000000 0.2308771
# 15 scaffold1_595866 0.2736047  0.0066542980  9.173027e-04 0.13785115 0.022862943 0.0031524508 0.13788473      0.8364486 0.5156428
# 17 scaffold1_622843 0.3911111  0.0262071452  5.193550e-03 0.19817307 0.039090998 0.0077481147 0.19820713      0.7333333 0.1892620
# pvaluesRightTail   qvalues OutlierFlag
# 3        0.41523971 0.9953709       FALSE
# 4        0.46939225 0.9953709       FALSE
# 5        0.88825245 0.9953709       FALSE
# 11       0.88456145 0.9953709       FALSE
# 15       0.25782138 0.9812314       FALSE
# 17       0.09463101 0.9616495       FALSE
tail(P1)
# LocusName         He          FST            T1          T2   FSTNoCorr     T1NoCorr    T2NoCorr meanAlleleFreq pvalues
# 19886 scaffold5826_195 0.03635117  0.004900007  8.961616e-05 0.018288987 0.018648555 3.411223e-04 0.018292157      0.9814815      NA
# 19887 scaffold6147_319 0.01851690  0.009976318  9.311214e-05 0.009333317 0.023947995 2.235718e-04 0.009335721      0.9906542      NA
# 19889  scaffold6669_47 0.00995000 -0.001104637 -5.521155e-06 0.004998161 0.014068107 7.032501e-05 0.004998896      0.9950000      NA
# 19890  scaffold7184_79 0.01834705 -0.004805737 -4.421788e-05 0.009201061 0.009348826 8.603823e-05 0.009203105      0.9907407      NA
# 19892 scaffold7515_119 0.01047091 -0.002332311 -1.226578e-05 0.005259065 0.013693694 7.202881e-05 0.005259999      0.9947368      NA
# 19894 scaffold9749_130 0.01169550  0.006354512  3.745896e-05 0.005894860 0.024032104 1.416974e-04 0.005896173      0.9941176      NA
# pvaluesRightTail qvalues OutlierFlag
# 19886               NA      NA          NA
# 19887               NA      NA          NA
# 19889               NA      NA          NA
# 19890               NA      NA          NA
# 19892               NA      NA          NA
# 19894               NA      NA          NA

my_out <- P1$OutlierFlag==TRUE
plot(P1$He, P1$FST, pch=19, col=rgb(0,0,0,0.1))
points(P1$He[my_out], P1$FST[my_out], col="blue")

hist(P1$pvaluesRightTail)

hist(P1$pvalues)

plot(P1$LocusName[P1$He>0.1], P1$FST[P1$He>0.1],
     xlab="Position", ylab="FST", col=rgb(0,0,0,0.2))
points(P1$LocusName[my_out], P1$FST[my_out], col="magenta", pch=20)
# Error in plot.window(...) : need finite 'xlim' values
# In addition: Warning messages:
#   1: In xy.coords(x, y, xlabel, ylabel, log) : NAs introduced by coercion
# 2: In min(x) : no non-missing arguments to min; returning Inf
# 3: In max(x) : no non-missing arguments to max; returning -Inf