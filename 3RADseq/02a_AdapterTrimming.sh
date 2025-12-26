#!/bin/bash

Data="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/01_demultiplexing_RADseq"
out="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/02a_AdapterTrimming"

cd $Data

for r1 in *R1.fastq; do
        r2=$(echo $r1 | sed 's/R1.fastq/R2.fastq/')
        baseN=$(echo $r1 | sed 's/_R1.fastq//')
        echo $r1
        echo $r2
        echo $baseN
        /home/mi/jcaccavo/.local/bin/cutadapt -a AGATCGGAAGAG -A AGATCGGAAGAG -o $out/${baseN}_R1_AT.fastq -p $out/${baseN}_R2_AT.fastq $Data/${r1} $Data/${r2} -m 30 -j 50

done
