#Create pca

#--pca - fairly self explanatory, this tells plink to calculate a principal components analysis.

PREFIX="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq2021/03_admixture2021/subarea_p3_p1r0.6_populations.snps.2021.sorted_min10max120miss0.75_1SNPperlocus.vcf.KingClean.admix"
#VCF="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/00_Stacks/3_subarea_p3_p1r0.6_populations.snps.SORTED_min10max120miss0.75_1SNPperlocus.vcf"
OUT="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq2021/04_PCA2021"

#mkdir $OUT

/srv/public/shared/software/bin/plink2 --bfile $PREFIX --double-id --king-cutoff 0.0884 --allow-extra-chr --set-missing-var-ids @:# --make-bed --pca --out $OUT/subarea_p3_p1r0.6_populations.snps.2021.sorted_min10max120miss0.75_1SNPperlocus.vcf.KingClean_PCA

