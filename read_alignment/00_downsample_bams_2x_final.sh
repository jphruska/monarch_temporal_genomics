#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_2x_bam_downsampling_final
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-171
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/downsample_bams_2x_final/%j.out

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

# define individual
indiv=$(head -n ${SLURM_ARRAY_TASK_ID} 2x_basenames_final.txt | tail -n 1)

# define depth of coverage (read in from file)
depth=$(head -n ${SLURM_ARRAY_TASK_ID} 2x_depth_final.txt | tail -n 1)

# define fraction to subsample (2/mean depth of coverage)
subsample_ratio=$(awk -v var1=2 -v var2=$depth 'BEGIN { print ( var1/ var2 ) }')

# load samtools/1.20 module
module load samtools/1.20
samtools view -s ${subsample_ratio} -b -h ${workdir}/00_bam_files_final/${indiv}_pre_indel_realign_sorted_realigned_final.bam \
> ${workdir}/00_bam_files_2x_downsampled_final/${indiv}_pre_indel_realign_sorted_realigned_final_downsampled.bam

# load gatk
module purge
module load gatk4/4.4

# sort bam files 
gatk SortSam -I ${workdir}/00_bam_files_2x_downsampled_final/${indiv}_pre_indel_realign_sorted_realigned_final_downsampled.bam \
-O ${workdir}/00_bam_files_2x_downsampled_final/${indiv}_pre_indel_realign_sorted_realigned_final_downsampled_sorted.bam --SORT_ORDER coordinate

# index bam files
module purge
module load samtools/1.20

# index downsampled and sorted bam file
samtools index ${workdir}/00_bam_files_2x_downsampled_final/${indiv}_pre_indel_realign_sorted_realigned_final_downsampled_sorted.bam
