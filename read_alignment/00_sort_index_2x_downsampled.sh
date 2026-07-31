#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_2x_downsampled_sort_index
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=1
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-198
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/2x_downsampled_sort_index/%j.out

module load gatk4/4.4

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

basename_array=$( head -n${SLURM_ARRAY_TASK_ID} 2x_basenames.txt | tail -n1 )

# sort bam files 
gatk SortSam -I ${workdir}/00_bam_files_2x_downsampled/${basename_array}_pre_indel_realign_sorted_realigned_final_downsampled.bam \
-O ${workdir}/00_bam_files_2x_downsampled/${basename_array}_pre_indel_realign_sorted_realigned_final_downsampled_sorted.bam --SORT_ORDER coordinate

# index bam files
module purge
module load samtools/1.20

# index downsampled and sorted bam file
samtools index ${workdir}/00_bam_files_2x_downsampled/${basename_array}_pre_indel_realign_sorted_realigned_final_downsampled_sorted.bam

# clean up

rm ${workdir}/00_bam_files_2x_downsampled/${basename_array}_pre_indel_realign_sorted_realigned_final_downsampled.bam

