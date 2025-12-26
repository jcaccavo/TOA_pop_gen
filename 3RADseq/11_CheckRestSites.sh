#!/bin/bash
inPath=".../10_SizeAndQualityFilter"
outPath=".../11_CheckRestSites"

cd $inPath

for r1 in *_R1_Q30.paired.fastq.gz;do
        r2=$(echo $r1 | sed 's/R1_Q30.paired.fastq.gz/R2_Q30.paired.fastq.gz/')
        FILE=$(basename $r1)
        baseN=$(echo $FILE | sed 's/_R1_Q30.paired.fastq.gz//')
        echo $r1
        echo $r2
        echo $baseN
        python2 .../checkFQRestrictionsSitesPairedEnd.py $r1 $r2 CGG AATTC ${outPath}/${baseN}_R1_checkrestsites.fastq.gz ${outPath}/${baseN}_R2_checkrestsites.fastq.gz
done

