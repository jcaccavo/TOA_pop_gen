#!/bin/bash
inPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/10_SizeAndQualityFilter"
outPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/11_CheckRestSites"

cd $inPath

for r1 in *_R1_Q30.paired.fastq;do
        r2=$(echo $r1 | sed 's/R1_Q30.paired.fastq/R2_Q30.paired.fastq/')
        FILE=$(basename $r1)
        baseN=$(echo $FILE | sed 's/_R1_Q30.paired.fastq//')
        echo $r1
        echo $r2
        echo $baseN
        python2 /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/checkFQRestrictionsSitesPairedEnd.py $r1 $r2 CGG AATTC ${outPath}/${baseN}_R1_checkrestsites.fastq ${outPath}/${baseN}_R2_checkrestsites.fastq
done

