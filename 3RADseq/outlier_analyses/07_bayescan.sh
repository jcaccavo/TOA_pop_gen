input="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/05_bayescan/02_bayescan_run_2/bayescan_input2"
output="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/05_bayescan/02_bayescan_run_2"

/srv/public/users/larissasa/programs/BayeScan2.1/source/bayescan_2.1 $input -o $output -n 5000 -thin 10 -nbp 20 -pilot 5000 -burn 50000 -pr_odds 10 -threads 20 -all_trace
