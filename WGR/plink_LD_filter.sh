# identify candidate SNPs under linkage disequilibrium to prune
plink --allow-extra-chr --double-id --indep-pairwise 20 20 0.5 --out noDS_tissue_filtered_SNPs_all --set-missing-var-ids @:# --vcf FILENAME_filtered_SNPs_all.vcf
# edit plink output file for use in vcftools
awk '{gsub(":", "\t");print}' FILENAME_filtered_SNPs_all.prune.in > FILENAME_filtered_SNPs_all_edited.prune.in
# remove SNPs under linkage disequilibrium from all SNPs VCF file
vcftools --vcf FILENAME_filtered_SNPs_all.vcf --positions FILENAME_filtered_SNPs_all.prune.in --recode --out FILENAME_filtered_SNPs_all_unlinked.vcf
