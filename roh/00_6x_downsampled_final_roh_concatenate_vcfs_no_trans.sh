#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=roh_6x_downsampled_no_transitions_concatenate_vcfs
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=1
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/roh/logs/6x_downsampled_no_transitions_roh_trans/%j.out


module load bcftools/1.21


# define working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/06_roh_6x_downsampled_final_no_transitions


# generate list of vcf files 

ls ${workdir}/*notrans.vcf > roh_vcf_list_no_transitions_final.txt


bcftools concat \
-f ./roh_vcf_list_no_transitions_final.txt \
-o ${workdir}/6x_downsampled_roh_final_no_transitions.vcf 

# bgzip concatenated file for bcftools

bgzip ${workdir}/6x_downsampled_roh_final_no_transitions.vcf 
