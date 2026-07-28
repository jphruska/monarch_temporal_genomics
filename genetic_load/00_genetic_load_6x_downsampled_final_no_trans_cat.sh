#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=6x_downsampled_final_no_transitions_snpeff_load_cat
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=batch
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genetic_load/logs/6x_downsampled_final_no_transitions_snpeff_load_cat/%j.out

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/13_load_6x_downsampled_no_transitions_final

grep "^#C" ${workdir}/6x_downsampled_no_transitions_load_NC_083537.1.ann.vcf > ${workdir}/6x_downsampled_final_no_transitions_load.vcf

for i in $( ls ${workdir}/6x_downsampled_no_transitions_load_*.ann2.vcf ); do grep -v "^#" $i >> ${workdir}/6x_downsampled_final_no_transitions_load.vcf; done
