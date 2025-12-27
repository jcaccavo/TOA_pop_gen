#!/bin/bash

inPath=".../07_mapping"

for SAM in $inPath/*.sam;do
        echo $SAM
        OUT=${SAM/.sam/}
        python2 .../getInsertSizefromSAM.py $SAM $OUT.FragSizes
        cut -f1 $OUT.FragSizes | sort | uniq -c > $OUT.Lengths
        Rscript .../plotFragSizes_args_fastq.R $OUT.Lengths $OUT.svg
done
