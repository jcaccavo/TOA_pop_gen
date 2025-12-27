#Prepare files to run Admixture
PREFIX="subarea_p3_p1r0.6_populations.snps.2021.sorted_min10max120miss0.75_1SNPperlocus.vcf"
VCF_sorted="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq2021/01_VCF_filtering2021/${PREFIX}"
OUTpath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq2021/03_admixture2021"

#using admixture-wrapper.py script to run replicates
#Prepare genotype file using plink
#1) Clean related individuals
/srv/public/shared/software/bin/plink2 --vcf $VCF_sorted --double-id --allow-extra-chr --king-cutoff 0.0884 --set-missing-var-ids @:# --make-bed --out ${OUTpath}/${PREFIX}.KingClean.admix
#2) Prepare ped file
#/srv/public/shared/software/bin/plink --bfile ${OUTpath}/${PREFIX}.KingClean.admix --double-id --allow-extra-chr --set-missing-var-ids @:# --make-bed --recode12 --out ${OUTpath}/${PREFIX}.KingClean.admix


#Go to Curta - admixture-wrapper.py only work in Curta
#python /srv/public/users/larissasa/programs/admixture-wrapper-master/admixture-wrapper.py -i $OUTpath --kmin 1 --kmax 10 --reps 20 --cv 10 -t 20


#mkdir $OUTpath
# Generate the input file in plink format
#/srv/public/shared/software/bin/plink --vcf $VCF_sorted --double-id --allow-extra-chr --set-missing-var-ids @:# --make-bed --out ${OUTpath}/${PREFIX}.admix

# ADMIXTURE does not accept chromosome names that are not human chromosomes.
#cat ${OUTpath}/${PREFIX}.admix.bim | sed s/^Super-Scaffold_//g | sed s/ptg000030l_1_subseq_153303_obj/28/g | sed s/ptg000065l_1_obj/28/g | sed s/100009/28/g | sed s/100080/28/g | sed s/627/28/g | sed s/508/28/g | sed s/389/28/g | sed s/319/28/g | sed s/273/28/g | sed s/270/28/g | sed s/189/28/g | sed s/164/28/g | sed s/143/28/g | sed s/142/28/g | sed s/141/28/g | sed s/131/28/g | sed s/124/28/g | sed s/123/28/g | sed s/83/28/g | sed s/81/28/g | sed s/79/28/g | sed s/78/28/g |sed s/77/28/g |sed s/73/28/g |sed s/67/28/g |sed s/59/28/g |sed s/53/28/g |sed s/48/28/g |sed s/46/28/g |sed s/45/28/g |sed s/43/28/g |sed s/39/28/g |sed s/37/28/g |sed s/36/28/g |sed s/34/28/g |sed s/33/28/g |sed s/32/28/g |sed s/31/28/g |sed s/30/28/g |sed s/29/28/g  > ${OUTpath}/${PREFIX}.admix.bim.tmp
#cat ${OUTpath}/${PREFIX}.admix.bim | sed s/^Super-Scaffold_//g | sed s/ptg000//g | sed s/l_1_subseq_793388:799761_obj//g | sed s/l_1_subseq_2340848:2392617_obj//g | sed s/l_1_subseq_1:358597_obj//g | sed s/l_1_subseq_4936395:5017097_obj//g |sed s/l_1_obj//g | sed s/l_1_subseq_107635667:108156518_obj//g | sed s/l_1_subseq_885624:3282209_obj//g | sed s/l_1_subseq_799762:815696_obj//g | sed 's/l_1_subseq_4584787:4890809_obj//g' | sed 's/l_1_subseq_620455:715826_obj//g'| sed 's/l_1_subseq_9042019:9189533_obj//g'| sed 's/l_1_subseq_1:205802_obj//g' | sed 's/l_1_subseq_43495590:43702808_obj//g' | sed 's/l_1_subseq_2491853:4275756_obj//g' | sed 's/l_1_subseq_165016546:166437111_obj//g' | sed 's/l_1_subseq_1757094:2386511_obj//g' | sed 's/l_1_subseq_1:802375_obj//g' | sed 's/l_1_subseq_1:2930126_obj//g' | sed 's/l_1_subseq_43702809:43914424_obj//g' | sed 's/l_1_subseq_1355157:1452460_obj//g' | sed 's/l_1_subseq_1:400907_obj//g' | sed 's/l_1_subseq_1:620454_obj//g' | sed 's/l_1_subseq_2930127:3079676_obj//g'   | sed 's/l_1_subseq_3056930:3668223_obj//g'  | sed 's/l_1_subseq_36251310:36326884_obj//g' | sed 's/l_1_subseq_1:84394_obj//g' | sed 's/l_1_subseq_73846532:74418758_obj//g' | sed 's/l_1_subseq_1:53303_obj//g' | sed 's/l_1_subseq_5228392:8232263_obj//g' | sed 's/l_1_subseq_1:1355156_obj//g' | sed 's/l_1_subseq_715827:1162161_obj//g' | sed 's/l_1_subseq_5219354:5228391_obj//g' | sed 's/l_1_subseq_5191140:5219353_obj//g' | sed 's/l_1_subseq_2392618:2491852_obj//g'| sed 's/l_1_subseq_2392618:2491852_obj//g'| sed 's/l_1_subseq_1:1774250_obj//g' | sed 's/l_1_subseq_153303_obj//g' > ${OUTpath}/${PREFIX}.admix.bim.tmp
#mv ${OUTpath}/${PREFIX}.admix.bim.tmp ${OUTpath}/${PREFIX}.admix.bim

#Now, we are ready to run ADMIXTURE. We will run it with cross-validation (the default is 5-fold CV, for higher, choose e.g. cv=10) and K=2.

#/srv/public/users/larissasa/programs/dist/admixture_linux-1.3.0/admixture --cv ${OUTpath}/Chol.admix.bed 2 -j16 > ${OUTpath}/k2.out

#for K in `seq -w 1 10`; do
#	/srv/public/users/larissasa/programs/dist/admixture_linux-1.3.0/admixture --cv ${OUTpath}/${PREFIX}.admix.bed $K > ${OUTpath}/k${K}.out
#done

#Segmentation fault --> RUN IN CURTA
#The seq command generates a sequence of numbers, and the -w flag tells it to pad the numbers with zeros (i.e., 01, 02,  ^`  19, 20).
#The --cv flag tells admixture to calculate cross-validation error rates, which we will use to determine the optimal K value.

#/srv/public/shared/software/bin/plink --vcf $VCF_sorted --double-id --allow-extra-chr --king-cutoff 0.0884 --set-missing-var-ids @:# --make-bed --recode12 --out ${OUTpath}/${PREFIX}.admix

#admixture-wrapper.py 	only work in curta
#python /srv/public/users/larissasa/programs/admixture-wrapper-master/admixture-wrapper.py -i $OUTpath --kmin 1 --kmax 10 --reps 20 --cv 10 -t 20


