#!/bin/bash

for K in {2..11}; do
    bash wrapper_ngsAdmix.sh \
      -likes FILENAME.beagle.gz \
      -tol 0.00000000010 \
      -maxiter 5000 \
      -K ${K} \
      -P 40 \
      -o .../NGSadmix/FILENAME_${K}_50reps
done
