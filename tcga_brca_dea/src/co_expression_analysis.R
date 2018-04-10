# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### GENE CO-EXPRESSION NETWORK ANALYSIS #### 
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
setwd(getwd())

# only keep candidate genes that found in the voom transformed data
excl_candidates <- get_candidates_excl(voom_data,candidate_genes)
candidates <- candidate_genes[!candidate_genes %in% excl_candidates]

# create matrix of expression counts
expression_matrix <- t(voom_data$E[match(candidates, rownames(voom_data$E)), ])


# calculate spearmans correlation and p-values adjusted for multiple testing.
my_cor_test <- corr.test(expression_matrix, method = 'spearman', adjust = 'fdr')

# create adjacency data frame from matrix
my_adj_df <- flatten_corr_matrix(my_cor_test$r, my_cor_test$p)

# add attributes
names(my_adj_df) <- c('from', 'to', 'weight', 'p')
# tranform weight to absolute weight to escape negative values
my_adj_df$abs.weight <- abs(my_adj_df$weight)
# exponential tranformation with base 2 to escape negative values when assigning directions to the correlations
my_adj_df$corr_dir <- 2^my_adj_df$weight
#my_adj_list$logFC <- tt[match(my_adj_list$to, rownames(tt)), 'logFC']
summary(my_adj_df$weight)

# filter out correlations > 0.60 and only significant correlation (p=0.05)
my_adj_filtered <- my_adj_df %>% filter(p < 0.05 & abs.weight > 0.60)
#write.table(my_adj_filtered, file = 'output/test_adj.txt', row.names = FALSE, sep = '\t')

# remove col 3 and 4
my_adj_filtered <- my_adj_filtered[c(-3, -4)]

# create igraph graph from edge/vertex attributes in my_adj_filtered
net <- graph.data.frame(my_adj_filtered, directed = FALSE)

# colour negative correlation edges as blue
E(net)[which(E(net)$corr_dir<1)]$color <- 'darkblue'

# colour positive correlation edges as red
E(net)[which(E(net)$corr_dir>1)]$color <- 'darkred'

# assign names to the graph vertices (optional)
V(net)$name <- V(net)$name

# change shape of graph vertices
V(net)$shape <- 'sphere'

# uncomment to change shape of pro and anti apoptotic members
# anti_apop_BCL2 <- c('BCL2', 'BCL2A1', 'BCL2L1', 'BCL2L2', 'BCL2L10', 'MCL1')
# for (i in anti_apop_BCL2) {
#   V(net)[which(V(net)$name==i)]$shape <- 'circle'
# }
# pro_apop_BCL2 <- c('BOK', 'BAX', 'BAK1', 'BCL2L12', 'BCL2L13', 'BCL2L14', 'BCL2L15')
# for (i in pro_apop_BCL2) {
#   V(net)[which(V(net)$name==i)]$shape <- 'square'
# }

# change colour of graph vertices
V(net)$color <- 'skyblue'

# change colour of vertex frames
# V(net)$vertex.frame.color <- 'white'

# mcale the size of the vertices to be proportional to the level of expression of each gene represented by each vertex
# multiple scaled vales by a factor of 10
scale01 <- function(x){(x-min(x))/(max(x)-min(x))}
v_sizes <- (scale01(apply(expression_matrix, 1, mean)) + 1.0) * 4

# amplify or decrease the width of the edges but not much difference in the edge width given the values
edgeweights <- E(net)$abs.weight * 2.0

#plot(net, edge.color = E(net)$color, edge.width = edgeweights, layout = layout_components(net))

# community detection based on weighted edge betweenness (Newman-Girvan)
ceb <- cluster_edge_betweenness(net, weights = E(net)$abs.weight)
class(ceb)


# set new margins to limit whitespace in plot
par(mar=rep(.1, 4))
l <- layout_with_fr(net)
pdf(file = 'figs/co.expr.net.pdf')
plot(ceb,
     net,
     layout = l,
     vertex.label.color='black',
     edge.curved = F,
     edge.color = E(net)$color,
     vertex.color = V(net)$color,
     vertex.size = v_sizes,
     vertex.label.dist=0,
     vertex.label.cex=0.5,
     asp = 1,
     edge.width = edgeweights,
     mark.border='black'
    # margin = -0.2
)
dev.off()
# calculate the subgraph containing most the BCL2-family including the significantly de BCL2A1
sub_net <- induced_subgraph(net, which(ceb$membership==4))
V(sub_net)$color <- 'orange'
V(sub_net)[which(V(sub_net)$name=='BCL2A1')]$color <- 'pink'
V(sub_net)[which(V(sub_net)$name=='TOMM40')]$color <- 'pink'
l_sub_net <- layout_with_fr(sub_net)
pdf(file = 'figs/co.expr.subnet.pdf')
plot(sub_net,
     layout = l_sub_net,
     vertex.size = v_sizes*2,
     edge.width = edgeweights*2,
     vertex.label.color='black',
     vertex.label.cex=0.7
     )
dev.off()
# a simple dendrogram created using hierarchical clustering.
pdf(file = 'figs/co.expr.dendro.pdf')
dendPlot(ceb, mode='hclust')
dev.off()

# community membership for each node
membership(ceb)
# degree distribution of the vertices
degree(net, mode='all')

# output information for each community, including vertex-to-community assignments
comm_summary <- data.frame(
  ceb$names,
  ceb$membership
)
colnames(comm_summary) <- c('Gene', 'Community')
comm_summary

detach('package:igraph')


