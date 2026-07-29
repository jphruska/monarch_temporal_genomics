#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=angsd_2x_pi_1953_1959_calc_pi_no_trans_downsampled_final_even_b
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genetic_diversity_pi/logs/angsd_2x_calculate_pi_1953_1959_no_trans_downsampled_final_even_b/%j.out

# define working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/07_diversity_pi_1953_1959_no_trans_downsampled_final_even

var1=$(cut -f 5 ${workdir}/2x_1953_1959.thetas.idx.pestPG | tail -n 22 | awk '{sum+=$1} END {print sum}')
var2=$(cut -f 14 ${workdir}/2x_1953_1959.thetas.idx.pestPG | tail -n 22 | awk '{sum+=$1} END {print sum}')
pi=$(awk -v var1=$var1 -v var2=$var2 'BEGIN { print (var1/var2)}')
echo $pi >> ${workdir}/pi.txt
 
