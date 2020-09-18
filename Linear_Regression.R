library(MASS)
library(ISLR)

a<-read.csv('assignment3.csv')

#Question 1(a)
#Split the data into training & testing datasets
set.seed(12345)
row.number <- sample(nrow(a),size=0.75*nrow(a))
train = a[row.number,]
test = a[-row.number,]
dim(train)
dim(test)
head(train)
head(test)

#Question 1(b)
#predict EP based on the variables wind, pressure, humidity, visabilit,y FFMC, DMC, DC and ISI. 
predictionmodel<-lm(EP~.,data=train)
#Variables with three stars are most significant, followed by two stars, and finally one
#Apparently, only the intercept and P value of pressure is less than 0.05, thus, pressure is weakly correlated with EP.
summary(predictionmodel)
#output:Adjusted R-squared:0.2366; F-statistic: 8.167 on 8 and 177 DF,  p-value: 2.231e-09

#remove the predictors that are weakly correlated with the outcome variable (Y) based on significance level (p-values) and re-fit the model including only significant variables.
predictionmodel1<-lm(EP~pressure,data = train)
summary(predictionmodel1)     
#output:Adjusted R-squared:0.2199; F-statistic: 53.16 on 1 and 184 DF,  p-value: 8.827e-12

#see if the saturated and reduced models are significantly different from one another
anova(predictionmodel1,predictionmodel)
#Interpretation: P value is 0.1458 ,which is more than 0.05, so, there is no significant between two models, reduced model is better.

#Using saturated model and reduced model (separately) predict values of Y using test data.
predict(predictionmodel,test)
predict(predictionmodel1,test)

#Calculate R2 for predictiionmodel to assess prediction error.
predicted_ys <- predict(predictionmodel, test)
observed_ys <- test$EP
SSE <- sum((observed_ys - predicted_ys)^2)
SST <- sum((observed_ys - mean(observed_ys))^2)
r2 <- 1 - SSE/SST
r2 # 0.1712093
rmse <- sqrt(mean((predicted_ys - observed_ys)^2))
rmse #16.49502

#Calculate R2 for predictiionmodel1 to assess prediction error.
predicted_ys1<-predict(predictionmodel1,test)
observed_ys <- test$EP
SSE1 <- sum((observed_ys - predicted_ys1) ^ 2)
SST1 <- sum((observed_ys - mean(observed_ys)) ^ 2)

r21 <- 1 - SSE1/SST1
r21 #0.3127864
rmse1 <- sqrt(mean((predicted_ys1 - observed_ys)^2))
rmse1 #15.02022
#Conclusion: the predictionmodel1 model had the lowest prediction error compared to predictionmodel model.

#Question 1 (c)
#Use the stepAIC() function to implement backward selection (starting with the full model). 
library(MASS)
stepAIC(predictionmodel)
#Conclusion: The optimised model is lm(formula = EP ~ wind + pressure + DMC, data = train_set)

#Question 2 (a)
#Transform training and testing datasets into a matrix of Xs and vector for Y 
trainingXs<-as.matrix(train)
traingY<-as.vector(trainingXs)

testingXs<-as.matrix(test)
testingY<-as.vector(testingXs)

#Question 2 (b)

library(glmnet)

#Using the training matrix, training vector, and the cv.glmnet () function, fit a Lasso model in order to find the best (minimum) Lambda.
x<-trainingXs
y<-train$EP

#Using the training objects from above, also fit a Lasso model using glmnet() function and name it
lasso.mod <- glmnet(x, y, alpha=1, nlambda=100, lambda.min.ratio=0.0001)
head(lasso.mod)
set.seed(1) 
cv.out <- cv.glmnet(x, y, alpha=1, nlambda=100, lambda.min.ratio=0.0001)
head(cv.out)
plot(cv.out)
best.lambda <- cv.out$lambda.min
best.lambda# 0.5505505

#use the predict function to assign this model and the minimum lambda to the test data
x_test <-x #this transforms x from a variable within a dataframe into a matrix
y_test <- y #this transforms y from a variable within a dataframe into a vector

y_predicted <- predict(lasso.mod, s = best.lambda, newx = x_test)
head(y_predicted)
#y_test

# Assess our predictin accuracy/error via:
# Sum of Squares Total and Error
sst <- sum(y_test^2)
sse <- sum((y_predicted - y_test)^2)


# R squared
rsq <- 1 - sse / sst
rsq 
#> [1]  0.9999985 (pretty good!)
#Interpretation: Lasso approach perform very well due to R squared is 0.9999985
#Compared to the approach above, Lasso is a little complex but convenient to get necessary result.

#Question 3 (a)

#Fit the PCR model:train
#install.packages("pls")
library(pls)
pcr_model <- pcr(EP~., data = train, scale = TRUE, validation = "CV")

#get results of the PCR model:
summary(pcr_model)

#View results of the PCR model visually:
# Plot the root mean squared error
validationplot(pcr_model, val.type = c("RMSEP"))

# Plot the mean squared error:
validationplot(pcr_model, val.type = c("MSEP"))

# Plot the R-squared:
validationplot(pcr_model, val.type = c("R2"))
#Conclusion: We need to decide if the PCR model is better than regular linear regression
#To do this, we see if our model error with fewer principal components is near what we would have achieved from lienar regression using all available variables
#In this case, it looks like 4 principal components yield an error close to what we would have obtained from using all 5 variables
#That is, 4 componenets explains 22% of the variance while 6 and 8 explain 21% and 20%, respectively

#Question 3(b)
#Use the predict() function on  test_set to apply fitted pcr model with 4 principle components : predict(your_pcr_model, test, ncomp=number of principle components you chose).
head(predict(pcr_model, test, ncomp=4))
predictpcr<-predict(pcr_model, test, ncomp=4)

SSEpcr <- sum((observed_ys - predictpcr) ^ 2)
SSTpcr <- sum((observed_ys - mean(observed_ys)) ^ 2)

r2pcr <- 1 - SSEpcr/SSTpcr
r2pcr#0.2003002

#Compared to model above, pcr model is easier to use and more direct to show results.










