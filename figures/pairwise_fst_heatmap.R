library(ggplot2)
library(reshape2)

# heatmap of pairwise fst comparisons

# without transitions

pairwise.fst.matrix <- read.csv("pairwise_fst_no_transitions.csv", header = T, row.names = 1)

colnames(pairwise.fst.matrix) <- rownames(pairwise.fst.matrix)

pairwise.fst.matrix <- as.matrix(pairwise.fst.matrix)


pairwise.fst.matrix <- melt(pairwise.fst.matrix, na.rm =TRUE)

# Plot
ggplot(data = pairwise.fst.matrix, aes(Var2, Var1, fill = value))+ geom_tile(color = "white") + 
  scale_fill_gradient(low = "white", high = "red", name="Fst") + 
  geom_text(aes(label = round(value,3)), size = 4) +
  # ggtitle("Pairwise Reich's FST") +
  labs( x = "Time Period", y = "Time Period") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 11, hjust = 1),axis.text.y = element_text(size = 12)) + 
  coord_fixed()