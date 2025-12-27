#!/bin/bash

genome=".../Dmawsoni_scaffolds_v1MOD"
out=".../13_final_mapping"

cd .../Filtered3enzymes

for r1 in *R1_3enzymes_filtered.fastq.gz;do
        r2=$(echo $r1 | sed 's/R1_3enzymes_filtered.fastq.gz/R2_3enzymes_filtered.fastq.gz/')
        baseN=$(echo $r1 | sed 's/R1_3enzymes_filtered.fastq.gz//')
        echo $r1
        echo $r2
        echo $baseN
        .../bowtie2 -p 50 -x ${genome} -1 $r1 -2 $r2 -S ${out}/${baseN}_dmawsoni_soft_totalref_x1000_bowtie2.sam --un-conc $out/${baseN}_unmapped.fastq.gz -X 1000 --no-discordant --no-mixed --very-sensitive
done
