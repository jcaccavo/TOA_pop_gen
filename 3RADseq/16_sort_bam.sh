#!/bin/bash

cd /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/13_final_mapping

for bam in *.bam;do
        file=$(basename $bam | sed 's/.bam//') #basename give you the name without the path
        samtools sort $file.bam -o ${file}_sorted.bam
done
