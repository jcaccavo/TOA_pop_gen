#!/bin/bash

inPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/04_Rename"
outPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/05_PCRduplicatesFilter"
scriptPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts"

cd $inPath

for r1 in *_1.fastq;do
        echo $r1
        r2=$(echo $r1 | sed 's/_1.fastq/_2.fastq/')
        echo $r2
        python2.7 $scriptPath/filterPCRdups_CM.py -r1 $r1 -r2 $r2 -o $outPath
done
