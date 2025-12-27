#!/bin/bash

cd /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq//01_RADseq/13_final_mapping

for sam in *.sam;do
        bam=$(echo $sam | sed 's/.sam/.bam/')
        samtools view -S -b $sam > $bam
done

