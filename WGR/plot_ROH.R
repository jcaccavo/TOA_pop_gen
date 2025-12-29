# Create plots of plink ROH analysis outputs

# load necessary libraries
library(ggpubr)
library(dplyr)

# set working directory
setwd(".../ROH")

# extract data from hom file #############################################

# Import .hom file
roh_plink <- read.table(file = "FILENAME_ROH.hom", header = T)

# prepare ROH .hom data output into run-length categories #############################################
# if you've already done this and prepared the input .csv, skip to that
# small
ROHsmall<-roh_plink[roh_plink$KB >= 100 & roh_plink$KB <= 500,]
ROHsmall_cat<-aggregate(ROHsmall$KB ~ ROHsmall$IID, FUN = "sum")
colnames(ROHsmall_cat)<-c("Sample_ID", "sumKB")
# ROHsmall_cat$Category<-"Short"
ROHsmall_cat$Category<-"0.1-0.5"
# medium
ROHmedium<-roh_plink[roh_plink$KB > 500 & roh_plink$KB <= 1000,]
ROHmedium_cat<-aggregate(ROHmedium$KB ~ ROHmedium$IID, FUN = "sum")
colnames(ROHmedium_cat)<-c("Sample_ID", "sumKB")
# ROHmedium_cat$Category<-"Medium"
ROHmedium_cat$Category<-"0.5-1"
# long
ROHlong<-roh_plink[roh_plink$KB > 1000,]
ROHlong_cat<-aggregate(ROHlong$KB ~ ROHlong$IID, FUN = "sum")
colnames(ROHlong_cat)<-c("Sample_ID", "sumKB")
# ROHlong_cat$Category<-"Long"
ROHlong_cat$Category<-">1"
# combine all 3 categories and prepare dataframe
ROHcat<-rbind(ROHsmall_cat)
ROHcat$sumMB<-ROHcat$sumKB/1000
class(ROHcat$Sample_ID) = "character"
# output as .csv to add in pop and cohort categories in Excel
write.csv(ROHcat,"ROH_category_output.csv")
# this was done once and now the csv file is modified
# subsequently, this only needs to be imported

# import hom output with metadata #############################################

ROHcat <- read.csv("ROH_category_output.csv")
str(ROHcat)
# 'data.frame':	24 obs. of  11 variables:
# $ sample_ID  : chr  "1-425" "168" "312" "313" ...
# $ sumKB      : num  8890 1514 1290 1609 344 ...
# $ category1  : chr  "Short" "Short" "Short" "Short" ...
# $ category2  : chr  "0.1-0.5" "0.1-0.5" "0.1-0.5" "0.1-0.5" ...
# $ sumMB      : num  8.89 1.514 1.29 1.609 0.344 ...
# $ Froh       : num  0.009613 0.001637 0.001395 0.00174 0.000372 ...
# $ pop1       : int  88 48 48 48 48 48 88 88 88 88 ...
# $ cohort_2   : chr  "post2000" "post2000" "post2000" "post2000" ...
# $ coverage   : num  15.37 6.92 12.46 5.92 13.27 ...
# $ he_5x      : num  0.00218 0.00389 0.00315 0.00308 0.00519 ...
# $ sample_type: chr  "tissue" "otolith" "otolith" "otolith" ...

# make pop1, cohort_2, and category1, category2, and sample_type into factors
ROHcat$pop1 <- factor(ROHcat$pop1, levels=unique(ROHcat$pop1))
ROHcat$cohort_2 <- factor(ROHcat$cohort_2, levels=unique(ROHcat$cohort_2))
ROHcat$category1 <- factor(ROHcat$category1, levels=unique(ROHcat$category1))
ROHcat$category2 <- factor(ROHcat$category2, levels=unique(ROHcat$category2))
ROHcat$sample_type <- factor(ROHcat$sample_type, levels=unique(ROHcat$sample_type))

str(ROHcat)
# 'data.frame':	24 obs. of  11 variables:
# $ sample_ID  : chr  "1-425" "168" "312" "313" ...
# $ sumKB      : num  8890 1514 1290 1609 344 ...
# $ category1  : Factor w/ 1 level "Short": 1 1 1 1 1 1 1 1 1 1 ...
# $ category2  : Factor w/ 1 level "0.1-0.5": 1 1 1 1 1 1 1 1 1 1 ...
# $ sumMB      : num  8.89 1.514 1.29 1.609 0.344 ...
# $ Froh       : num  0.009613 0.001637 0.001395 0.00174 0.000372 ...
# $ pop1       : Factor w/ 3 levels "88","48","58": 1 2 2 2 2 2 1 1 1 1 ...
# $ cohort_2   : Factor w/ 2 levels "post2000","pre2000": 1 1 1 1 1 1 1 1 1 1 ...
# $ coverage   : num  15.37 6.92 12.46 5.92 13.27 ...
# $ he_5x      : num  0.00218 0.00389 0.00315 0.00308 0.00519 ...
# $ sample_type: Factor w/ 2 levels "tissue","otolith": 1 2 2 2 2 2 1 1 1 1 ...

# ROH category summary
# small 100-500 Kb 0.1-0.5 Mb #ca0020 red
# medium 500-1000 Kb 0.5-1 Mb #f7f7f7 off white
# long >1000 Kb >1 Mb #0571b0 blue

# colors of ROH categories
# https://colorbrewer2.org/#type=diverging&scheme=PRGn&n=5
colors_roh <- c("#ca0020")

# order by population
order_pop <- c("50-446",
               "4-456",
               "42-438",
               "35-431",
               "34-430",
               "33-429",
               "1-425",
               "9544",
               "9540",
               "9525",
               "9522",
               "9512",
               "9506",
               "433",
               "419",
               "412",
               "9479",
               "527",
               "315",
               "314",
               "313",
               "312",
               "168",
               "9432")

# order by cohort
order_cohort <- c("50-446",
                  "4-456",
                  "42-438",
                  "35-431",
                  "34-430",
                  "33-429",
                  "1-425",
                  "433",
                  "419",
                  "412",
                  "527",
                  "315",
                  "314",
                  "313",
                  "312",
                  "168",
                  "9544",
                  "9540",
                  "9525",
                  "9522",
                  "9512",
                  "9506",
                  "9479",
                  "9432")

# color individual axis labels by population
# NOTE that the stacked barplot will skip 0 values
# so remove colors for the skipped values to have proper color coding
color_lab_pop <- c("#00441b",
                   "#00441b",
                   "#00441b",
                   "#00441b",
                   "#00441b",
                   "#00441b",
                   "#00441b",
                   "#00441b",
                   "#00441b",
                   "#00441b",
                   "#00441b",
                   "#00441b",
                   "#00441b",
                   "#a6dba0",
                   "#a6dba0",
                   "#a6dba0",
                   "#a6dba0",
                   "#762a83",
                   "#762a83",
                   "#762a83",
                   "#762a83",
                   "#762a83",
                   "#762a83",
                   "#762a83")

# ROH stacked boxplot #############################################
# by management area
ggbarplot(ROHcat, x="sample_ID", y="Froh",
          order=order_pop,
          fill="category2",
          legend.title="Length (Mb)",
          orientation="horizontal",
          palette=colors_roh,
          legend="top")+
  xlab(bquote("Individuals by management area"))+
  ylab(bquote(F[ROH]))+
  theme(axis.text=element_text(size=15),
        axis.title=element_text(size=20),
        legend.text=element_text(size=15),
        legend.title=element_text(size=15),
        axis.text.y=element_text(colour=color_lab_pop,
                                 face="bold"))

# ROH stacked boxplot FOR MANUSCRIPT ####
ggsave("FILENAME_10x10.pdf",
       width = 10, height = 10, units = "in",
       dpi = 300,
       device = cairo_pdf)

# by cohort
ggbarplot(ROHcat, x="sample_ID", y="Froh",
          order=order_cohort,
          fill="category2",
          legend.title="Length (Mb)",
          orientation="horizontal",
          palette=colors_roh,
          legend="top")+
  xlab(bquote("Individuals by cohort"))+
  ylab(bquote(F[ROH]))+
  theme(axis.text=element_text(size=15),
        axis.title=element_text(size=20),
        legend.text=element_text(size=15),
        legend.title=element_text(size=15),
        axis.text.y=element_text(colour=color_lab_cohort,
                                 face="bold"))
