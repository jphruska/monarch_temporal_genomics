#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_6x_genotype_final_for_gone_currentne_a
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-36
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genotyping/logs/bcftools_genotype_6x_final_for_gone_currentne_a/%j.out


module load bcftools/1.21


# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

basename_array=$( head -n${SLURM_ARRAY_TASK_ID} 6x_basenames_final_2023_2024.txt | tail -n1 )

# define the reference genome
refgenome=/work/sonsthagen/johruska/monarchs/reference_genome/GCF_018135715.1_MEX_DaPlex_genomic.fna

bcftools mpileup -f ${refgenome} \
-a "FORMAT/QS,FORMAT/AD,FORMAT/DP,INFO/AD" -B \
--min-MQ 30 --min-BQ 30 -Ou ${workdir}/00_bam_files_final/${basename_array}_pre_indel_realign_sorted_realigned_final.bam | \
bcftools call -m --threads 4 -a GQ,GP -Ou | \
bcftools filter -g 5 -i'QUAL >= 30' -Ou | \
bcftools view -V indels -M2 -Ou | \
bcftools +fill-tags -Ou -- -t all | \
bcftools +setGT -Ou -- -t q -n . -i"FMT/DP<5" | \
bcftools +setGT -Ou -- -t q -n . -i'GT="het" & (FMT/VAF < 0.20 | FMT/VAF > 0.80)' | \
bcftools +fill-tags -Ov -- -t all > ${workdir}/02_vcf_6x_final/${basename_array}.vcf
bgzip ${workdir}/02_vcf_6x_final/${basename_array}.vcf
tabix ${workdir}/02_vcf_6x_final/${basename_array}.vcf.gz
bcftools index ${workdir}/02_vcf_6x_final/${basename_array}.vcf.gz
