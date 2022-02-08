#K2 Group 6
#Predicting crab age

#read data into a dataframe Crab
heartfailure <- read.csv("heartfailure.csv",stringsAsFactors = TRUE)
names(heartfailure)

#check pairwise correlations among predictors in the data and visualize except DEATH_EVENT
cor_heart <- cor(heartfailure)
install.packages("corrplot")
library(corrplot)
#Positive correlations are displayed in blue and negative correlations in red color. 
#Color intensity and the size of the circle are proportional to the correlation coefficients. 
corrplot(cor_heart, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)

# produce a scatter plot with all variables
plot(heartfailure)

#demographic and histology distribution of data
par(mfrow=c(2,2))
hist(heartfailure$age, main="Age")

sex = ifelse(heartfailure$sex ==1, "Male", "Female")
barplot(table(sex), main="Sex")

smoking = ifelse(heartfailure$smoking ==1, "Yes", "No")
barplot(table(smoking), main="Smoking")

diabetes = ifelse(heartfailure$diabetes ==1, "Yes", "No")
barplot(table(diabetes), main="Diabetes Status")
##barchart, 1. convert using ifelse (without affecting csv); or create new dataset 

#lab test result distribution
par(mfrow=c(2,2))
hist(heartfailure$creatinine_phosphokinase, main="Creatinine Phosphokinase")
hist(heartfailure$platelets, main="Platelets")
hist(heartfailure$serum_creatinine, main="Serum Creatinine")
hist(heartfailure$serum_sodium, main="Serum Sodium")

#disease history distribution
par(mfrow=c(2,2))
event = ifelse(heartfailure$DEATH_EVENT ==1, "Yes", "No")
barplot(table(event), main="Event Status")

anaemia = ifelse(heartfailure$anaemia ==1, "Yes", "No")
barplot(table(anaemia), main="Anaemia")


hist(heartfailure$ejection_fraction, main="Ejection Fraction")

high_blood_pressure = ifelse(heartfailure$high_blood_pressure ==1, "Yes", "No")
barplot(table(high_blood_pressure), main="High Blood Pressure")

#use train and test, one for tain and one for test (with glm.prob)
#Losgistic regression of death event vs all predictors using train
set.seed(2)
train = sample(1:nrow(heartfailure), nrow(heartfailure)/2)
test = heartfailure[-train,]

glm.fit = glm(DEATH_EVENT~age + anaemia + creatinine_phosphokinase + diabetes + ejection_fraction + 
                high_blood_pressure + platelets+ serum_creatinine + serum_sodium + sex + smoking +
                time, family=binomial, data=heartfailure, subset = train)
summary(glm.fit)

#Predict the probability that the one will die, for each person in the testing data.
glm.probs=predict(glm.fit,test,type="response")

#Look for the best threshold to classify prediction as "risk" or "mild risk"
#create a vector glm.pred, which initially consists of mild risk for all 299 patients
glm.pred1 = rep(0,299)

#classify prediction as "risky" if if probability is > 30%,"mild risk" otherwise
#update the vector to "risky, for any day in which the probability of Up is > 30%
glm.pred1[glm.probs>.3] = 1

# create a table, which cross-tabulates our predictions (in glm.pred vector)
# with respect to actual DEATH_EVENT
table(glm.pred1,heartfailure$DEATH_EVENT)
# compute the percentage of time we were correct
mean(glm.pred1 == heartfailure$DEATH_EVENT)

#repeat the same process to .5
glm.pred2 = rep(0,299)
glm.pred2[glm.probs>.5]=1
table(glm.pred2,heartfailure$DEATH_EVENT)
mean(glm.pred2 == heartfailure$DEATH_EVENT)

#repeat the same process to .7
glm.pred3 = rep(0,299)
glm.pred3[glm.probs>.7] = 1
table(glm.pred3,heartfailure$DEATH_EVENT)
mean(glm.pred3 == heartfailure$DEATH_EVENT)

#KNN
library(ISLR)

#Select training and testing data set
set.seed(2)
train = sample(1:nrow(heartfailure), nrow(heartfailure)/2)

heartfailure.train = heartfailure[train,1:12]
heartfailure.test=heartfailure[-train,1:12]
DEATH_EVENT.train=heartfailure$DEATH_EVENT[train]
DEATH_EVENT.test=heartfailure$DEATH_EVENT[-train]

#Find the best KNN model
library(class)
for (i in 1:12){
  knn.pred= knn(heartfailure.train,heartfailure.test,DEATH_EVENT.train,k=i)
  table(knn.pred,DEATH_EVENT.test)
  print(round(mean(knn.pred==DEATH_EVENT.test),3))
}

#Decision Tree
library(tree)

# add new column DEATH to heartfailure, which will indicate yes if DEATH_EVENT=1 and no otherwise
DEATH = ifelse(heartfailure$DEATH_EVENT ==1, "Yes", "No")
heartfailure1 = data.frame(heartfailure,DEATH,stringsAsFactors = TRUE)
heartfailure1 = heartfailure1[,-13]

heartfailure1$DEATH = as.factor(heartfailure1$DEATH)

# set random seed
set.seed(2)

#we are randomly picking 
#half of those rows to be our training data. We are storing the row numbers in our training data 
#in a variable called train. 
train = sample(1:nrow(heartfailure1), nrow(heartfailure1)/2)

#the remaining rows are set aside as test data
heartfailure.test = heartfailure1[-train,]

#we store the actual observations for test data in a vector called DEATH.test 
DEATH.test = DEATH[-train]


# create a decision tree to predict DEATH ==1 or not, using only training data. 
# The response is DEATH, the predictors are everything except DEATH
tree.heartfailure = tree(DEATH ~ . , heartfailure1[train,])
summary(tree.heartfailure)

#plot the tree
plot(tree.heartfailure)

#to see what the branches are 
text(tree.heartfailure,pretty=1)

#using the tree created, make dead vs. not dead predictions for the test data
#the predictions are stored in a vector called tree.pred
tree.pred = predict(tree.heartfailure,heartfailure.test,type="class")

#display a table that shows predictions for test data versus actuals for test data
table(tree.pred, DEATH.test)

#calculate prediction accuracy
mean(tree.pred==DEATH.test)

# set random seed
set.seed(25)

# use cross-validation and pruning to obtain smaller trees and their prediction accuracy 
# store the results in a variable called cv.heartfailure
cv.heartfailure = cv.tree(tree.heartfailure,FUN=prune.misclass)

# check the names of columns in cv.heartfailure -- two of them are the important ones for us:
# size is the size of a tree, specifically, the number of nodes in the tree
# dev, in this case, is the fraction of DEATH that were misclassified
names(cv.heartfailure)

# display the information in cv.heartfailure
# osberve that dev is minimum when size is 5, so the best tree has a size of 6
cv.heartfailure

#use a function called prune.misclass() to obtain the best tree, which we know has a size of 6
#store the resulting tree in a variable called prune.heartfailure
prune.heartfailure = prune.misclass(tree.heartfailure,best=6)

# plot the best tree
plot(prune.heartfailure)

# display branch names on the tree
text(prune.heartfailure, pretty = 0)


# using the best tree obtained in previous secion, we make dead vs. not dead predictions for the test data
# the predictions are stored in a vector called tree.pred
tree.pred = predict(prune.heartfailure,heartfailure.test,type="class")

# display a table that shows predictions for test data versus actuals for test data
table(tree.pred, DEATH.test)

# calculate prediction accuracy
mean(tree.pred==DEATH.test)




