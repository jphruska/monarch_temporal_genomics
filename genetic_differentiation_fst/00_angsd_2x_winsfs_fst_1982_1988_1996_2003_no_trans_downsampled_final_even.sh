#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=angsd_2x_winsfs_fst_1982_1988_1996_2003_no_trans_downsampled_final_even
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=20G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genetic_differentiation_fst/logs/angsd_2x_winsfs_calculate_fst_1982_1988_1996_2003_no_trans_downsampled_final_even/%j.out

# define working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/

# define angsd directory to v 0.940
angsd_dir=/home/sonsthagen/johruska/.conda/envs/angsdv0.940/bin/

# generate 2dsfs 
winsfs \
${workdir}/07_diversity_pi_1982_1988_no_trans_downsampled_final_even/2x_1982_1988.saf.saf.idx \
${workdir}/07_diversity_pi_1996_2003_no_trans_downsampled_final_even/2x_1996_2003.saf.saf.idx \
> ${workdir}/07_1982_1988_1996_2003_fst_no_trans_downsampled_final_even/1982_1988_1996_2003.2dsfs
 
winsfs view -f \
${workdir}/07_1982_1988_1996_2003_fst_no_trans_downsampled_final_even/1982_1988_1996_2003.2dsfs > ${workdir}/07_1982_1988_1996_2003_fst_no_trans_downsampled_final_even/1982_1988_1996_2003.2dsfs.folded

cat ${workdir}/07_1982_1988_1996_2003_fst_no_trans_downsampled_final_even/1982_1988_1996_2003.2dsfs.folded | tail -1 > ${workdir}/07_1982_1988_1996_2003_fst_no_trans_downsampled_final_even/1982_1988_1996_2003.2dsfs.folded.trimmed

# calc fst
${angsd_dir}/realSFS fst index \
${workdir}/07_diversity_pi_1982_1988_no_trans_downsampled_final_even/2x_1982_1988.saf.saf.idx \
${workdir}/07_diversity_pi_1996_2003_no_trans_downsampled_final_even/2x_1996_2003.saf.saf.idx \
-sfs ${workdir}/07_1982_1988_1996_2003_fst_no_trans_downsampled_final_even/1982_1988_1996_2003.2dsfs.folded.trimmed \
-fstout ${workdir}/07_1982_1988_1996_2003_fst_no_trans_downsampled_final_even/1982_1988_1996_2003

# calc fst
${angsd_dir}/realSFS fst stats \
${workdir}/07_1982_1988_1996_2003_fst_no_trans_downsampled_final_even/1982_1988_1996_2003.fst.idx
