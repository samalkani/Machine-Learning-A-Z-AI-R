# Multiple linear regression

# Importing the dataset
dataset = read.csv('50_Startups.csv')
# dataset = dataset[, 2:3]

# Encoding categorical data
dataset$State = factor(dataset$State, 
                       levels = c('New York', 'California', 'Florida'), 
                       labels = c(1, 2, 3))


# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

# Fitting Multiple Linear Regression to the Training set
regressor = lm(formula = Profit ~ ., 
               data = training_set)

summary(regressor)

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)

y_pred

# Real profits from test set to compare against predicted profits above
print(test_set[, 5])

# Building the optimal model using Backward Elimination (manual)

# 4 variable model
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State, 
               data = dataset)

summary(regressor)

# 3 variable model
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend, 
               data = dataset)

summary(regressor)

# 2 variable model - possibly the final model with marketing spend being marginally significant
regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend, 
               data = dataset)

summary(regressor)

# 1 variable model - simple linear regression with R & D spend being the single independent variable
regressor = lm(formula = Profit ~ R.D.Spend, 
               data = dataset)

summary(regressor)





