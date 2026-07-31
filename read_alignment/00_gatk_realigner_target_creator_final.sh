#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_indel_realignment_target_creator_final
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=40G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/indel_realignment_target_creator_final/%j.out

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/00_bam_files_final

# define the reference genome
ref_genome=/work/sonsthagen/johruska/monarchs/reference_genome/GCF_018135715.1_MEX_DaPlex_genomic.fna

# load gatk v3.7-0-gcfedb67
module purge
module load gatk/3.7

## Create list of potential in-dels
java -Xmx40g -jar /util/opt/BCRF/gatk/3.7/GenomeAnalysisTK.jar \
-T RealignerTargetCreator \
-R ${ref_genome} \
-I indel_realign_bam_list_final.list \
-o ${workdir}/all_samples_for_indel_realigner.intervals \
-drf BadMate \
-nt 12 
