library(tidyverse)
library(cowplot)

# read in het file

het <- read.delim(file="het.txt", sep = " ", header = T)

# extract year and locality from ID vector
year <- c()
locality <- c()

for (a in 1:length(het$ID)) {
  # extract year
  year[a] <- as.numeric(strsplit(het$ID, split = "_")[[a]][4])
  # extract locality 
  locality[a] <- strsplit(het$ID, split = "_")[[a]][3]
}

# assign population designation using a while loop

population <- c()

for (a in 1:length(locality)) {
  if (locality[a]=="BCA" | locality[a]=="CA" | locality[a]=="ID" | locality[a]=="OR") {
    population[a] <- paste("Western")
  }
  else {
    population[a] <- paste("Eastern")
  }
}


# add year, locality, and population to het dataset

het <- cbind(het, year, locality, population)

# plot het by year 

# plot showing heterozygosity x year relationship (colored by time period)
a1 <- ggplot(het, aes(x=year, y=het)) +
  geom_point() + 
  geom_point(aes(col=time_period)) + 
  geom_point(aes(fill=time_period), shape = 21, col = "black", size = 3) + 
  ylab(bquote(Heterozygosity~ind.^-1~bp^-1))+
  scale_fill_manual(values = c("1901-1929" = "black", "1931-1946" = "gray", "1953-1959" = "darkgoldenrod", 
                               "1969-1973" = "tan", "1982-1988" = "orange", "1996-2003" = "yellow", 
                               "2023-2024" = "white")) +
  xlab("Year") +
  ylim(0.0020, 0.0080) +
  #geom_smooth(method='lm', se = T) +
  geom_smooth() +
  theme_cowplot(12) +
  theme(legend.position = "top") +
  theme(legend.title = element_blank()) + 
  theme(legend.text = element_text(size = 7)) + 
  labs(fill = "Time Period", col = "Time Period") + 
  labs(col = "Time Period") 
  #guides(fill = "none") + 
  #guides(col = "none")


# for supplemental figure: plot het trends for western and eastern monarchs, separately. 

# eastern first 

a2 <- ggplot(het[het$population=="Eastern",], aes(x=year, y=het)) +
  geom_point() + 
  geom_point(aes(col=time_period)) + 
  geom_point(aes(fill=time_period), shape = 21, col = "black", size = 3) + 
  ylab(bquote(Heterozygosity~ind.^-1~bp^-1))+
  scale_fill_manual(values = c("1901-1929" = "black", "1931-1946" = "gray", "1953-1959" = "darkgoldenrod", 
                               "1969-1973" = "tan", "1982-1988" = "orange", "1996-2003" = "yellow", 
                               "2023-2024" = "white")) +
  xlab("Year") +
  ylim(0, 0.0080) +
  #geom_smooth(method='lm', se = T) +
  geom_smooth() +
  theme_cowplot(12) +
  theme(legend.position = "top") +
  labs(fill = "Time Period", col = "Time Period") + 
  labs(col = "Time Period") 
#guides(fill = "none") + 
#guides(col = "none")

# western
a3 <- ggplot(het[het$population=="Western",], aes(x=year, y=het)) +
  geom_point() + 
  geom_point(aes(col=time_period)) + 
  geom_point(aes(fill=time_period), shape = 21, col = "black", size = 3) + 
  ylab(bquote(Heterozygosity~ind.^-1~bp^-1))+
  scale_fill_manual(values = c("1901-1929" = "black", "1931-1946" = "gray", "1953-1959" = "darkgoldenrod", 
                               "1969-1973" = "tan", "1982-1988" = "orange", "1996-2003" = "yellow", 
                               "2023-2024" = "white")) +
  xlab("Year") +
  ylim(0, 0.0080) +
  #geom_smooth(method='lm', se = T) +
  geom_smooth() +
  theme_cowplot(12) +
  theme(legend.position = "top") +
  labs(fill = "Time Period", col = "Time Period") + 
  labs(col = "Time Period") 


pattern <- c("a2", "a3")

plot_grid(plotlist = mget(pattern[1:2]), ncol=2, labels=c('A','B'))


# calculate per-individual heterozygosity, using per-chromosome, 
# per-individual heterzygosity output.het.txt file 

# read in output.het.txt file 
het <- read.table("output.final.het.txt", sep = "\t", header = T)

# order of individuals, as they appear in VCF file, drop "_total_names" from column suffixes to get individual names 
individuals <- gsub("_total_sites", "", colnames(het)[2:56])

# read in file of locality and year
locality_year <- read.table(file = "locality_year.txt",  sep = "\t", header = T)

# year vector 
year <- locality_year$year

# time period vector 
time_period <- locality_year$time_period

# empty vectors for storage
sum_total_sites <- c()
sum_total_het_sites <- c()
total_heterozygosity <- c()

# for loop (looping over each individual)
for (i in 1:55) {
  # sum total sites 
  sum_total_sites[i] <- sum(het[,i+1])
  # sum het sites 
  sum_total_het_sites[i] <- sum(het[,i+55+1])
  # calculate heterozygosity 
  total_heterozygosity[i] <- (sum_total_het_sites[i]/sum_total_sites[i])
}

# cbind individual names, heterozygosity, year, population assignment, and time period
# to create heterozygosity dataframe 
het_dataframe <- as_tibble(cbind(individuals, total_heterozygosity, year, 
                                 locality_year$locality, time_period))

# change heterozygosity from character to numeric
het_dataframe$total_heterozygosity <- as.numeric(het_dataframe$total_heterozygosity)

# change year from character to numeric
het_dataframe$year<- as.numeric(het_dataframe$year)

# add colname to locality 
colnames(het_dataframe)[4] <- c("locality")

# export het dataframe 
#write.table(het_dataframe, file = "het_year_locality.txt", sep = "\t", quote = F)

library(tidyverse)

# assign population designation using a while loop

het_dataframe$population <- c()

for (a in 1:length(het_dataframe$locality)) {
  if (het_dataframe$locality[a]=="BCA" | het_dataframe$locality[a]=="CA" | het_dataframe$locality[a]=="ID" | het_dataframe$locality[a]=="OR") {
    het_dataframe$population[a] <- paste("Western")
  }
  else {
    het_dataframe$population[a] <- paste("Eastern")
  }
}

# correlation between het and year for het_dataframe
cor.test(het_dataframe$total_heterozygosity, het_dataframe$year)

# make labels for plotting
lb1 <- "italic(r) == -0.81"
lb2 <- "italic(p) < 0.01"

# plot showing heterozygosity x year relationship, colored by time period
b <- ggplot(het_dataframe, aes(x=as.numeric(year), y=total_heterozygosity)) +
  geom_point(aes(fill=time_period), shape = 21, col = "black", size = 3) + 
  scale_fill_manual(values = c("1901-1929" = "black", "1931-1946" = "gray", "1953-1959" = "darkgoldenrod", 
                               "1969-1973" = "tan", "1982-1988" = "orange", "1996-2003" = "yellow", 
                               "2023-2024" = "white")) +
  ylab(bquote(Heterozygosity~ind.^-1~bp^-1)) +
  xlab("Year") +
  ylim(0.002, 0.006) +
  geom_smooth(method='lm', se = T) +
  #geom_smooth() +
  annotate("text",
           x = 1970,
           y = 0.005, 
           label = lb1, parse = TRUE, size = 4) +
  annotate("text",
           x = 1990,
           y = 0.005, 
           label = lb2, parse = TRUE, size = 4) +
  labs(col = "Time Period") +
  labs(fill = "Time Period") + 
  theme_cowplot(12) +
  theme(legend.position = "none")

  

library(tidyverse)
library(cowplot)
# theta pi plotting across time periods

theta_pi_no_trans <- c(0.00798656,
                       0.00809815,
                       0.00805812,
                       0.00807235,
                       0.00802506,
                       0.00801232,
                       0.00730677)

time_periods <- c("1901-1929", 
                  "1931-1946",
                  "1953-1959",
                  "1969-1973",
                  "1982-1988",
                  "1996-2003",
                  "2023-2024")


dataset <- as.data.frame(cbind(time_periods,as.numeric(theta_pi_no_trans)))

dataset$V2 <- as.numeric(dataset$V2)

colnames(dataset) <- c("time_periods", "theta_pi_no_trans")

# without transitions
c <- ggplot(dataset, aes(x=time_periods, y=theta_pi_no_trans)) +
  geom_point(size = 5) +
  #geom_point(aes(col = locality)) +
  ylab(expression(Theta~Pi))+
  xlab("Time Period") +
  ylim(0.005, 0.010) +
  geom_smooth(aes(group = 1, colour = "orange"), se = T) + 
  theme_cowplot(12) +
  theme(legend.position = "none")


pattern <- c("a1", "b", "c")

bottom <- plot_grid(c, labels = c("C"))

top <- plot_grid(plotlist = mget(pattern[1:2]), ncol=2, labels=c('A','B'))

plot_grid(top, bottom, nrow = 2)

