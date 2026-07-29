#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=combined_concatenate_vcfs_current_ne_gone_final
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/effective_population_size/logs/combined_concatenate_vcfs_current_ne_gone_final/%j.out

module load bcftools/1.21

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/15_currentNe2_6x_final/combined/

bcftools concat \
-f ./combined_vcf_list_final_6x.txt \
-o ${workdir}/combined_currentne_gone.vcf 

# bgzip concatenated file for bcftools
bgzip ${workdir}/combined_currentne_gone.vcf
