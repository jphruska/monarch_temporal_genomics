#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=call_genotypes_imputing_phasing_for_fine_structure_full
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=8
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/pop_structure/logs/call_genotypes_imputing_phasing_for_fine_structure_full/%j.out

# load python-3.3 (for some reason it only works this way, by loading python-3.4 first. I don't know why.)
source activate python-3.4
source activate python-3.3

module load tabix/0.2
module load bcftools 

workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

python /home/sonsthagen/johruska/pcangsd-v.0.99/pcangsd.py \
-b ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag.beagle.gz \
-e 4 \
-o ${workdir}/04_fine_structure_full/all_pca_e4 \
-post_save 

# replace first underscore in chromosome names so beagle2vcf.awk can properly parse beagle file
sed -E -i 's/^NC\_/NC\./g' ${workdir}/04_fine_structure_full/all_pca_e4.post.beagle

# convert beagle to vcf
awk -f /home/sonsthagen/johruska/beagle2vcf/beagle2vcf.awk \
${workdir}/04_fine_structure_full/all_pca_e4.post.beagle > ${workdir}/04_fine_structure_full/file.tmp.vcf

# replace ALT and REF designations from (0-3) to (ACGT)
cat ${workdir}/04_fine_structure_full/file.tmp.vcf | awk 'BEGIN{nuc[0]="A";nuc[1]="C";nuc[2]="G";nuc[3]="T";OFS="\t"}{if(NR>1){$4=nuc[$4];$5=nuc[$5]} print $0}' > ${workdir}/04_fine_structure_full/file.tmp2.vcf

# add VCF file format header so bcftools can read it 
sed -i '1i\##fileformat=VCFv4.2' ${workdir}/04_fine_structure_full/file.tmp2.vcf
sed -i '2i\##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">' ${workdir}/04_fine_structure_full/file.tmp2.vcf 
sed -i '3i\##FORMAT=<ID=PL,Number=G,Type=Integer,Description="Normalized, Phred-scaled likelihoods for genotypes as defined in the VCF specification">' ${workdir}/04_fine_structure_full/file.tmp2.vcf

bcftools reheader -s ${workdir}/04_fine_structure_full/6x_downsampled_final_ids.txt ${workdir}/04_fine_structure_full/file.tmp2.vcf \
-o ${workdir}/04_fine_structure_full/file3.vcf

bgzip ${workdir}/04_fine_structure_full/file3.vcf

tabix ${workdir}/04_fine_structure_full/file3.vcf.gz 

module load java

java -Xmx64G -jar /home/sonsthagen/johruska/beagle.08Jun17.d8b.jar nthreads=8 gl=${workdir}/04_fine_structure_full/file3.vcf.gz out=${workdir}/04_fine_structure_full/imputed

java -Xmx64G -jar /home/sonsthagen/johruska/beagle.08Jun17.d8b.jar nthreads=8 gt=${workdir}/04_fine_structure_full/imputed.vcf.gz out=${workdir}/04_fine_structure_full/phased
