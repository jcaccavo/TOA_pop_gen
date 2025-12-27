library(tidyverse)
library(ggplot2)
library(ggrepel)

setwd(".../PCA")
#Then we will use a combination of readr and the standard scan function to read in the data.
# read in data
pca <- read.delim("./subarea_p3_p1r0.6_populations.snps.2021.sorted_min10max120miss0.75_1SNPperlocus.vcf.KingClean_PCA.txt")
eigenval <- scan("./subarea_p3_p1r0.6_populations.snps.2021.sorted_min10max120miss0.75_1SNPperlocus.vcf.KingClean_PCA.eigenval")
# Read 10 items

# convert Individual and Population columns to factors
pca$Individual <- as.factor(pca$Individual)
pca$Population <- as.factor(pca$Population)

# check the data
str(pca)
# 'data.frame':	109 obs. of  12 variables:
# $ Individual: Factor w/ 109 levels "190","191","192",..: 1 2 3 4 5 6 7 8 9 10 ...
# $ Population: Factor w/ 3 levels "48.1","48.2",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ PC1       : num  0.00646 0.02908 -0.01759 -0.02764 0.0645 ...
# $ PC2       : num  -0.01922 0.01762 0.0383 0.00727 0.17342 ...
# $ PC3       : num  -0.0472 -0.0225 0.0911 -0.0114 -0.1616 ...
# $ PC4       : num  -0.0724 -0.0162 -0.0322 0.0577 0.184 ...
# $ PC5       : num  -0.046258 0.000785 -0.137121 0.012775 0.055294 ...
# $ PC6       : num  0.0336 -0.0306 0.0769 -0.0245 -0.0328 ...
# $ PC7       : num  0.0888 0.0181 0.0445 -0.0161 0.0793 ...
# $ PC8       : num  0.0184 -0.07 0.0311 0.0112 0.4575 ...
# $ PC9       : num  0.0511 0.0487 0.1013 -0.0647 0.0906 ...
# $ PC10      : num  0.00297 -0.02556 0.02805 -0.0207 -0.39605 ...

head(pca)
# Individual Population         PC1         PC2        PC3        PC4          PC5        PC6        PC7        PC8        PC9        PC10
# 1        190       48.1  0.00645988 -0.01922430 -0.0471502 -0.0724006 -0.046258200  0.0336109  0.0887875  0.0183548  0.0511423  0.00296609
# 2        191       48.1  0.02908220  0.01762130 -0.0225229 -0.0162311  0.000784949 -0.0306429  0.0180685 -0.0700020  0.0487243 -0.02556030
# 3        192       48.1 -0.01759190  0.03829710  0.0911426 -0.0321819 -0.137121000  0.0768926  0.0445357  0.0311477  0.1012950  0.02804720
# 4        193       48.1 -0.02763650  0.00726709 -0.0114448  0.0577293  0.012775100 -0.0245281 -0.0161011  0.0112307 -0.0646744 -0.02070280
# 5        194       48.1  0.06450220  0.17342000 -0.1615780  0.1840000  0.055293500 -0.0328385  0.0793269  0.4574970  0.0906397 -0.39605200
# 6        195       48.1 -0.07795620  0.14527600 -0.0952289 -0.0128802  0.153529000 -0.3898480  0.0505956  0.1706250  0.1831280  0.14504000

#Plotting the data
#Now that we have done our housekeeping, we have everything in place to actually visualise the data properly. 
  #First we will plot the eigenvalues. 
  #It is quite straightforward to translate these into percentage variance explained 
  #(although note, you could just plot these raw if you wished).

# first convert to percentage variance explained
pve <- data.frame(PC = 1:20, pve = eigenval/sum(eigenval)*100)
pve
# PC       pve
# 1   1 10.232930
# 2   2 10.159102
# 3   3 10.080985
# 4   4 10.042388
# 5   5  9.999924
# 6   6  9.962001
# 7   7  9.945015
# 8   8  9.888677
# 9   9  9.862694
# 10 10  9.826284
# 11 11 10.232930
# 12 12 10.159102
# 13 13 10.080985
# 14 14 10.042388
# 15 15  9.999924
# 16 16  9.962001
# 17 17  9.945015
# 18 18  9.888677
# 19 19  9.862694
# 20 20  9.826284

#double-checked and indeed, with rounding to 1 significant digit, the same amount of variance is explained by the 1st two axes

#with that done, it is very simple to create a bar plot showing the percentage of variance each principal component explains.

# make plot
a <- ggplot(pve, aes(PC, pve)) + geom_bar(stat = "identity")
a + ylab("Percentage variance explained") + theme_light()

#Cumulatively, they explain 100% of the variance but PC1, PC2 and possible PC3 together explain about 30% of the variance. 
  #We could calculate this with the cumsum function, like so:
# calculate the cumulative sum of the percentage variance explained
cumsum(pve$pve)
# [1]  10.51738  20.64443  30.70158  40.73659  50.76795  60.70696  70.58129  80.43788  90.23627 100.00000 110.51738 120.64443 130.70158 140.73659 150.76795 160.70696 170.58129 180.43788 190.23627
# [20] 200.00000

#Next we move on to actually plotting our PCA. 
  #Given the work we did earlier to get our data into shape, this doesn’t take much effort at all.

#colors: https://i.redd.it/ns6qgxqwfzp11.png

# 48.1 color = "#7EC97E"
# 48.2 color = "#BFAFD3""
# 48.4 color = "#FBBF87"
id <- c("#8B500A","#F6E8C2","#5AB5AD")

# new plot with appropriate colors
ggplot(pca, aes(PC1, PC2))+
  theme_classic()+
  geom_point(size=4, shape=21, color="black", aes(fill=factor(Population)))+
  scale_fill_manual("Management\nsubarea", values=c("#8B500A","#F6E8C2","#5AB5AD"))+
  theme(
    legend.position = c(0.05, 0.95),
    legend.justification = c(0, 1),
    legend.background = element_rect(fill = "white", color = "black"),
    text = element_text(size = 25)
  ) +
  theme(text=element_text(size=25))+
  labs(color=NULL,x="PC1 (10.2%)", y="PC2 (10.2%)")+
  geom_text(aes(label = Individual), size = 4, vjust = 2)

# 282 and 309 are outliers
# get their row position

which(pca$Individual=="282")
# [1] 77
which(pca$Individual=="309")
# [1] 94

length(pca$Individual)
# [1] 109

# create a subset without these 2 individuals
pca_no <- subset(pca, !(Individual %in% c("282","309")))

length(pca_no$Individual)
# [1] 107
# the subsetting seems to have worked

# didn't need to actually do this because the subsetting needs to be done to the vcf file before the pca is run

# PCA 2 outliers removed ####

# re-do plot with pca output from vcf without outliers
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/3RAD_pop_analysis/PCA2021")

#Then we will use a combination of readr and the standard scan function to read in the data.
# read in data
pca <- read.delim("subarea_p3_p1r0.6_populations.snps.2021.sorted_min10max120miss0.75_1SNPperlocus_n106.txt")
eigenval <- scan("subarea_p3_p1r0.6_populations.snps.2021.sorted_min10max120miss0.75_1SNPperlocus_n106.eigenval")
# Read 10 items

# convert Individual and Population columns to factors
pca$Individual <- as.factor(pca$Individual)
pca$Population <- as.factor(pca$Population)

# check the data
str(pca)
# 'data.frame':	106 obs. of  12 variables:
# $ Individual: Factor w/ 106 levels "190","191","192",..: 1 2 3 4 5 6 7 8 9 10 ...
# $ Population: Factor w/ 3 levels "48.1","48.2",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ PC1       : num  -0.0551 0.00135 -0.07712 0.02072 0.10806 ...
# $ PC2       : num  0.06648 0.03376 -0.07753 -0.00926 0.12072 ...
# $ PC3       : num  4.56e-02 1.77e-05 6.15e-02 -5.27e-02 -3.23e-01 ...
# $ PC4       : num  -0.047 0.0204 -0.074 0.028 0.0247 ...
# $ PC5       : num  0.07369 -0.00413 0.15063 -0.01651 0.25702 ...
# $ PC6       : num  0.03476 0.06313 -0.03106 -0.00209 -0.34783 ...
# $ PC7       : num  -0.0142 -0.056 -0.1441 0.0579 -0.0215 ...
# $ PC8       : num  -0.001312 -0.014576 0.090137 -0.000283 -0.44847 ...
# $ PC9       : num  -0.0995 -0.0109 -0.1876 -0.0172 -0.1047 ...
# $ PC10      : num  -0.0602 0.0363 -0.0924 -0.0453 0.1593 ...

head(pca)
# Individual Population        PC1         PC2        PC3        PC4         PC5         PC6        PC7          PC8
# 1        190       48.1 -0.0551046  0.06648420  0.0456260 -0.0470469  0.07369300  0.03475830 -0.0142200 -0.001312320
# 2        191       48.1  0.0013548  0.03375650  0.0000177  0.0204412 -0.00413296  0.06312800 -0.0559612 -0.014576000
# 3        192       48.1 -0.0771237 -0.07753450  0.0615367 -0.0739538  0.15063100 -0.03105870 -0.1441330  0.090137000
# 4        193       48.1  0.0207217 -0.00925679 -0.0526750  0.0279935 -0.01651500 -0.00209032  0.0578827 -0.000282706
# 5        194       48.1  0.1080630  0.12071900 -0.3226060  0.0247210  0.25702400 -0.34783000 -0.0215322 -0.448470000
# 6        195       48.1  0.2108800  0.17780000 -0.0637932  0.4046080  0.16107300 -0.08080370 -0.1688740  0.050941500
# PC9       PC10
# 1 -0.0994818 -0.0602102
# 2 -0.0108797  0.0362967
# 3 -0.1876020 -0.0923879
# 4 -0.0171987 -0.0453080
# 5 -0.1046680  0.1592520
# 6  0.2158400  0.0498056

#Plotting the data
#Now that we have done our housekeeping, we have everything in place to actually visualise the data properly. 
#First we will plot the eigenvalues. 
#It is quite straightforward to translate these into percentage variance explained 
#(although note, you could just plot these raw if you wished).

# first convert to percentage variance explained
pve <- data.frame(PC = 1:20, pve = eigenval/sum(eigenval)*100)
pve
# PC       pve
# 1   1 10.177967
# 2   2 10.148820
# 3   3 10.133992
# 4   4 10.060277
# 5   5 10.017488
# 6   6  9.976394
# 7   7  9.924200
# 8   8  9.887173
# 9   9  9.852434
# 10 10  9.821253
# 11 11 10.177967
# 12 12 10.148820
# 13 13 10.133992
# 14 14 10.060277
# 15 15 10.017488
# 16 16  9.976394
# 17 17  9.924200
# 18 18  9.887173
# 19 19  9.852434
# 20 20  9.821253

#with that done, it is very simple to create a bar plot showing the percentage of variance each principal component explains.

# make plot
a <- ggplot(pve, aes(PC, pve)) + geom_bar(stat = "identity")
a + ylab("Percentage variance explained") + theme_light()

#Cumulatively, they explain 100% of the variance but PC1, PC2 and possible PC3 together explain about 30% of the variance. 
#We could calculate this with the cumsum function, like so:
# calculate the cumulative sum of the percentage variance explained
cumsum(pve$pve)
# [1]  10.17797  20.32679  30.46078  40.52106  50.53855  60.51494  70.43914  80.32631  90.17875 100.00000 110.17797
# [12] 120.32679 130.46078 140.52106 150.53855 160.51494 170.43914 180.32631 190.17875 200.00000

#Next we move on to actually plotting our PCA. 
#Given the work we did earlier to get our data into shape, this doesn’t take much effort at all.

# new plot with appropriate colors
ggplot(pca, aes(PC1, PC2))+
  theme_classic()+
  geom_point(size=4, shape=21, color="black", aes(fill=factor(Population)))+
  scale_fill_manual("Management\nsubarea", values=c("#8B500A","#F6E8C2","#5AB5AD"))+
  theme(
    legend.position = c(0.95, 0.95),
    legend.justification = c(1, 1),
    legend.background = element_rect(fill = "white", color = "black"),
    text = element_text(size = 25)
  ) +
  theme(text=element_text(size=25))+
  labs(color=NULL,x="PC1 (10.2%)", y="PC2 (10.1%)")+
  geom_text(aes(label = Individual), size = 4, vjust = 2)

# PCA 5 outliers removed ####

# re-do plot with pca output from vcf without outliers
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/3RAD_pop_analysis/PCA2021")

#Then we will use a combination of readr and the standard scan function to read in the data.
# read in data
pca <- read.delim("subarea_p3_p1r0.6_populations.snps.2021.sorted_min10max120miss0.75_1SNPperlocus_n103.txt")
eigenval <- scan("subarea_p3_p1r0.6_populations.snps.2021.sorted_min10max120miss0.75_1SNPperlocus_n103.eigenval")
# Read 10 items

# convert Individual and Population columns to factors
pca$Individual <- as.factor(pca$Individual)
pca$Population <- as.factor(pca$Population)

# check the data
str(pca)
# 'data.frame':	103 obs. of  12 variables:
# $ Individual: Factor w/ 103 levels "190","191","192",..: 1 2 3 4 5 6 7 8 9 10 ...
# $ Population: Factor w/ 3 levels "48.1","48.2",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ PC1       : num  -0.0552 0.0275 -0.1283 0.0393 0.0626 ...
# $ PC2       : num  0.0516 0.0174 0.1069 -0.0206 0.0249 ...
# $ PC3       : num  0.0432 0.0577 -0.0386 -0.0421 -0.4916 ...
# $ PC4       : num  -0.00987 -0.06599 -0.04868 0.03798 -0.30924 ...
# $ PC5       : num  -0.00349 -0.02349 0.24494 -0.04053 -0.34587 ...
# $ PC6       : num  -0.10575 0.00494 -0.2321 -0.0312 0.04366 ...
# $ PC7       : num  0.0574 0.0144 0.071 0.0198 0.0257 ...
# $ PC8       : num  0.0595 0.0302 -0.3294 0.0587 -0.1622 ...
# $ PC9       : num  -0.1589 0.0448 -0.1492 -0.0331 -0.081 ...
# $ PC10      : num  0.0501 0.0134 -0.0477 -0.0196 0.2511 ...

head(pca)
# Individual Population        PC1        PC2        PC3         PC4         PC5         PC6        PC7        PC8
# 1        190       48.1 -0.0552013  0.0516463  0.0431806 -0.00986917 -0.00348793 -0.10574800  0.0573531  0.0594765
# 2        191       48.1  0.0274683  0.0173981  0.0577115 -0.06599260 -0.02348910  0.00493644  0.0144068  0.0302356
# 3        192       48.1 -0.1283200  0.1069440 -0.0386087 -0.04868070  0.24493600 -0.23210000  0.0709898 -0.3294000
# 4        193       48.1  0.0392953 -0.0206382 -0.0420578  0.03798070 -0.04053340 -0.03120360  0.0198493  0.0586885
# 5        194       48.1  0.0626457  0.0248801 -0.4916130 -0.30924100 -0.34586800  0.04366170  0.0256959 -0.1622300
# 6        195       48.1  0.3919850  0.2184220 -0.1254100 -0.20698800  0.03632300  0.19606200 -0.0911606  0.0983560
# PC9       PC10
# 1 -0.1588780  0.0501235
# 2  0.0447822  0.0134477
# 3 -0.1492100 -0.0476567
# 4 -0.0331391 -0.0196084
# 5 -0.0809649  0.2510530
# 6 -0.0091389 -0.1633950

#Plotting the data
#Now that we have done our housekeeping, we have everything in place to actually visualise the data properly. 
#First we will plot the eigenvalues. 
#It is quite straightforward to translate these into percentage variance explained 
#(although note, you could just plot these raw if you wished).

# first convert to percentage variance explained
pve <- data.frame(PC = 1:20, pve = eigenval/sum(eigenval)*100)
pve
# PC       pve
# 1   1 10.178223
# 2   2 10.155946
# 3   3 10.113378
# 4   4 10.055873
# 5   5  9.997764
# 6   6  9.964262
# 7   7  9.946044
# 8   8  9.883962
# 9   9  9.869716
# 10 10  9.834833
# 11 11 10.178223
# 12 12 10.155946
# 13 13 10.113378
# 14 14 10.055873
# 15 15  9.997764
# 16 16  9.964262
# 17 17  9.946044
# 18 18  9.883962
# 19 19  9.869716
# 20 20  9.834833

#double-checked and indeed, with rounding to 1 significant digit, the same amount of variance is explained by the 1st two axes

#with that done, it is very simple to create a bar plot showing the percentage of variance each principal component explains.

# make plot
a <- ggplot(pve, aes(PC, pve)) + geom_bar(stat = "identity")
a + ylab("Percentage variance explained") + theme_light()

#Cumulatively, they explain 100% of the variance but PC1, PC2 and possible PC3 together explain about 30% of the variance. 
#We could calculate this with the cumsum function, like so:
# calculate the cumulative sum of the percentage variance explained
cumsum(pve$pve)
# [1]  10.17822  20.33417  30.44755  40.50342  50.50118  60.46545  70.41149  80.29545  90.16517 100.00000 110.17822
# [12] 120.33417 130.44755 140.50342 150.50118 160.46545 170.41149 180.29545 190.16517 200.00000

#Next we move on to actually plotting our PCA. 
#Given the work we did earlier to get our data into shape, this doesn’t take much effort at all.

# new plot with appropriate colors
ggplot(pca, aes(PC1, PC2))+
  theme_classic()+
  geom_point(size=4, shape=21, color="black", aes(fill=factor(Population)))+
  scale_fill_manual("Management\nsubarea", values=c("#8B500A","#F6E8C2","#5AB5AD"))+
  theme(
    legend.position = c(0.05, 0.05),
    legend.justification = c(0, 0),
    legend.background = element_rect(fill = "white", color = "black"),
    text = element_text(size = 25)
  ) +
  theme(text=element_text(size=25))+
  labs(color=NULL,x="PC1 (10.2%)", y="PC2 (10.2%)")+
  geom_text(aes(label = Individual), size = 4, vjust = 2)
