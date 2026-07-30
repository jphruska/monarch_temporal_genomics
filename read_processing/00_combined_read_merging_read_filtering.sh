#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=combined_seqprep_nf_polish_merging_read_processing
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=2
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --array=1-817
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_processing/logs/combined_read_merging_trimming/%j.out

workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/

basename_array=$( head -n ${SLURM_ARRAY_TASK_ID} combined_basenames.txt | tail -n1 )

# trim poly-g tails first
module load bbmap/39.06
bbduk.sh \
in1=${workdir}/00_fastq/${basename_array}_R1.fastq.gz in2=${workdir}/00_fastq/${basename_array}_R2.fastq.gz \
out1=${workdir}/00_trimmed/${basename_array}_polyG_trimmed_R1.fastq.gz out2=${workdir}/00_trimmed/${basename_array}_polyG_trimmed_R2.fastq.gz \
qtrim=rl trimq=10 \
trimpolygright=25 \
trimpolya=25 \
literal=GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG 

# run seqprep2 for read merging 
/home/sonsthagen/johruska/SeqPrep2_1/SeqPrep2/SeqPrep2 \
-f ${workdir}/00_trimmed/${basename_array}_polyG_trimmed_R1.fastq.gz \
-r ${workdir}/00_trimmed/${basename_array}_polyG_trimmed_R2.fastq.gz \
-1 ${workdir}/00_trimmed/${basename_array}_unmerged_R1.fastq.gz \
-2 ${workdir}/00_trimmed/${basename_array}_unmerged_R2.fastq.gz \
-3 ${workdir}/00_trimmed/${basename_array}_discarded_R1.fastq.gz \
-4 ${workdir}/00_trimmed/${basename_array}_discarded_R2.fastq.gz \
-A AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
-B AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
-y J \
-q 13 \
-L 30 \
-S \
-s ${workdir}/00_trimmed/${basename_array}_merged.fastq.gz 

# remove low-complexity reads with nf-polish
/home/sonsthagen/johruska/nf-polish/bin/remove_low_complex.py \
-1 ${workdir}/00_trimmed/${basename_array}_unmerged_R1.fastq.gz \
-2 ${workdir}/00_trimmed/${basename_array}_unmerged_R2.fastq.gz \
-u ${workdir}/00_trimmed/${basename_array}_merged.fastq.gz \
-c 0.50 \
-p ${workdir}/00_trimmed/${basename_array}

# gzip nf-polish output
gzip ${workdir}/00_trimmed/${basename_array}_R1.fastq
gzip ${workdir}/00_trimmed/${basename_array}_R2.fastq
gzip ${workdir}/00_trimmed/${basename_array}_U.fastq
gzip ${workdir}/00_trimmed/${basename_array}_low_complex.fastq
