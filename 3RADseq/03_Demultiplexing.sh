#!/bin/bash

INPUT="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/02a_AdapterTrimming"
OUTPUT="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/03_demultiplexingInlineBarcode"
INDEX_P5="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/2019_32_Internal_indexes_LIB_P5.fasta"
INDEX_P7="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/2019_11_Internal_indexes_LIB_P7.fasta"
LOG="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/03_demultiplexingInlineBarcode/flexbar.log"

for READ1 in $INPUT/*_R1_AT.fastq;do
	READ2=${READ1/_R1/_R2}
	echo $READ1
	echo $READ2
	FILE=$(basename $READ1)
	SAMPLE=${FILE/_R1_AT.fastq/}
#	/home/mi/jcaccavo/miniconda3/bin/flexbar -r $READ1 -p $READ2 -b $INDEX_P5 -b2 $INDEX_P7 -t ${OUTPUT}/$SAMPLE -be LTAIL -u 2 -n 40
#	/srv/public/shared/software/src/flexbar-src/flexbar/flexbar -r $READ1 -p $READ2 -b $INDEX_P5 -b2 $INDEX_P7 -t ${OUTPUT}/$SAMPLE -be LTAIL -u 2 -n 40
	flexbar -r $READ1 -p $READ2 -b $INDEX_P5 -b2 $INDEX_P7 -t ${OUTPUT}/$SAMPLE -bt LTAIL -u 2 -n 40
done
