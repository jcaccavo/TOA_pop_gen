#!/bin/bash

#1st: estimate saf file per population - takes around 20-30 minutes
angsd -GL 1 -out .../OUTPUT_DIRECTORY -ref .../D.mawsoni.genome.fasta -anc .../D.mawsoni.genome.fasta -nThreads 40 -dosaf 1 -bam .../bam.filelist
#2nd: estimate folded SFS - takes around 50 minutes
realSFS .../FILENAME.saf.idx -fold 1 -P 40 > .../FILENAME_folded.sfs
#3rd: estimate nucleotide diversity () per site - takes around 40 minutes
realSFS saf2theta .../FILENAME.saf.idx -sfs .../FILENAME_folded.sfs -outname .../OUTPUT_DIRECTORY
#4th: estimate Tajima's D and Watterson Theta with a sliding window (window size 50kb, step size 10kb) - takes around 25 minutes
thetaStat do_stat .../FILENAME.thetas.idx -win 50000 -step 10000 -outnames FILENAME.theta.thetasWindow.gz
thetaStat print .../FILENAME.thetas.idx > .../FILENAME.thetas
awk '{ print $2, $3, $4, $9 }' .../FILENAME.theta.thetasWindow.gz.pestPG > .../FILENAME_sumstats
