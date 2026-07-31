#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_indel_realignment_final
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-250
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/indel_realignment_final/%j.out

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/00_bam_files_final

# define the reference genome
ref_genome=/work/sonsthagen/johruska/monarchs/reference_genome/GCF_018135715.1_MEX_DaPlex_genomic.fna

# define array of sequencing ID basenames for total dataset
basename_array=$( head -n${SLURM_ARRAY_TASK_ID} total_basenames.txt | tail -n1 )

# load gatk v3.7-0-gcfedb67
module purge
module load gatk/3.7

## Run the indel realigner tool
java -Xmx40g -jar /util/opt/BCRF/gatk/3.7/GenomeAnalysisTK.jar \
-T IndelRealigner \
-R ${ref_genome} \
-I ${workdir}/${basename_array}_pre_indel_realign_sorted.bam \
-targetIntervals ${workdir}/all_samples_for_indel_realigner.intervals \
--consensusDeterminationModel USE_READS  \
--nWayOut _realigned_final.bam
