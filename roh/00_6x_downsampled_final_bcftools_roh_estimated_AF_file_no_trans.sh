#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=bcftools_roh_6x_downsampled_final_no_transitions_estimate_AF_file
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/roh/logs/6x_downsampled_final_roh_no_trans_estimate/%j.out


module load bcftools/1.21

# define working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/06_roh_6x_downsampled_final_no_transitions


# annotate vcf for AF tags
bcftools +fill-tags ${workdir}/6x_downsampled_roh_final_no_transitions.vcf.gz -Ob -o ${workdir}/6x_downsampled_no_transitions_roh_af_tag.vcf -- -t AF 

# create file of AF frequencies 
bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%AF\n' ${workdir}/6x_downsampled_no_transitions_roh_af_tag.vcf | bgzip -c > ${workdir}/AF.tab.gz && tabix -s1 -b2 -e2 ${workdir}/AF.tab.gz

# bcftools roh 
bcftools roh -G 30 --rec-rate 6.5788e-6 --skip-indels \
--AF-file ${workdir}/AF.tab.gz ${workdir}/6x_downsampled_no_transitions_roh_af_tag.vcf -O r \
-o ${workdir}/6x_downsampled_roh_no_trans.txt
