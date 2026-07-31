#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_combined_alignment_unmerged
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-817
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/combined_bwa_aln_mapping_unmerged/%j.out

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

# define array of sequencing ID basenames (ending in _A, _B, _C, _D)
basename_array=$( head -n${SLURM_ARRAY_TASK_ID} combined_basenames.txt | tail -n1 )

# define the reference genome
refgenome=/work/sonsthagen/johruska/monarchs/reference_genome/GCF_018135715.1_MEX_DaPlex_genomic.fna

# define array of read group platform unit ID 
rgpu_array=$( head -n${SLURM_ARRAY_TASK_ID} rgpu_ids_combined.txt | tail -n1 )

# define array of individual ID (with _A, _B, _C, _D suffixes dropped)
sample_array=$( head -n${SLURM_ARRAY_TASK_ID} combined_ids_basenames.txt | tail -n1 )

# run bwa aln for unmerged reads 
module purge
module load bwa/0.7
bwa aln -t 12 -l 16500 -n 0.01 -o 2 ${refgenome} \
${workdir}/00_trimmed/${basename_array}_R1.fastq.gz \
> ${workdir}/00_bam_files/${basename_array}_R1.sai

bwa aln -t 12 -l 16500 -n 0.01 -o 2 ${refgenome} \
${workdir}/00_trimmed/${basename_array}_R2.fastq.gz \
> ${workdir}/00_bam_files/${basename_array}_R2.sai

# sampe for paired end data
bwa sampe ${refgenome} ${workdir}/00_bam_files/${basename_array}_R1.sai \
${workdir}/00_bam_files/${basename_array}_R2.sai \
${workdir}/00_trimmed/${basename_array}_R1.fastq.gz \
${workdir}/00_trimmed/${basename_array}_R2.fastq.gz \
> ${workdir}/00_bam_files/${basename_array}_unmerged.sam

# remove .sai files
rm ${workdir}/00_bam_files/${basename_array}_R1.sai
rm ${workdir}/00_bam_files/${basename_array}_R2.sai

# convert sam to bam
module purge
module load samtools/1.20
samtools view -b -S -o ${workdir}/00_bam_files/${basename_array}_unmerged.bam ${workdir}/00_bam_files/${basename_array}_unmerged.sam

# remove sam
rm ${workdir}/00_bam_files/${basename_array}_unmerged.sam

# clean up the bam file
module purge
module load gatk4/4.4
gatk CleanSam -I ${workdir}/00_bam_files/${basename_array}_unmerged.bam -O ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned.bam

# remove the raw bam
rm ${workdir}/00_bam_files/${basename_array}_unmerged.bam

# sort the cleaned bam file
gatk SortSam -I ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned.bam \
-O ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned_sorted.bam --SORT_ORDER coordinate

# remove the cleaned bam file
rm ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned.bam

# load gatk4 module
module purge
module load gatk4/4.4
# add read groups to sorted and cleaned bam file
gatk AddOrReplaceReadGroups -I ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned_sorted.bam \
-O ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned_sorted_rg.bam \
--RGID ${sample_array}.${rgpu_array} --RGLB 1 --RGPL ILLUMINA --RGPU ${rgpu_array} --RGSM ${sample_array}

# remove cleaned and sorted bam file
rm ${workdir}/00_bam_files/${basename_array}_unmerged_cleaned_sorted.bam
