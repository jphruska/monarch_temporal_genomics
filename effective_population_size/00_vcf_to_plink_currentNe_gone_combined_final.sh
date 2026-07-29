#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=vcf_to_plink_combined_currentNe_gone_final
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=batch
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/effective_population_size/logs/vcf_to_plink_combined_currentNe_gone_final/%j.out


module load vcftools/0.1

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/15_currentNe2_6x_final/combined

vcftools --gzvcf ${workdir}/combined_currentne_gone.vcf.gz --plink --out ${workdir}/combined_currentne_gone_final
