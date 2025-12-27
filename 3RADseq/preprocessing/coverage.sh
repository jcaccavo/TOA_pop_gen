#!/bin/bash

inDir=".../13_final_mapping"

for bam in $inDir/*sorted.bam;do # loop over each bam file in inDir
	echo $bam
	file=$(basename $bam | sed 's/.sam//') #basename give you the name without the path
        samtools depth $bam | awk '{sum+=$3} END { print "Average = ",sum/NR}'
done
