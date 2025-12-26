T="java -jar /srv/public/shared/software/bin/Trimmomatic-0.38/trimmomatic-0.38.jar"
inPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/09_CorrectOrientation"
outPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/10_SizeAndQualityFilter"

Q=30

for R1 in $inPath/*.unassembled.forward.fastq;do
        R2=${R1/forward/reverse}
        FILE=$(basename $R1)
        echo $basename
        R1_paired=${FILE/.unassembled.forward.fastq/_R1_Q$Q.paired.fastq}
        R2_paired=${FILE/.unassembled.forward.fastq/_R2_Q$Q.paired.fastq}
        R1_unpaired=${FILE/.unassembled.forward.fastq/_R1_Q$Q.unpaired.fastq}
        R2_unpaired=${FILE/.unassembled.forward.fastq/_R2_Q$Q.unpaired.fastq}
        $T PE -threads 50 -phred33 $R1 $R2 $outPath/$R1_paired $outPath/$R1_unpaired $outPath/$R2_paired $outPath/$R2_unpaired AVGQUAL:${Q} MINLEN:140 CROP:140
done
