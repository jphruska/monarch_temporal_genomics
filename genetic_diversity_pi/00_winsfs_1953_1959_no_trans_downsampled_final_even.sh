#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=winsfs_pop_1953_1959_no_trans_downsampled_final_even
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=20G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genetic_diversity_pi/logs/winsfs_pop_1953_1959_no_trans_downsampled_final_even/%j.out

# define working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

winsfs ${workdir}/07_diversity_pi_1953_1959_no_trans_downsampled_final_even/2x_1953_1959.saf.saf.idx > ${workdir}/07_diversity_pi_1953_1959_no_trans_downsampled_final_even/2x_1953_1959.saf.saf.sfs

winsfs view -f ${workdir}/07_diversity_pi_1953_1959_no_trans_downsampled_final_even/2x_1953_1959.saf.saf.sfs > ${workdir}/07_diversity_pi_1953_1959_no_trans_downsampled_final_even/2x_1953_1959.saf.saf.sfs.folded

cat ${workdir}/07_diversity_pi_1953_1959_no_trans_downsampled_final_even/2x_1953_1959.saf.saf.sfs.folded | tail -1 > ${workdir}/07_diversity_pi_1953_1959_no_trans_downsampled_final_even/2x_1953_1959.saf.saf.sfs.folded.trimmed


