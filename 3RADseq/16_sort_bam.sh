#!/bin/bash

cd .../13_final_mapping

for bam in *.bam;do
        file=$(basename $bam | sed 's/.bam//') #basename give you the name without the path
        samtools sort $file.bam -o ${file}_sorted.bam
done
