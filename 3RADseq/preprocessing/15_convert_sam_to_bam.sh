#!/bin/bash

cd .../13_final_mapping

for sam in *.sam;do
        bam=$(echo $sam | sed 's/.sam/.bam/')
        samtools view -S -b $sam > $bam
done

