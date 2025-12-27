#!/bin/bash

inDir="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/13_final_mapping"

for bam in $inDir/*sorted.bam;do # loop over each bam file in inDir
	echo $bam
	file=$(basename $bam | sed 's/.sam//') #basename give you the name without the path
        samtools depth $bam | awk '{sum+=$3} END { print "Average = ",sum/NR}'
done
