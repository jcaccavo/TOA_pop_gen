#!/bin/bash
inPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/12_Filter3rdEnzyme"
outPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/12_Filter3rdEnzyme/Filtered3enzymes"

for FASTQ in ${inPath}/*.fastq; do
        FILE=$(basename $FASTQ)
        echo $FILE
        OUT=${FILE/.fastq/}
        OUT1=${FILE/.R*.fastq/}
        python2 /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/Filter_reads.py -n -u -a -i ${inPath}/RestSite_Headers_${OUT1}.txt ${inPath}/${FILE} ${outPath}/${OUT}_3enzymes_filtered.fastq
done

