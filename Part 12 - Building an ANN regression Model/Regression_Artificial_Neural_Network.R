# Artificial Neural Network

# Importing the dataset
dataset = read.csv("Folds5x2_pp.csv")

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$PE, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)


# Fitting ANN to the Training set
# install.packages("h2o")
# install.packages("data.table")
library(h2o)
h2o.init(nthreads = -1)
classifier = h2o.deeplearning(y = "PE", 
                              training_frame = as.h2o(training_set),
                              activation = "Rectifier",
                              hidden = c(6,6),
                              epochs = 100,
                              train_samples_per_iteration = -2)

summary(classifier)

# Predicting the Test set results
y_pred = h2o.predict(classifier, newdata = as.h2o(test_set[-5]))
head(y_pred)
head(test_set[5])
y_pred = as.vector(y_pred)
test_set = as.vector(test_set)

# Performance Metrics
# install.packages("Metrics")
library(Metrics)
MSE = mse(test_set$PE, y_pred)
RMSE = rmse(test_set$PE, y_pred)
rss <- sum((y_pred - test_set$PE) ^ 2)
tss <- sum((test_set$PE - mean(test_set$PE)) ^ 2)
rsq <- 1 - (rss/tss)
print(paste("Mean Squared Error", MSE))
print(paste("Root Mean Squared Error", RMSE))
print(paste("R Squared", rsq))

# Shutdown H2O
h2o.shutdown()


