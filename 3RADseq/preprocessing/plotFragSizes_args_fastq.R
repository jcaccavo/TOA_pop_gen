#!/usr/bin/Rscript

args <- commandArgs(TRUE)
svg(args[2], width = 20, height = 20)
reads=read.csv(args[1], header=F, sep="")
plot (reads$V2,reads$V1,type="l",xlab="read length",ylab="occurences",col="blue")
axis(side=1,at=seq(0,600,10),lwd=3)
dev.off()
