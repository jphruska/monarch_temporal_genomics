#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=angsd_2x_winsfs_fst_1931_1946_1953_1959_no_trans_downsampled_final_even
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=20G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genetic_differentiation_fst/logs/angsd_2x_winsfs_calculate_fst_1931_1946_1953_1959_no_trans_downsampled_final_even/%j.out

# define working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/

# define angsd directory to v 0.940
angsd_dir=/home/sonsthagen/johruska/.conda/envs/angsdv0.940/bin/

# generate 2dsfs 
winsfs \
${workdir}/07_diversity_pi_1931_1946_no_trans_downsampled_final_even/2x_1931_1946.saf.saf.idx \
${workdir}/07_diversity_pi_1953_1959_no_trans_downsampled_final_even/2x_1953_1959.saf.saf.idx \
> ${workdir}/07_1931_1946_1953_1959_fst_no_trans_downsampled_final_even/1931_1946_1953_1959.2dsfs
 
winsfs view -f \
${workdir}/07_1931_1946_1953_1959_fst_no_trans_downsampled_final_even/1931_1946_1953_1959.2dsfs > ${workdir}/07_1931_1946_1953_1959_fst_no_trans_downsampled_final_even/1931_1946_1953_1959.2dsfs.folded

cat ${workdir}/07_1931_1946_1953_1959_fst_no_trans_downsampled_final_even/1931_1946_1953_1959.2dsfs.folded | tail -1 > ${workdir}/07_1931_1946_1953_1959_fst_no_trans_downsampled_final_even/1931_1946_1953_1959.2dsfs.folded.trimmed

# calc fst
${angsd_dir}/realSFS fst index \
${workdir}/07_diversity_pi_1931_1946_no_trans_downsampled_final_even/2x_1931_1946.saf.saf.idx \
${workdir}/07_diversity_pi_1953_1959_no_trans_downsampled_final_even/2x_1953_1959.saf.saf.idx \
-sfs ${workdir}/07_1931_1946_1953_1959_fst_no_trans_downsampled_final_even/1931_1946_1953_1959.2dsfs.folded.trimmed \
-fstout ${workdir}/07_1931_1946_1953_1959_fst_no_trans_downsampled_final_even/1931_1946_1953_1959

# calc fst
${angsd_dir}/realSFS fst stats \
${workdir}/07_1931_1946_1953_1959_fst_no_trans_downsampled_final_even/1931_1946_1953_1959.fst.idx
