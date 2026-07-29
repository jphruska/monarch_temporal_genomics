#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=angsd_2x_pi_1996_2003_calc_pi_no_trans_downsampled_final_even
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genetic_diversity_pi/logs/angsd_2x_calculate_pi_1996_2003_no_trans_downsampled_final_even/%j.out

# define reference genome/location
ref=/work/sonsthagen/johruska/monarchs/reference_genome/GCF_018135715.1_MEX_DaPlex_genomic.fna

# define working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/07_diversity_pi_1996_2003_no_trans_downsampled_final_even

# define angsd directory to v 0.940
angsd_dir=/home/sonsthagen/johruska/.conda/envs/angsdv0.940/bin/

# run saf2theta
${angsd_dir}/realSFS saf2theta \
${workdir}/2x_1996_2003.saf.saf.idx \
-outname ${workdir}/2x_1996_2003 \
-sfs ${workdir}/2x_1996_2003.saf.saf.sfs.folded.trimmed \
-fold 1 
 
# run thetastat
${angsd_dir}/thetaStat do_stat \
${workdir}/2x_1996_2003.thetas.idx
