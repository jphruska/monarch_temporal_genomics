library(tidyverse)

# plotting code borrowed from: https://github.com/nt246/lcwgs-guide-tutorial/blob/main/tutorial3_ld_popstructure/markdowns/pca_admixture.md

# K of 2 plotting


#Load the covariance matrices
admix.2 = read_table("ngsAdmix_k2_rm_trans_flag_final_thinned.qopt", col_names = F)
admix.3 = read_table("ngsAdmix_k3_rm_trans_flag_final_thinned.qopt", col_names = F)
admix.4 = read_table("ngsAdmix_k4_rm_trans_flag_final_thinned.qopt", col_names = F)

# individual ids (based on order of bam files)
id <- c("BCA_1957_01",
"CA_1938_01",
"CA_1938_02",
"CA_1938_05",
"CA_1942_01",
"CA_1956_01",
"CA_1956_03",
"CA_1956_04",
"CA_1956_05",
"CA_1956_06",
"CA_1958_01",
"CA_1969_01",
"CA_1969_02",
"CA_1969_04",
"CA_1970_01",
"CA_1971_01",
"CA_1971_02",
"CA_1972_01",
"CA_1973_01",
"CA_1973_02",
"CA_1982_01",
"CA_2023_01",
"CA_2023_02",
"CA_2023_03",
"CA_2023_04",
"CA_2023_05",
"CA_2023_06",
"CA_2023_07",
"CA_2024_01",
"CA_2024_02",
"CA_2024_03",
"FL_1972_01",
"IA_1934_01",
"IA_1956_01",
"IA_1969_01",
"IA_1969_02",
"IA_1969_03",
"IA_1969_04",
"IA_1997_01",
"IA_1997_02",
"IA_1997_03",
"IA_1997_04",
"ID_1955_01",
"ID_1955_03",
"ID_1997_01",
"ID_1997_02",
"KS_1939_01",
"KS_1939_02",
"KS_1941_01",
"KS_1954_02",
"KS_1954_03",
"KS_1954_04",
"KS_1954_05",
"KS_1957_01",
"KS_1958_01",
"KS_1969_01",
"KS_1971_01",
"KS_1973_01",
"KS_2023_01",
"KS_2023_02",
"KS_2023_03",
"KS_2023_04",
"KS_2023_05",
"KS_2023_06",
"KS_2023_07",
"KS_2023_08",
"KS_2023_09",
"KS_2023_10",
"KS_2023_11",
"KS_2023_12",
"KS_2023_13",
"KS_2023_14",
"KS_2023_15",
"KS_2023_16",
"KS_2023_17",
"KS_2023_18",
"KS_2023_19",
"KS_2023_20",
"MI_1934_01",
"MI_1934_03",
"MI_1937_01",
"MI_1956_02",
"MI_1956_03",
"MI_1969_01",
"MI_1969_02",
"MI_1971_01",
"MI_1983_01",
"MI_1983_02",
"MI_1983_03",
"MI_1985_01",
"MI_1986_01",
"MI_1987_01",
"MI_1987_02",
"MI_1987_03",
"MI_1987_04",
"MI_1987_05",
"MI_1988_01",
"MI_1997_01",
"MI_1997_02",
"MI_1997_03",
"MI_1997_04",
"MI_1997_05",
"MI_1997_06",
"MI_1998_01",
"MI_2000_01",
"MI_2000_02",
"MI_2000_03",
"MI_2001_01",
"MI_2001_02",
"MI_2002_01",
"MI_2003_01",
"MN_1926_01",
"MN_1926_02",
"MN_1928_01",
"MN_1928_02",
"MN_1928_04",
"MN_1929_02",
"MN_1934_01",
"MN_1934_02",
"MN_1934_04",
"MN_1937_01",
"MN_1940_01",
"MN_1941_01",
"MN_1941_02",
"MN_1953_01",
"MN_1959_01",
"MN_1959_02",
"MN_1972_01",
"MN_1972_05",
"MN_1972_08",
"MN_1983_01",
"MN_1983_02",
"MN_1983_03",
"MN_1984_02",
"MN_1984_03",
"MN_1985_01",
"MN_1985_03",
"MN_1985_04",
"MN_1996_01",
"MN_1996_02",
"MN_1996_03",
"MN_1996_04",
"MN_2000_01",
"MO_1901_01",
"MO_1931_01",
"MO_1931_02",
"MO_1933_01",
"MO_1933_02",
"NE_1915_01",
"NE_1916_02",
"NE_1946_01",
"NE_1953_01",
"NE_1954_01",
"NE_2001_01",
"NE_2024_01",
"NE_2024_02",
"NE_2024_03",
"NE_2024_04",
"NE_2024_05",
"NE_2024_06",
"NE_2024_07",
"NE_2024_08",
"NE_2024_10",
"NE_2024_11",
"NE_2024_12",
"NE_2024_13",
"NE_2024_14",
"NE_2024_15",
"NE_2024_16",
"NE_2024_17",
"OR_1955_01")

# K = 2 
admix.id.2 = as.data.frame(cbind(id, admix.2))
names(admix.id.2) = c("id","q1","q2")

# extract year and locality from ID vector
year <- c()
locality <- c()

for (a in 1:length(admix.id.2$id)) {
  # extract year
  year[a] <- as.numeric(strsplit(admix.id.2$id, split = "_")[[a]][4])
  # extract locality 
  locality[a] <- strsplit(admix.id.2$id, split = "_")[[a]][3]
}


admix.id.locality.year.2 = as.data.frame(cbind(admix.id.2, year,locality))

# sort dataframe by year

admix.id.locality.year.sorted.2 <- as.data.frame(admix.id.locality.year.2[order(admix.id.locality.year.2$year),])


# plot with base plot
#pdf()

# set names arg to delineate start and stop of each time period (inclusive)
plot = barplot(t(as.matrix(subset(admix.id.locality.year.sorted.2, select=q1:q2))), col=c("firebrick","royalblue"), 
               border="black", names.arg = row.names(admix.id.locality.year.sorted.2), axisnames = TRUE)
#dev.off() 

admix.id.locality.year.2

# K = 3 

admix.id.3 = as.data.frame(cbind(id, admix.3))
names(admix.id.3) = c("id","q1","q2","q3")

# extract year and locality from ID vector
year <- c()
locality <- c()

for (a in 1:length(admix.id.3$id)) {
  # extract year
  year[a] <- as.numeric(strsplit(admix.id.3$id, split = "_")[[a]][4])
  # extract locality 
  locality[a] <- strsplit(admix.id.3$id, split = "_")[[a]][3]
}


admix.id.locality.year.3 = as.data.frame(cbind(admix.id.3, year,locality))

# sort dataframe by year

admix.id.locality.year.sorted.3 <- admix.id.locality.year.3[order(admix.id.locality.year.3$year),]


#pdf()
plot = barplot(t(as.matrix(subset(admix.id.locality.year.sorted.3, select=q1:q3))), col=c("firebrick","royalblue", "purple"), border=NA)
#dev.off() 


# K = 4

admix.id.4 = as.data.frame(cbind(id, admix.4))
names(admix.id.4) = c("id","q1","q2","q3", "q4")

# extract year and locality from ID vector
year <- c()
locality <- c()

for (a in 1:length(admix.id.4$id)) {
  # extract year
  year[a] <- as.numeric(strsplit(admix.id.4$id, split = "_")[[a]][4])
  # extract locality 
  locality[a] <- strsplit(admix.id.4$id, split = "_")[[a]][3]
}


admix.id.locality.year.4 = as.data.frame(cbind(admix.id.4, year,locality))

# sort dataframe by year

admix.id.locality.year.sorted.4 <- admix.id.locality.year.4[order(admix.id.locality.year.4$year),]


#pdf()
plot = barplot(t(as.matrix(subset(admix.id.locality.year.sorted.4, select=q1:q4))), col=c("firebrick","royalblue", "purple", "orange"), border=NA)
#dev.off() 