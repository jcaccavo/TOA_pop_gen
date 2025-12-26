#!/bin/bash

inPath=".../04_Rename"
outPath=".../05_PCRduplicatesFilter"
scriptPath=".../script_directory"

cd $inPath

for r1 in *_1.fastq.gz;do
        echo $r1
        r2=$(echo $r1 | sed 's/_1.fastq.gz/_2.fastq.gz/')
        echo $r2
        python2.7 $scriptPath/filterPCRdups.py -r1 $r1 -r2 $r2 -o $outPath
done
