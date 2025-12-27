PREFIX=".../FILENAME.admix"
OUT=".../PCA"

.../plink2 --bfile $PREFIX --double-id --king-cutoff 0.0884 --allow-extra-chr --set-missing-var-ids @:\# --make-bed --pca --out $OUT/FILENAME_PCA
