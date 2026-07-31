#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_depth_of_coverage_stats_downsampled_6x_final
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=1
#SBATCH --time=16:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/depth_of_coverage_downsampled_6x_final/%j.out

module purge
module load samtools/1.20

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/00_bam_files_6x_downsampled_final

# define output base directory
output_dir=/work/sonsthagen/johruska/monarchs/scripts/read_alignment/depth_of_coverage_downsampled_6x_final

# calculate average depth of coverage per individual (copied from biostars message board:https://www.biostars.org/p/5165/#9490811)

# genome size is the same for all individuals (245173502 bp in length)

for i in `cat 6x_basenames_final.txt` ; do samtools depth  -a ${workdir}/${i}_pre_indel_realign_sorted_realigned_final_downsampled_sorted.bam  |  awk '{sum+=$3} END { print sum/NR}' >> ${output_dir}/coverage_means.txt ; done  

# calculate standard deviation of depth of coverage per individual 

for i in `cat 6x_basenames_final.txt` ; do samtools depth  -a ${workdir}/${i}_pre_indel_realign_sorted_realigned_final_downsampled_sorted.bam  |  awk '{sum+=$3; sumsq+=$3*$3} END {print sqrt(sumsq/NR - (sum/NR)**2)}' >> ${output_dir}/coverage_stdev.txt ; done

# output sample names using basenames

for i in `cat 6x_basenames_final.txt` ; do echo ${i} >> ${output_dir}/sample_basenames.txt ; done

# paste together file of sample names and coverage

paste ${output_dir}/sample_basenames.txt ${output_dir}/coverage_means.txt ${output_dir}/coverage_stdev.txt >> ${output_dir}/monarch_coverage_stats.txt 
