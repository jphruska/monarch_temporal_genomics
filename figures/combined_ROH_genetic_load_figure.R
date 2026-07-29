
library(ggplot2)
library(cowplot)

# read in bcftools ROH output

roh_table <- read.table("6x_downsampled_roh_no_trans.txt", sep = "\t", header = F)

# header example 
# RG	[2]Sample	[3]Chromosome	[4]Start	[5]End	[6]Length (bp)	[7]Number of markers	[8]Quality (average fwd-bwd phred score)


# subset runs that are greater than 100 kb 

roh_table_greater_100kb <- roh_table[roh_table$V6 >= 100000,] # 16 runs remain

# subset runs with Phred scored greater than 85 

roh_table_filtered <- roh_table_greater_100kb[roh_table_greater_100kb$V8 >= 85,] # 12 runs remain

# for loop to sum ROH lengths per individual 

# initialize vectors for outputs

per_individual_sums <- c ()
individual_names <- c ()

for (a in 1:length((unique(roh_table_filtered$V2)))) {
  # extract individual name
  individual_names[a] <- print(unique(roh_table_filtered$V2)[a])
  # print names 
  print(individual_names[a])
  # subset dataframe by individual and sum total length of ROH (column 6)
  per_individual_sums[a] <- sum(roh_table_filtered[roh_table_filtered$V2 == individual_names[a],]$V6)
}

# cbind ROH sums and individuals in one dataframe
roh_dataframe <- cbind(individual_names, as.numeric(per_individual_sums))


# for loop to count ROH lengths per individual 

# initialize vectors for outputs

per_individual_counts <- c ()
individual_names <- c ()

for (a in 1:length((unique(roh_table_filtered$V2)))) {
  # extract individual name
  individual_names[a] <- print(unique(roh_table_filtered$V2)[a])
  # print names 
  print(individual_names[a])
  # subset dataframe by individual and sum total length of ROH (column 6)
  per_individual_counts[a] <- length(roh_table_filtered[roh_table_filtered$V2 == individual_names[a],]$V6)
}


# add population information to dataframe 
population_IDs <- c(paste(rep("NE",1)), paste(rep("CA",1)), paste(rep("NE",1)), paste(rep("CA",1)),
                    paste(rep("KS",2)), paste(rep("NE",2)), paste(rep("KS",1)))


# add year to dataframe 
year <- c(2024,2024,2024,1973,2023,2023,2024,2024,2023)

# cbind pop_IDs to dataframe 
roh_dataframe_pop_IDs <- as.data.frame(cbind(roh_dataframe, population_IDs))


# cbind year to dataframe 
roh_dataframe_pop_IDs <- as.data.frame(cbind(roh_dataframe_pop_IDs, year))

# name roh column 
colnames(roh_dataframe_pop_IDs)[2] <- "sum_roh" 

# change sum_roh for character to numeric
roh_dataframe_pop_IDs$sum_roh <- as.numeric(roh_dataframe_pop_IDs$sum_roh)

# cbind counts to dataframe 
roh_dataframe_pop_IDs <- as.data.frame(cbind(roh_dataframe_pop_IDs, per_individual_counts))

# change individual counts to numeric
roh_dataframe_pop_IDs$per_individual_counts <- as.numeric(roh_dataframe_pop_IDs$per_individual_counts)

# add time period vector to dataframe 

roh_dataframe_pop_IDs$Time_Period <- c("2023-2024", "2023-2024", "2023-2024", "1967-1974", "2023-2024", "2023-2024", "2023-2024", "2023-2024", "2023-2024")

# plot of sum_roh by number of roh

a1 <- ggplot(roh_dataframe_pop_IDs, aes(x=per_individual_counts, y=(sum_roh)/1e6, fill = Time_Period)) +
  geom_point(size = 3, shape = 21) +
  #scale_fill_manual(values = c("darkorange", "cyan4", "brown3", "blue3")) +
  scale_fill_manual(values = c("1967-1974" = "tan", 
                               "2023-2024" = "white")) +
  scale_x_continuous(breaks = seq(1,3,by = 1)) + 
  #stat_summary(fun.y=mean, geom="point", shape=20, size=4, color="black", fill="black") + 
  theme_cowplot(12) +
  ylab("Sum ROH (Mb)") +
  xlab("Number of ROH (>= 100 kb)") +
  theme_cowplot(12) +
  theme(legend.position = "none")

# plot of inbreeding coefficient (FROH) by year, as a proportion of autosomal genome
b1 <- ggplot(roh_dataframe_pop_IDs, aes(x=year, y=((sum_roh)/167201495), fill =  Time_Period)) + # chromosome length - Z chromosome 
  geom_point(size = 3, shape = 21) +
  #scale_fill_manual(values = c("darkorange", "cyan4", "brown3", "blue3")) +
  scale_fill_manual(values = c("1967-1974" = "tan", 
                               "2023-2024" = "white")) +
  #stat_summary(fun.y=mean, geom="point", shape=20, size=4, color="black", fill="black") + 
  theme_cowplot(12) +
  ylab(bquote(italic("F")["ROH >= 100 kb"])) +
  xlab("Year") + 
  theme_cowplot(12) + 
  theme(legend.position = "none")

pattern <- c("a1", "b1")

plot_grid(plotlist = mget(pattern), ncol = 2, labels = c('A', 'B'))


library(cowplot)
library(tidyverse)
options(scipen=999)

popmap <- read.table("monarch_popmap.txt", header=T)

##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
snpeff <- read.table("6x_downsampled_final_no_transitions_load.vcf", sep="\t", header=T, stringsAsFactors=F, comment.char="$")

# keep impact of variants
impact <- sapply(strsplit(snpeff[,8], "\\|"), "[[", 3)
table(impact)
type_mutation <- sapply(strsplit(snpeff[,8], "\\|"), "[[", 2)

# keep only the raw genotype data
for(a in 10:ncol(snpeff)) { snpeff[,a] <- substr(snpeff[,a], 1, 3) }
# genotypes 
genotypes <- snpeff[,10:ncol(snpeff)]

# potential load
potential_load <- c()
for(a in 1:ncol(genotypes)) {
  keep <- genotypes[,a] != "./."
  a_genotypes <- genotypes[keep,a]
  a_impact <- impact[keep]
  
  # keep only non-reference
  a_impact <- a_impact[a_genotypes != "0/0"]
  a_genotypes <- a_genotypes[a_genotypes != "0/0"]
  
  # snps with potential impact in individual
  a_potential <- length(a_impact[a_impact == "HIGH" | a_impact == "MODERATE"]) / length(a_impact)
  potential_load <- c(potential_load, a_potential)
}


# realized load
realized_load <- c()
for(a in 1:ncol(genotypes)) {
  keep <- genotypes[,a] != "./."
  a_genotypes <- genotypes[keep,a]
  a_impact <- impact[keep]
  
  # keep only non-reference
  a_impact <- a_impact[a_genotypes != "0/0"]
  a_genotypes <- a_genotypes[a_genotypes != "0/0"]
  
  # snps with homozygous derived missense or nonsense
  a_genotypes <- a_genotypes[a_impact != "LOW"]
  a_impact <- a_impact[a_impact != "LOW"]
  
  # realized load
  a_realized <- length(a_genotypes[a_genotypes == "1/1"]) / length(a_impact)
  
  realized_load <- c(realized_load, a_realized)
}

output <- data.frame(id=as.character(colnames(genotypes)), potential_load=as.numeric(potential_load), realized_load=as.numeric(realized_load))

total_output <- output

##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################

# check that popmap and output have same order, if not, reorder
table(total_output$individual == popmap$individual)
# all TRUE

# add output to popmap
popmap <- cbind(popmap, total_output[,2:3])

# write output table
write.table(popmap, file="ind_stats_load.txt", quote=F, row.names=F, col.names=T, sep="\t")


# plot realized and potential load across populations and years

# read in information regarding depth of coverage and year
#depth_of_coverage_year <- read.table(file = "id_depth_of_coverage_year.txt", header = T)

# merge datasets by individual
merged_dataset <- popmap

cor.test(merged_dataset$potential_load, merged_dataset$date)

# make labels for plotting
lb1 <- "italic(r) == 0.0060"
lb2 <- "italic(p) == 0.9655"

# potential load by year (time period)
a2 <- ggplot(merged_dataset, aes(x=date, y=potential_load)) +
  geom_point(aes(fill = time_period, stroke = 1), shape = 21) +
  geom_point(aes(fill=time_period), shape = 21, col = "black", size = 3) + 
  scale_fill_manual(values = c("1901-1929" = "black", "1931-1946" = "gray", "1953-1959" = "darkgoldenrod", 
                               "1967-1974" = "tan", "1982-1988" = "orange", "1996-2003" = "yellow", 
                               "2023-2024" = "white")) +
  ylim(0, 0.7) +
  #geom_boxplot(aes(col = population)) +
  geom_smooth(method = "lm") +
  annotate("text",
           x = 1970,
           y = 0.2, 
           label = lb1, parse = TRUE) +
  annotate("text",
           x = 1982,
           y = 0.2, 
           label = lb2, parse = TRUE) +
  #stat_summary(fun.y=mean, geom="point", shape=20, size=4, color="black", fill="black") + 
  theme_cowplot(12) +
  theme(legend.position = "none") +
  ylab("Potential Load")+
  xlab("Year")

cor.test(merged_dataset$realized_load, merged_dataset$date)

lb1 <- "italic(r) == 0.138"
lb2 <- "italic(p) == 0.3135"

b2 <- ggplot(merged_dataset, aes(x=date, y=realized_load)) +
  geom_point(aes(fill=time_period), shape = 21, col = "black", size = 3) + 
  scale_fill_manual(values = c("1901-1929" = "black", "1931-1946" = "gray", "1953-1959" = "darkgoldenrod", 
                               "1967-1974" = "tan", "1982-1988" = "orange", "1996-2003" = "yellow", 
                               "2023-2024" = "white")) +
  ylim(0, 0.7) +
  #geom_boxplot(aes(col = population)) +
  geom_smooth(method = "lm") +
  annotate("text",
           x = 1970,
           y = 0.2, 
           label = lb1, parse = TRUE) +
  annotate("text",
           x = 1982,
           y = 0.2, 
           label = lb2, parse = TRUE) +
  #stat_summary(fun.y=mean, geom="point", shape=20, size=4, color="black", fill="black") + 
  theme_cowplot(12) +
  ylab("Realized Load")+
  theme(legend.position = "none") +
  xlab("Year")


pattern <- c("a1", "b1", "a2", "b2")


top <- plot_grid(plotlist = mget(pattern[1:2]), ncol = 2, labels = c('A', 'B'))

plot(top)

bottom <- plot_grid(plotlist = mget(pattern[3:4]), ncol = 2, labels = c('A', 'B'))

plot(bottom)

#plot_grid(top, bottom, nrow = 2)

