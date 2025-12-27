#!/bin/bash

genome=".../Dmawsoni_scaffolds_v1MOD"
out="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/13_final_mapping"

cd /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/12_Filter3rdEnzyme/Filtered3enzymes

for r1 in *R1_3enzymes_filtered.fastq;do
        r2=$(echo $r1 | sed 's/R1_3enzymes_filtered.fastq/R2_3enzymes_filtered.fastq/')
        baseN=$(echo $r1 | sed 's/R1_3enzymes_filtered.fastq//')
        echo $r1
        echo $r2
        echo $baseN
        /srv/public/shared/software/src/bowtie2-2.3.5.1-linux-x86_64/bowtie2 -p 50 -x ${genome} -1 $r1 -2 $r2 -S ${out}/${baseN}_dmawsoni_soft_totalref_x1000_bowtie2.sam --un-conc $out/${baseN}_unmapped.fastq -X 1000 --no-discordant --no-mixed --very-sensitive
done
