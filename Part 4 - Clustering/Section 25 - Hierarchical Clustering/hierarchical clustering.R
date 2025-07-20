# Hierarchical Clustering (HC)

# Importing the dataset
dataset = read.csv('mall.csv')

# Creating Matrix of features X
X = dataset[4:5]

# Using the dendrogram to find the optimal number of clusters
dendrogram = hclust(dist(X, method ="euclidean"), method = "ward.D")
plot(dendrogram,
     main = paste("Dendrogram"),
     xlab = "Customers",
     ylab = "Euclidean distances")

# Fitting hierarchical clustering to the mall dataset
hc = hclust(dist(X, method ="euclidean"), method = "ward.D")
y_hc = cutree(hc, k = 5)
y_hc

# Visualising the clusters
library(cluster)
clusplot(X,
         y_hc,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste("Clusters of clients"),
         xlab = "Annual Income",
         ylab = "Spending Score")

