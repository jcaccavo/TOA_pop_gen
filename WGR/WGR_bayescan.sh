input="FILENAME.geste_bayescan.txt"
output=".../OUTPUT_DIRECTORY"

.../bayescan_2.1 $input -o $output -n 5000 -thin 10 -nbp 20 -pilot 5000 -burn 50000 -pr_odds 10 -threads 20 -all_trace
