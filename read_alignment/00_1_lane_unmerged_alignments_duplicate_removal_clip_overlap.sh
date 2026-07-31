#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=1_lane_unmerged_alignments_duplicate_removal_clip_overlap
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-97
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/1_lane_unmerged_dup_removal_clip/%j.out

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

basename_array=$( head -n${SLURM_ARRAY_TASK_ID} basenames_one_lane.txt | tail -n1 )

# load gatk4 module
module purge
module load gatk4/4.4

# remove duplicates
gatk MarkDuplicates --REMOVE_DUPLICATES true --MAX_FILE_HANDLES_FOR_READ_ENDS_MAP 100 \
--OPTICAL_DUPLICATE_PIXEL_DISTANCE 2500 \
-M ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned_sorted_markdups_metric_file.txt \
-I ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned_sorted_rg.bam \
-O ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned_sorted_dup_rm.bam

# clip overlaps with bamUtil

# bamUtil --version 1.0.15 
module purge 

/home/sonsthagen/johruska/.conda/envs/bamUtil/bin/bam clipOverlap \
--in ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned_sorted_dup_rm.bam \
--out ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned_sorted_dup_rm_clip.bam \
--unmapped \
--stats

# fix mate information
module purge 
module load gatk4/4.4

gatk FixMateInformation \
I=${workdir}/00_bam_files/${basename_array}_unmerged_cleaned_sorted_dup_rm_clip.bam \
O=${workdir}/00_bam_files/${basename_array}_unmerged_combined_mate_fixed_realign.bam \
ADD_MATE_CIGAR=true

# sort mate fixed bam 
gatk SortSam -I ${workdir}/00_bam_files/${basename_array}_unmerged_combined_mate_fixed_realign.bam \
-O ${workdir}/00_bam_files/${basename_array}_unmerged_combined_mate_fixed_realign_sorted.bam --SORT_ORDER coordinate

# load samtools/1.20 module
module purge
module load samtools/1.20

# index pre indel realign bam file
samtools index ${workdir}/00_bam_files/${basename_array}_unmerged_combined_mate_fixed_realign_sorted.bam 
