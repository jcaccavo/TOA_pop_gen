#!/bin/bash

#SBATCH --nodes=1   
#SBATCH --ntasks=32
#SBATCH --partition=begendiv,main 
#SBATCH --time=5-00:00 
#SBATCH --mem=6000
#SBATCH --job-name=Admixture
#SBATCH -o /scratch/jcaccavo/Admixture/Admixture.out
#SBATCH -e /scratch/jcaccavo/Admixture/Admixture.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=jcaccavo@zedat.fu-berlin.de
#SBATCH --qos=standard

Path="/scratch/jcaccavo/Admixture2021/3_subarea_p3_p1r0.6/min10max120miss0.75_1SNPperlocus"

#See preparation of input files in Lagoa: /srv/public/users/larissasa/choloepus/12_3RAD_PopAnalysis/x_scripts/21_Admixture.sh
#Now, we are ready to run ADMIXTURE. We will run it with cross-validation (the default is 5-fold CV, for higher, choose e.g. cv=10).

python2 /scratch/larissasa/Elephants/RADseq/Admixture/admixture-wrapper.py -i ${Path} --kmin 1 --kmax 10 --reps 5 --cv 5

#The --cv flag tells admixture to calculate cross-validation error rates, which we will use to determine the optimal K value.
#reps = number of replicates
#t = number of threads

#To identify the best value of k clusters which is the value with lowest cross-validation error, we need to collect the cv errors. 
#grep "CV" *out | awk '{print $3,$4}' | sed -e 's/(//;s/)//;s/://;s/K=//'  > Toothfish.cv.error

 
#SLURM useful commands
#1)Submit a job script:
#sbatch <job.sh> 
#2)Check on a submitted job:
#squeue
#squeue -u <user-name>
#3)Cancel a submitted job:
#scancel <job-id>
