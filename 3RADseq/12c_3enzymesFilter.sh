#!/bin/bash
inPath=".../12_Filter3rdEnzyme"
outPath=".../Filtered3enzymes"

for FASTQ in ${inPath}/*.fastq; do
        FILE=$(basename $FASTQ)
        echo $FILE
        OUT=${FILE/.fastq/}
        OUT1=${FILE/.R*.fastq/}
        python2 .../Filter_reads.py -n -u -a -i ${inPath}/RestSite_Headers_${OUT1}.txt ${inPath}/${FILE} ${outPath}/${OUT}_3enzymes_filtered.fastq
done

