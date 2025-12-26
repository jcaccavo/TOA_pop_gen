#!/bin/bash

Data=".../input_directory/filename.fastq.gz"
out=".../output_directory"

cd $Data

for r1 in *R1.fastq.gz; do
        r2=$(echo $r1 | sed 's/R1.fastq.gz/R2.fastq.gz/')
        baseN=$(echo $r1 | sed 's/_R1.fastq.gz//')
        echo $r1
        echo $r2
        echo $baseN
        .../cutadapt -a CTGTCTCTTATA -A CTGTCTCTTATA -o $out/${baseN}_R1_AT.fastq.gz -p $out/${baseN}_R2_AT.fastq.gz $Data/${r1} $Data/${r2} -m 30 -j 50

done
