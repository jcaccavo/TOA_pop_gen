# plot effective population size (Ne)

library(ggplot2)
library(ggtext)
library(scales)

# 5x high ####
# mutation rate 2.85 x 10^-8

setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/demographic_analysis/5x/mut_rate_285108")

smc <- read.csv("5x_mut_rate_285108_area_ne_plot_1.csv")

str(smc)
# 'data.frame':	303 obs. of  5 variables:
# $ label    : int  48 48 48 48 48 48 48 48 48 48 ...
# $ x        : num  0 1.42 1.63 1.88 2.16 ...
# $ y        : num  8414 8414 8414 8414 8414 ...
# $ plot_type: chr  "path" "path" "path" "path" ...
# $ plot_num : int  0 0 0 0 0 0 0 0 0 0 ...

# make label into factor
smc$label <- as.factor(smc$label)

colors_pop <- c("#762a83", "#a6dba0", "#00441b")

ggplot(smc, aes(x=x,y=y,color=label))+
  geom_line(size=2)+
  theme_light()+
  theme(text=element_text(size=20),
        legend.position="bottom",
        plot.title=element_text(hjust=0.5))+
  ylim(5000,20000)+ 
  xlim(0,250000)+
  scale_colour_manual(name = "Management area",
                      values = colors_pop,
                      labels = c("48", "58","88"))+
  labs(title=bquote("mutation rate 2.85 x 10"^"-8"),
       y=bquote("Effective population size"~italic("(Ne)")), 
       x="Years before present (yBP)")+
  annotate("rect",xmin=19000, xmax=26500, ymin=5000, ymax=20000, fill="grey",alpha=.5)+
  annotate("rect",xmin=110000, xmax=113000, ymin=5000, ymax=20000, fill="grey",alpha=.5)+
  scale_y_continuous(limits = c(5000,20000), expand = c(0, 0), labels=comma)+ 
  scale_x_continuous(limits = c(0,270000), expand = c(0, 0), labels=comma)

ggsave("5x_ne_plot_mut_285108_10x10.pdf",
       width = 10, height = 10, units = "in",
       dpi = 300,
       device = cairo_pdf)

# 5x low ####
# mutation rate 3.28 x 10^-9

setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/demographic_analysis/5x/mut_rate_328109")

smc <- read.csv("5x_mut_rate_328109_area_ne_plot_1.csv")

str(smc)
# 'data.frame':	303 obs. of  5 variables:
# $ label    : int  48 48 48 48 48 48 48 48 48 48 ...
# $ x        : num  0 495 545 600 660 ...
# $ y        : num  80171 80171 80172 80174 80177 ...
# $ plot_type: chr  "path" "path" "path" "path" ...
# $ plot_num : int  0 0 0 0 0 0 0 0 0 0 ...

# make label into factor
smc$label <- as.factor(smc$label)

colors_pop <- c("#762a83", "#a6dba0", "#00441b")

ggplot(smc, aes(x=x,y=y,color=label))+
  geom_line(size=2)+
  theme_light()+
  theme(text=element_text(size=20),
        legend.position="bottom",
        plot.title=element_text(hjust=0.5))+
  ylim(50000,110000)+ 
  xlim(0,250000)+
  scale_colour_manual(name = "Management area",
                      values = colors_pop,
                      labels = c("48", "58","88"))+
  labs(title=bquote("mutation rate 3.28 x 10"^"-9"),
       y=bquote("Effective population size"~italic("(Ne)")), 
       x="Years before present (yBP)")+
  annotate("rect",xmin=19000, xmax=26500, ymin=50000, ymax=110000, fill="grey",alpha=.5)+
  annotate("rect",xmin=110000, xmax=113000, ymin=50000, ymax=110000, fill="grey",alpha=.5)+
  scale_y_continuous(limits = c(50000,110000), expand = c(0, 0), labels=comma)+ 
  scale_x_continuous(limits = c(0,270000), expand = c(0, 0), labels=comma)

ggsave("5x_ne_plot_mut_328109_10x10.pdf",
       width = 10, height = 10, units = "in",
       dpi = 300,
       device = cairo_pdf)

# 10x high ####
# mutation rate 2.85 x 10^-8

setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/demographic_analysis/10x/mut_rate_285108")

smc <- read.csv("10x_mut_rate_285108_area_ne_plot_1.csv")

str(smc)
# 'data.frame':	303 obs. of  5 variables:
# $ label    : int  48 48 48 48 48 48 48 48 48 48 ...
# $ x        : num  0 1.45 1.67 1.92 2.21 ...
# $ y        : num  11541 11541 11541 11541 11541 ...
# $ plot_type: chr  "path" "path" "path" "path" ...
# $ plot_num : int  0 0 0 0 0 0 0 0 0 0 ...

# make label into factor
smc$label <- as.factor(smc$label)

colors_pop <- c("#762a83", "#a6dba0", "#00441b")

ggplot(smc, aes(x=x,y=y,color=label))+
  geom_line(size=2)+
  theme_light()+
  theme(text=element_text(size=20),
        legend.position="bottom",
        plot.title=element_text(hjust=0.5))+
  ylim(5000,20000)+ 
  xlim(0,250000)+
  scale_colour_manual(name = "Management area",
                      values = colors_pop,
                      labels = c("48", "58","88"))+
  labs(title=bquote("10x dataset | mutation rate 2.85 x 10"^"-8"),
       y=bquote("Effective population size"~italic("(Ne)")), 
       x="Years before present (yBP)")+
  annotate("rect",xmin=19000, xmax=26500, ymin=5000, ymax=20000, fill="grey",alpha=.5)+
  annotate("rect",xmin=110000, xmax=113000, ymin=5000, ymax=20000, fill="grey",alpha=.5)+
  scale_y_continuous(limits = c(5000,20000), expand = c(0, 0), labels=comma)+ 
  scale_x_continuous(limits = c(0,270000), expand = c(0, 0), labels=comma)

# 10x low ####
# mutation rate 3.28 x 10^-9

setwd("/Users/JMAC/Library/CloudStorage/Dropbox/Research/Humboldt/CCGA_full_sequencing/demographic_analysis/10x/mut_rate_328109")

smc <- read.csv("10x_mut_rate_328109_area_ne_plot_1.csv")

str(smc)
# 'data.frame':	303 obs. of  5 variables:
# $ label    : int  48 48 48 48 48 48 48 48 48 48 ...
# $ x        : num  0 495 547 604 667 ...
# $ y        : num  93925 93925 93928 93935 93948 ...
# $ plot_type: chr  "path" "path" "path" "path" ...
# $ plot_num : int  0 0 0 0 0 0 0 0 0 0 ...

# make label into factor
smc$label <- as.factor(smc$label)

colors_pop <- c("#762a83", "#a6dba0", "#00441b")

ggplot(smc, aes(x=x,y=y,color=label))+
  geom_line(size=2)+
  theme_light()+
  theme(text=element_text(size=20),
        legend.position="bottom",
        plot.title=element_text(hjust=0.5))+
  ylim(50000,110000)+ 
  xlim(0,250000)+
  scale_colour_manual(name = "Management area",
                      values = colors_pop,
                      labels = c("48", "58","88"))+
  labs(title=bquote("10x dataset | mutation rate 3.28 x 10"^"-9"),
       y=bquote("Effective population size"~italic("(Ne)")), 
       x="Years before present (yBP)")+
  annotate("rect",xmin=19000, xmax=26500, ymin=50000, ymax=110000, fill="grey",alpha=.5)+
  annotate("rect",xmin=110000, xmax=113000, ymin=50000, ymax=110000, fill="grey",alpha=.5)+
  scale_y_continuous(limits = c(50000,110000), expand = c(0, 0), labels=comma)+ 
  scale_x_continuous(limits = c(0,270000), expand = c(0, 0), labels=comma)
