#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_genome_prep
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=20G
#SBATCH -o /mnt/nrdstor/sonsthagen/johruska/logs/monarch_genome_prep/%j.out

module load samtools/1.20

module load bwa/0.7

module load gatk4/4.4

workdir=/mnt/nrdstor/sonsthagen/johruska/reference_genome/

samtools faidx ${workdir}/GCF_018135715.1_MEX_DaPlex_genomic.fna

bwa index ${workdir}/GCF_018135715.1_MEX_DaPlex_genomic.fna

gatk CreateSequenceDictionary R=${workdir}/GCF_018135715.1_MEX_DaPlex_genomic.fna O=${workdir}/GCF_018135715.1_MEX_DaPlex_genomic.dict
