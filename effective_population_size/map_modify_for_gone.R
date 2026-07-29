# read in .map file
map <- read.table("combined_currentne_gone_final.map")

# read in chromosome file 
chromosome <- read.table("chrom.txt", header = F)

# give chromosome file column names
colnames(chromosome) <- c("chromosome", "number")

# count number of lines that match chromosome id, to generate values for column 1 
# set empty vector
number_of_lines <- c()
for (i in 1:length(chromosome$chromosome)) {
  # count number of lines that match chromosome id 
  number_of_lines[i] <- length(grep(chromosome$chromosome[i], map$V2))
}

# generate column 1 
column1 <-as.numeric(c(paste(rep("1", number_of_lines[1])), paste(rep("2", number_of_lines[2])), 
             paste(rep("3", number_of_lines[3])), paste(rep("4", number_of_lines[4])), 
             paste(rep("5", number_of_lines[5])), paste(rep("6", number_of_lines[6])),
             paste(rep("7", number_of_lines[7])), paste(rep("8", number_of_lines[8])),
             paste(rep("9", number_of_lines[9])), paste(rep("10", number_of_lines[10])),
             paste(rep("11", number_of_lines[11])), paste(rep("12", number_of_lines[12])),
             paste(rep("13", number_of_lines[13])), paste(rep("14", number_of_lines[14])),
             paste(rep("15", number_of_lines[15])), paste(rep("16", number_of_lines[16])),
             paste(rep("17", number_of_lines[17])), paste(rep("18", number_of_lines[18])),
             paste(rep("19", number_of_lines[19])), paste(rep("20", number_of_lines[20])),
             paste(rep("21", number_of_lines[21])), paste(rep("22", number_of_lines[22]))
             ))

# generate column 2 by removing the CHROM: of CHROM:POS identifier 

# empty vector for column 2 values 
column2 <- list()
for (i in 1:length(chromosome$chromosome)) {
column2[[i]] <- as.numeric(gsub(paste(chromosome$chromosome[i], ":", sep = ""), "", 
                map$V2[grep(chromosome$chromosome[i], map$V2)]))
}

# unlist list to generate vector of positions
column2 <- unlist(column2)

# cbind column 1, 2 and columns 3 and 4 from map dataframe 
map2 <- cbind(column1, column2, map$V3, map$V4)

# export map2 
write.table(map2, file = "combined_currentne_gone_final_2.map", sep = "\t", quote = F, row.names = F, 
            col.names = F)







