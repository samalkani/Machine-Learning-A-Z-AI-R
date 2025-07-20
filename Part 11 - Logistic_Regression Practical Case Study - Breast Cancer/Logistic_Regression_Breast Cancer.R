# Logistic Regression a Practical case study - Breast cancer

# Importing the dataset
dataset = read.csv('breast_cancer.csv')
dataset = dataset[, 2:11]

# Encoding the target feature as factor
dataset$Class = factor(dataset$Class, levels = c(2, 4))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Class, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set[, 1:2] = scale(training_set[, 1:2])
# test_set[, 1:2] = scale(test_set[, 1:2])

# Fitting Logistic Regression to the Training set
classifier = glm(formula = Class ~ .,
                 family = binomial,
                 data = training_set)

summary(classifier)

# Predicting the Test set results
prob_pred = predict(classifier, type = 'response', newdata = test_set)
print(prob_pred)
y_pred = ifelse(prob_pred > 0.5, 1, 0)
print(y_pred)

# Confusion Matrix
cm = table(test_set[, 10], y_pred)
print(cm)
