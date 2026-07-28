
## Input: vcf, simplified, that includes invariant and variant sites. 
## Impute heterozygous sites, per individual per vcf, extract number of heterozygous sites. 
## Extract length of each vcf, to calculate heterozygosity per individual for that vcf. 
## Heterozygosity = total number of heterozygous sites/total number of sites. 

# read in list of individuals (ordered by how they appear in VCF)

indiv <- read.table(file = "het_individuals_final.txt")

# list all of the vcf files 
vcfs <- list.files(path="/work/sonsthagen/johruska/monarchs/sequence_data/data/07_het_6x_downsampled_final/", pattern="*notrans.simple.vcf")

# paste path to vcfs

vcfs1 <- c()

for (i in 1:length(vcfs)) {
  vcfs1[i] <- paste("/work/sonsthagen/johruska/monarchs/sequence_data/data/07_het_6x_downsampled_final/", vcfs[i], sep = "")
}

# generate total sites vector with for loop

# empty vector for total sites
total_sites <- c()

for(i in 1:nrow(indiv)) {
  total_sites[i] <- paste(indiv[i,], "_total_sites", sep = "")
}

# empty vector for het sites
het_sites <- c()

for(i in 1:nrow(indiv)) {
  het_sites[i] <- paste(indiv[i,], "_het_sites", sep = "")
}


# empty vector for het output
het <- c()

for(i in 1:nrow(indiv)) {
  het[i] <- paste(indiv[i,], "_het", sep = "")
}

# write het output file
write(c("VCF", total_sites, het_sites, het), 
file=paste("./output.final.het.txt", sep=""), ncolumns=169, sep="\t")


# calculate per-chromosome heterozygosity, per individual. Store output in output.final.het.txt 
for (a in 1:22) {
  # vectors for output
  indiv_het_sites <- c()
  indiv_total <- c()
  output_rep <- c()
  indiv_het <- c()
  # read in vcf files 
  vcf_file <- read.table(vcfs1[a], stringsAsFactors = F)
  # remove first three columns 
  vcf_indiv <- vcf_file[,4:58]
  # another for loop here
  for (b in 1:55) {
    # select individual 
    indiv <- vcf_indiv[,b]
    # remove missing genotypes
    indiv <- indiv[indiv != "./."]
    # count number of sites 
    indiv_total[b] <- length(indiv)
    # remove phasing information
    indiv <- gsub("\\|", "/", indiv)
    # count number of heterozygous sites
    indiv_het_sites[b] <- length(indiv[indiv == "0/1"])
    # calculate heterozygosity
    indiv_het[b] <- indiv_het_sites[b]/indiv_total[b]  
  }
  # create vector of output, per vcf
  output_rep <- c(vcfs[a], indiv_total, indiv_het_sites, indiv_het)
  # add to output file, append
  write(output_rep, file="output.final.het.txt", append=T, ncolumns=169, sep="\t")
}
