# plot effective population size (Ne)

library(ggplot2)
library(ggtext)
library(scales)

setwd(".../INPUT_DIRECTORY")

smc <- read.csv("FILENAME_ne_plot.csv")

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

ggsave("FILENAME_ne_plot_10x10.pdf",
       width = 10, height = 10, units = "in",
       dpi = 300,
       device = cairo_pdf)
