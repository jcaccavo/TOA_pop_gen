#!/bin/bash

genome="/srv/public/users/jcaccavo/00_genome2021/D.mawsoni.genome"
out="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/07_mapping2021"

cd /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/06_Concatenated

for r1 in *concat_R1.fastq.gz;do
        r2=$(echo $r1 | sed 's/concat_R1.fastq.gz/concat_R2.fastq.gz/')
        baseN=$(echo $r1 | sed 's/_concat_R1.fastq.gz//')
        echo $r1
        echo $r2
        echo $baseN
        /srv/public/shared/software/src/bowtie2-2.3.5.1-linux-x86_64/bowtie2 -p 50 -x ${genome} -1 $r1 -2 $r2 -S ${out}/${baseN}_dmawsoni2021_soft_totalref_x1000_bowtie2.sam --un-conc $out/${baseN}_unmapped2021.fastq -X 1000 --no-discordant --no-mixed --very-sensitive
done
