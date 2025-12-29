# Create plots of plink ROH analysis outputs
# based on parameter set 2 (ps2)

# 5X DATASET 

# load necessary libraries
library(ggpubr)
library(dplyr)

# set working directory
setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/ROH/5x/parameter_set2")

# extract data from hom file #############################################

# Import .hom file
roh_plink_5x <- read.table(file = "5x_TOA_only_filtered_MQ_QUAL_SNPs_all_ROH_2.hom", header = T)

# prepare ROH .hom data output into run-length categories #############################################
# if you've already done this and prepared the input .csv, skip to that
# small
ROHsmall<-roh_plink_5x[roh_plink_5x$KB >= 100 & roh_plink_5x$KB <= 500,]
ROHsmall_cat<-aggregate(ROHsmall$KB ~ ROHsmall$IID, FUN = "sum")
colnames(ROHsmall_cat)<-c("Sample_ID", "sumKB")
# ROHsmall_cat$Category<-"Short"
ROHsmall_cat$Category<-"0.1-0.5"
# medium
ROHmedium<-roh_plink_5x[roh_plink_5x$KB > 500 & roh_plink_5x$KB <= 1000,]
ROHmedium_cat<-aggregate(ROHmedium$KB ~ ROHmedium$IID, FUN = "sum")
colnames(ROHmedium_cat)<-c("Sample_ID", "sumKB")
# ROHmedium_cat$Category<-"Medium"
ROHmedium_cat$Category<-"0.5-1"
# long
ROHlong<-roh_plink_5x[roh_plink_5x$KB > 1000,]
ROHlong_cat<-aggregate(ROHlong$KB ~ ROHlong$IID, FUN = "sum")
colnames(ROHlong_cat)<-c("Sample_ID", "sumKB")
# ROHlong_cat$Category<-"Long"
ROHlong_cat$Category<-">1"
# combine all 3 categories and prepare dataframe
ROHcat<-rbind(ROHsmall_cat)
ROHcat$sumMB<-ROHcat$sumKB/1000
class(ROHcat$Sample_ID) = "character"
# output as .csv to add in pop and cohort categories in Excel
# write.csv(ROHcat,"5X_ROH_2_category_output.csv")
# this was done once and now the csv file is modified
# subsequently, this only needs to be imported

# import hom output with metadata #############################################

ROHcat <- read.csv("5X_ROH_2_category_output.csv")
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

# Filter individuals (if needed)
# IndExclude=c("653", "6573", "4436")
# ROHcatFiltered<-ROHcat[!(ROHcat$Sample_ID %in% IndExclude),]

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

# order by sample type
order_type <- c("50-446",
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
                "9479",
                "9432",
                "433",
                "419",
                "412",
                "527",
                "315",
                "314",
                "313",
                "312",
                "168")

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

# color individual axis labels by cohort
color_lab_cohort <- c("#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#980043",
                      "#d7b5d8",
                      "#d7b5d8",
                      "#d7b5d8",
                      "#d7b5d8",
                      "#d7b5d8",
                      "#d7b5d8",
                      "#d7b5d8",
                      "#d7b5d8")

# color individual axis labels by sample type
color_lab_type <- c("#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#5ab4ac",
                    "#d8b365",
                    "#d8b365",
                    "#d8b365",
                    "#d8b365",
                    "#d8b365",
                    "#d8b365",
                    "#d8b365",
                    "#d8b365",
                    "#d8b365")

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
ggsave("5x_barplot_roh_ps2_pop_10x10.pdf",
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

# by sample type
ggbarplot(ROHcat, x="sample_ID", y="Froh",
          order=order_type,
          fill="category2",
          legend.title="Length (Mb)",
          orientation="horizontal",
          palette=colors_roh,
          legend="top")+
  xlab(bquote("Individuals by sample type"))+
  ylab(bquote(F[ROH]))+
  theme(axis.text=element_text(size=15),
        axis.title=element_text(size=20),
        legend.text=element_text(size=15),
        legend.title=element_text(size=15),
        axis.text.y=element_text(colour=color_lab_type,
                                 face="bold"))

# other plots #############################################
roh_plink_5x$logKB<-log10(roh_plink_5x$KB)
ggdensity(data = roh_plink_5x, x = "logKB", y = "..density..", fill = "IID", facet.by = "IID")
ggboxplot(roh_plink_5x, x = "IID", y = "logKB", fill = "IID",
          xlab = "Sample ID", ylab = "log(Length of ROH)", legend = "none", orientation = "horiz") +
  font("xlab", face = "bold") + font("ylab", face = "bold")
ggviolin(roh_plink_5x, x = "IID", y = "logKB", fill = "IID",
         xlab = "Sample ID", ylab = "log(Length of ROH)", legend = "none", orientation = "horiz") +
  font("xlab", face = "bold") + font("ylab", face = "bold")

ROH1000<-roh_plink_5x[roh_plink_5x$KB < 800,]
ggviolin(ROH1000, x = "IID", y = "KB", fill = "IID",
         xlab = "Sample ID", ylab = "log(Length of ROH)", legend = "none", orientation = "horiz") +
  font("xlab", face = "bold") + font("ylab", face = "bold")

# import data for ROH scatterplots ##############################################
roh_he_5x <- read.table(file = "5x_froh_he_ps2.txt", header = T)

str(roh_he_5x)
# 'data.frame':	24 obs. of  10 variables:
# $ sample_ID  : chr  "9432" "168" "312" "313" ...
# $ roh_kb     : num  3882 1514 1290 1609 344 ...
# $ roh_mb     : num  3.882 1.514 1.29 1.609 0.344 ...
# $ Froh       : num  0.004198 0.001637 0.001395 0.00174 0.000372 ...
# $ pop1       : int  48 48 48 48 48 48 48 58 58 58 ...
# $ cohort_2   : chr  "pre2000" "post2000" "post2000" "post2000" ...
# $ coverage   : num  11.4 6.92 12.46 5.92 13.27 ...
# $ he_5x      : num  0.00372 0.00389 0.00315 0.00308 0.00519 ...
# $ he_5x_plink: num  0.166 0.215 0.214 0.282 0.267 ...
# $ sample_type: chr  "tissue" "otolith" "otolith" "otolith" ...

# make pop, cohort, and sample_type into factors
roh_he_5x$pop1 <- factor(roh_he_5x$pop1, levels=unique(roh_he_5x$pop1))
roh_he_5x$cohort_2 <- factor(roh_he_5x$cohort_2, levels=unique(roh_he_5x$cohort_2))
roh_he_5x$sample_type <- factor(roh_he_5x$sample_type, levels=c("otolith","tissue"))

str(roh_he_5x)
# 'data.frame':	24 obs. of  10 variables:
# $ sample_ID  : chr  "9432" "168" "312" "313" ...
# $ roh_kb     : num  3882 1514 1290 1609 344 ...
# $ roh_mb     : num  3.882 1.514 1.29 1.609 0.344 ...
# $ Froh       : num  0.004198 0.001637 0.001395 0.00174 0.000372 ...
# $ pop1       : Factor w/ 3 levels "48","58","88": 1 1 1 1 1 1 1 2 2 2 ...
# $ cohort_2   : Factor w/ 2 levels "pre2000","post2000": 1 2 2 2 2 2 2 1 2 2 ...
# $ coverage   : num  11.4 6.92 12.46 5.92 13.27 ...
# $ he_5x      : num  0.00372 0.00389 0.00315 0.00308 0.00519 ...
# $ he_5x_plink: num  0.166 0.215 0.214 0.282 0.267 ...
# $ sample_type: Factor w/ 2 levels "otolith","tissue": 2 1 1 1 1 1 1 2 1 1 ...

# create a color vector for plots
colors_pop <- c("#762a83","#a6dba0","#00441b")
colors_cohort <- c("#d7b5d8","#980043")
colors_type <- c("#d8b365","#5ab4ac")

# scatterplots of ROH by He ##############################################
# colored by management area
ggplot(roh_he_5x, aes(x=he_5x, y=Froh))+
  theme_classic()+
  geom_point(color='black', shape=21, size=5, aes(fill=factor(pop1)))+
  scale_fill_manual("Management area",values=colors_pop)+
  scale_colour_manual(values = colors_pop,
                      labels = c("48", "58","88"))+
  theme(text=element_text(size=20),
        legend.position="bottom")+
  xlab(bquote(Heterozygosity))+
  ylab(bquote(F[ROH]))+
  geom_smooth(method=lm, se=FALSE, col='black', linewidth=1)+
  stat_regline_equation(aes(label=paste(after_stat(rr.label))), size=7, label.y=-0.001, label.x=0.002)
# colored by cohort
ggplot(roh_he_5x, aes(x=he_5x, y=Froh))+
  theme_classic()+
  geom_point(color='black', shape=21, size=5, aes(fill=factor(cohort_2)))+
  scale_fill_manual("Cohort",
                    labels = c("pre-2000", "post-2000"),
                    values=colors_cohort)+
  theme(text=element_text(size=20),
        legend.position="bottom")+
  xlab(bquote(Heterozygosity))+
  ylab(bquote(F[ROH]))+
  geom_smooth(method=lm, se=FALSE, col='black', linewidth=1)+
  stat_regline_equation(aes(label=paste(after_stat(rr.label))), size=7, label.y=-0.001, label.x=0.002)
# colored by sample type
ggplot(roh_he_5x, aes(x=he_5x, y=Froh))+
  theme_classic()+
  geom_point(color='black', shape=21, size=5, aes(fill=factor(cohort_2)))+
  scale_fill_manual("Sample type",
                    labels = c("otolith", "tissue"),
                    values=colors_type)+
  theme(text=element_text(size=20),
        legend.position="bottom")+
  xlab(bquote(Heterozygosity))+
  ylab(bquote(F[ROH]))+
  geom_smooth(method=lm, se=FALSE, col='black', linewidth=1)+
  stat_regline_equation(aes(label=paste(after_stat(rr.label))), size=7, label.y=-0.001, label.x=0.002)

# scatterplots of ROH by coverage ##############################################
# colored by management area
ggplot(roh_he_5x, aes(x=coverage, y=Froh))+
  theme_classic()+
  geom_point(color='black', shape=21, size=5, aes(fill=factor(pop1)))+
  scale_fill_manual("Management area",values=colors_pop)+
  scale_colour_manual(values = colors_pop,
                      labels = c("48", "58","88"))+
  theme(text=element_text(size=20),
        legend.position="bottom")+
  xlab(bquote(Coverage))+
  ylab(bquote(F[ROH]))+
  geom_smooth(method=lm, se=FALSE, col='black', linewidth=1)+
  stat_regline_equation(aes(label=paste(after_stat(rr.label))), size=7, label.y=0.01, label.x=22)
# colored by cohort
ggplot(roh_he_5x, aes(x=coverage, y=Froh))+
  theme_classic()+
  geom_point(color='black', shape=21, size=5, aes(fill=factor(cohort_2)))+
  scale_fill_manual("Cohort",
                    labels = c("pre-2000", "post-2000"),
                    values=colors_cohort)+
  theme(text=element_text(size=20),
        legend.position="bottom")+
  xlab(bquote(Coverage))+
  ylab(bquote(F[ROH]))+
  geom_smooth(method=lm, se=FALSE, col='black', linewidth=1)+
  stat_regline_equation(aes(label=paste(after_stat(rr.label))), size=7, label.y=0.01, label.x=22)
# colored by sample type
ggplot(roh_he_5x, aes(x=coverage, y=Froh))+
  theme_classic()+
  geom_point(color='black', shape=21, size=5, aes(fill=factor(cohort_2)))+
  scale_fill_manual("Sample type",
                    labels = c("otolith", "tissue"),
                    values=colors_type)+
  theme(text=element_text(size=20),
        legend.position="bottom")+
  xlab(bquote(Coverage))+
  ylab(bquote(F[ROH]))+
  geom_smooth(method=lm, se=FALSE, col='black', linewidth=1)+
  stat_regline_equation(aes(label=paste(after_stat(rr.label))), size=7, label.y=0.01, label.x=22)

# boxplots of ROH ##############################################
# population

# STATS by area ####
# statistical test to compare F between populations K = 3 CCAMLR area groups
# use a one-way anova
anova_5x_pop <- aov(Froh ~ pop1, data = roh_he_5x)
summary(anova_5x_pop)
# Df    Sum Sq   Mean Sq F value  Pr(>F)   
# pop1         2 6.239e-05 3.119e-05   6.144 0.00793 **
# Residuals   21 1.066e-04 5.077e-06                   
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

pairwise.t.test(roh_he_5x$Froh, roh_he_5x$pop1, p.adj='holm')
# Pairwise comparisons using t tests with pooled SD 

# data:  roh_he_5x$Froh and roh_he_5x$pop1 
# 
#       48     58    
# 58 0.4747 -     
# 88 0.0091 0.1296
# 
# P value adjustment method: holm  

sd_labels_5x_pop <- c("0.0091","0.1296")

ggplot(data=roh_he_5x, 
       aes(x=pop1, 
           y=Froh, 
           fill=pop1))+
  xlab(bquote("Management area"))+
  ylab(bquote(F[ROH]))+
  geom_boxplot()+ 
  scale_fill_manual(values = c("48"="#762a83","58"="#21dba0","88"="#1b7837"))+ 
  theme_bw()+
  theme(axis.text.x = element_text(colour = c("#762a83","#21dba0","#1b7837"), 
                                   size=20), 
        axis.text.y = element_text(size=20), 
        axis.title = element_text(size=20), 
        legend.title = element_text(size=20), 
        legend.text = element_text(size=20), 
        legend.position = "none", 
        plot.margin = margin(t=10, r=5, b=0, l=0))+
  scale_x_discrete(limits=c("48", "58", "88"))+
  geom_signif(comparisons = list(c("48", "88"), c("58","88")), 
              map_signif_level=TRUE, 
              textsize = 8, 
              step_increase = 0.2, 
              tip_length = 0.03, 
              annotations = sd_labels_5x_pop)

# 5X boxplot by area FOR MANUSCRIPT ####

# Define p-value labels in order: 48 vs 58, 48 vs 88, 58 vs 88
sd_labels_5x_pop <- c("0.4747", "0.0091", "0.1296")

ggplot(data = roh_he_5x, 
       aes(x = pop1, 
           y = Froh, 
           fill = pop1)) + 
  geom_boxplot() + 
  geom_signif(
    comparisons = list(c("48", "58"), c("48", "88"), c("58", "88")), 
    annotations = sd_labels_5x_pop,
    map_signif_level = TRUE,
    textsize = 6,
    step_increase = 0.2,
    tip_length = 0.03
  ) +
  scale_fill_manual(values = c("48" = "#762a83", "58" = "#21dba0", "88" = "#1b7837")) +
  scale_x_discrete(limits = c("48", "58", "88")) +
  theme_bw() +
  labs(
    x = "Management area", 
    y = (bquote(F[ROH]))
  ) +
  theme(
    axis.text.x = element_text(size = 20),
    axis.text.y = element_text(size = 20),
    axis.title = element_text(size = 22),
    legend.title = element_text(size = 20),
    legend.text = element_text(size = 20),
    legend.position = "none",
    plot.margin = margin(t = 10, r = 5, b = 0, l = 0)
  )

ggsave("5x_Froh_ps2_boxplot_pop_10x10.pdf",
       width = 10, height = 10, units = "in",
       dpi = 300,
       device = cairo_pdf)

# cohort
# statistical test to compare F between coorts K = 2 pre- and post-2000
# use a one-way anova
anova_5x_cohort <- aov(Froh ~ cohort_2, data = roh_he_5x)
summary(anova_5x_cohort)
#             Df    Sum Sq   Mean Sq F value Pr(>F)
# cohort_2     1 0.0000077 7.703e-06   1.051  0.316
# Residuals   22 0.0001613 7.332e-06

pairwise.t.test(roh_he_5x$Froh, roh_he_5x$cohort_2, p.adj='holm')
# Pairwise comparisons using t tests with pooled SD 
# 
# data:  roh_he_5x$Froh and roh_he_5x$cohort_2 
# 
#         pre2000
# post2000 0.32   
# 
# P value adjustment method: holm 

sd_labels_5x_cohort <- c("0.32")

ggplot(data=roh_he_5x, 
       aes(x=cohort_2, 
           y=Froh, 
           fill=cohort_2))+
  xlab(bquote("Cohort"))+
  ylab(bquote(F[ROH]))+
  geom_boxplot()+ 
  scale_fill_manual(values = c("pre2000"="#d7b5d8","post2000"="#980043"))+ 
  theme_bw()+
  theme(axis.text.x = element_text(colour = c("#d7b5d8","#980043"), 
                                   size=20), 
        axis.text.y = element_text(size=20), 
        axis.title = element_text(size=20), 
        legend.title = element_text(size=20), 
        legend.text = element_text(size=20), 
        legend.position = "none", 
        plot.margin = margin(t=10, r=5, b=0, l=0))+
  scale_x_discrete(limits=c("pre2000", "post2000"))+
  geom_signif(comparisons = list(c("pre2000", "post2000")), 
              map_signif_level=TRUE, 
              textsize = 8, 
              step_increase = 0.2, 
              tip_length = 0.03, 
              annotations = sd_labels_5x_cohort)

# sample type
# statistical test to compare F between sample types K = 2 otolith and tissue
# use a one-way anova
anova_5x_type <- aov(Froh ~ sample_type, data = roh_he_5x)
summary(anova_5x_type)
#             Df    Sum Sq   Mean Sq F value  Pr(>F)   
# sample_type  1 6.068e-05 6.068e-05   12.32 0.00197 **
# Residuals   22 1.083e-04 4.920e-06                   
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

pairwise.t.test(roh_he_5x$Froh, roh_he_5x$sample_type, p.adj='holm')
# Pairwise comparisons using t tests with pooled SD 
# 
# data:  roh_he_5x$Froh and roh_he_5x$sample_type 
# 
#       otolith
# tissue 0.002  
# 
# P value adjustment method: holm 

sd_labels_5x_type <- c("0.002")

ggplot(data=roh_he_5x, 
       aes(x=sample_type, 
           y=Froh, 
           fill=sample_type))+
  xlab(bquote("Sample type"))+
  ylab(bquote(F[ROH]))+
  geom_boxplot()+ 
  scale_fill_manual(values = c("otolith"="#d8b365","tissue"="#5ab4ac"))+ 
  theme_bw()+
  theme(axis.text.x = element_text(colour = c("#d8b365","#5ab4ac"), 
                                   size=20), 
        axis.text.y = element_text(size=20), 
        axis.title = element_text(size=20), 
        legend.title = element_text(size=20), 
        legend.text = element_text(size=20), 
        legend.position = "none", 
        plot.margin = margin(t=10, r=5, b=0, l=0))+
  scale_x_discrete(limits=c("otolith", "tissue"))+
  geom_signif(comparisons = list(c("otolith", "tissue")), 
              map_signif_level=TRUE, 
              textsize = 8, 
              step_increase = 0.2, 
              tip_length = 0.03, 
              annotations = sd_labels_5x_type)



# subset ROH dataset by area ####

# subset area 48
roh_analysis_48 <- roh_he_5x[roh_he_5x$pop1=="48",]
# subset area 58
roh_analysis_58 <- roh_he_5x[roh_he_5x$pop1=="58",]
# subset area 88
roh_analysis_88 <- roh_he_5x[roh_he_5x$pop1=="88",]

# area 48 anova by cohort ####

anova_roh_cohort_48 <- aov(Froh ~ cohort_2, data = roh_analysis_48)
summary(anova_roh_cohort_48)
# Df    Sum Sq   Mean Sq F value Pr(>F)  
# cohort_2     1 7.055e-06 7.055e-06   10.79 0.0219 *
# Residuals    5 3.271e-06 6.540e-07                 
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1   

# perform a post-hoc t-test with Holm correction
pairwise.t.test(roh_analysis_48$Froh, roh_analysis_48$cohort_2, p.adj='holm')
# Pairwise comparisons using t tests with pooled SD 
# 
# data:  roh_analysis_48$Froh and roh_analysis_48$cohort_2 
# 
#       pre2000
# post2000 -      
#   
#   P value adjustment method: holm 

# ANOVA significant, but not possible to do post-hoc because area 48 pre2000 cohort group n = 1

# area 48 anova by sample type ####

anova_roh_type_48 <- aov(Froh ~ sample_type, data = roh_analysis_48)
summary(anova_roh_type_48)
#             Df    Sum Sq   Mean Sq F value Pr(>F)  
# sample_type  1 7.055e-06 7.055e-06   10.79 0.0219 *
# Residuals    5 3.271e-06 6.540e-07                 
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# perform a post-hoc t-test with Holm correction
pairwise.t.test(roh_analysis_48$Froh, roh_analysis_48$sample_type, p.adj='holm')
# Pairwise comparisons using t tests with pooled SD 
# 
# data:  roh_analysis_48$Froh and roh_analysis_48$sample_type 
# 
#       otolith
# tissue -      
#   
#   P value adjustment method: holm 

# ANOVA significant, but not possible to do post-hoc because area 48 tissue sample type group n = 1; this is the same value that is also the n = 1 pre2000 cohort group

# area 58 anova by cohort ####

anova_roh_cohort_58 <- aov(Froh ~ cohort_2, data = roh_analysis_58)
summary(anova_roh_cohort_58)
#             Df    Sum Sq   Mean Sq F value Pr(>F)
# cohort_2     1 1.240e-07 1.240e-07   0.024  0.891
# Residuals    2 1.019e-05 5.094e-06               

# perform a post-hoc t-test with Holm correction
pairwise.t.test(roh_analysis_58$Froh, roh_analysis_58$cohort_2, p.adj='holm')
# Pairwise comparisons using t tests with pooled SD 
# 
# data:  roh_analysis_58$Froh and roh_analysis_58$cohort_2 
# 
#       pre2000
# post2000 -      
#   
#   P value adjustment method: holm  

# ANOVA non-significant - not possible to do post-hoc because area 58 pre2000 cohort group n = 1

# area 58 anova by sample type ####

anova_roh_type_58 <- aov(Froh ~ sample_type, data = roh_analysis_58)
summary(anova_roh_type_58)
#             Df    Sum Sq   Mean Sq F value Pr(>F)
# sample_type  1 1.240e-07 1.240e-07   0.024  0.891
# Residuals    2 1.019e-05 5.094e-06               

# perform a post-hoc t-test with Holm correction
pairwise.t.test(roh_analysis_58$Froh, roh_analysis_58$sample_type, p.adj='holm')
# Pairwise comparisons using t tests with pooled SD 
# 
# data:  roh_analysis_58$Froh and roh_analysis_58$sample_type 
# 
#     otolith
# tissue -      
#   
#   P value adjustment method: holm 

# ANOVA non-significant - not possible to do post-hoc because area 58 tissue sample type group n = 1; this is the same value that is also the n = 1 pre2000 cohort group

# area 88 anova by cohort ####

anova_roh_cohort_88 <- aov(Froh ~ cohort_2, data = roh_analysis_88)
summary(anova_roh_cohort_88)
#             Df    Sum Sq   Mean Sq F value Pr(>F)
# cohort_2     1 1.130e-06 1.129e-06   0.146  0.709
# Residuals   11 8.486e-05 7.714e-06               

# perform a post-hoc t-test with Holm correction
pairwise.t.test(roh_analysis_88$Froh, roh_analysis_88$cohort_2, p.adj='holm')
# Pairwise comparisons using t tests with pooled SD 
# 
# data:  roh_analysis_88$Froh and roh_analysis_88$cohort_2 
# 
#         pre2000
# post2000 0.71   
# 
# P value adjustment method: holm 

# ANOVA non-significant
# cannot test whether sample type ROH is significantly different within area 88, as there are only tissue sample types in area 88

# boxplot of cohorts by area ####

ggplot(data=roh_he_5x,
       aes(x=pop1, 
           y=Froh, 
           col=cohort_2)) + 
  labs(fill = "Cohort") + 
  xlab(bquote("Management area"))+
  ylab(bquote(F[ROH]))+
  geom_boxplot() +
  geom_point(aes(colour = factor(sample_type)),
             position=position_jitterdodge(jitter.width=0.5, dodge.width = 0),
             size = 3,
             pch = 19) +
  scale_color_manual(values = c("#d7b5d8","#980043","#d8b365","#5ab4ac"),
                     name = "Cohort /\nSample type",
                     labels= c("pre-2000","post-2000","otolith","tissue")) +
  theme_bw() + 
  theme(axis.text.x = element_text(colour = c("#762a83","#21dba0","#1b7837"), size=20),
        axis.text.y = element_text(size=20), 
        axis.title = element_text(size=20), 
        legend.title = element_text(size=20), 
        legend.text = element_text(size=20), 
        plot.margin = margin(t=10, r=5, b=2, l=2)) +
  geom_signif(y_position = c(0.0045, 0.0052,0.0099), 
              xmin = c(0.81, 1.81, 2.81), 
              xmax = c(1.19, 2.19, 3.19), 
              annotation = c("NS.", "NS.", "0.71"),
              tip_length = 0.02,
              textsize = 6,
              col = "black")
