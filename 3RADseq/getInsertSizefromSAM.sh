#!/bin/bash

inPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/07_mapping2021"

for SAM in $inPath/*.sam;do
        echo $SAM
        OUT=${SAM/.sam/}
        python2 /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/getInsertSizefromSAM.py $SAM $OUT.FragSizes
        cut -f1 $OUT.FragSizes | sort | uniq -c > $OUT.Lengths
        Rscript /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/plotFragSizes_args_fastq.R $OUT.Lengths $OUT.svg
done
