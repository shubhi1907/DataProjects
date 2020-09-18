
#ALY 6015 Assginment 4 - Classification & Clustering 

   #Question 1 

#Import the “banking_data.csv” dataset into your R Studio. 
#setwd("Users/Lookylu/Desktop/ALY6015 Assignment/W4/")
banking <- read.csv(file.choose(), header=T,sep = ",")


  #Question 2

#Calcualte the probability
levels(banking$y) <- c(0,1)
pccsuy <- round(sum(banking$y==1)/nrow(banking),3)

#Fit an intercepts-only logistic regression model
logistic_model <- glm(y~1,family = binomial(link = 'logit'),data = banking)
summary(logistic_model)
#β0=-2.06391 

#Using your estimate for the intercept calculate the probability that y=1 using the formula e^(β_0 )/(1+e^(β_0 ) ).
Probability1 <- round(exp(1)^(logistic_model$coefficients[1])/(1+exp(1)^(logistic_model$coefficients[1])),3)
#intepretation: Probability1 is the probability y=1
Probability1

#install.packages("gmodels")
library(gmodels)
CrossTable(banking$y)

 
#   #Question 3
#Logistic Regression Model for Highest education level

model_education2 <- glm(formula = y~factor(education==2),data = banking,family = binomial(link = 'logit'))
summary(model_education2)
#Logistic Regression Model for lowest education level
model_education0 <- glm(formula = y~factor(education==0),data = banking,family = binomial(link = 'logit'))
summary(model_education0)
#Odds Ratio
oddsratio2 <-exp(model_education2$coefficients[2])
oddsratio2
oddsratio0 <-exp(model_education0$coefficients[2])
oddsratio0
#Probability
prob2 <-oddsratio2/(1+oddsratio2)
prob0 <-oddsratio0/(1+oddsratio0)
prob2
prob0



  # Question 4

#The day of the highest probability of clients to sign up
logistic_modelday <- glm(formula = y~factor(day),family = binomial,data = banking)
summary(logistic_modelday)

Probd1y1<-exp(logistic_modelday$coefficients[1])/(1+exp(logistic_modelday$coefficients[1]))
Probd2y1<-exp(logistic_modelday$coefficients[1]+logistic_modelday$coefficients[2])/(1+exp(logistic_modelday$coefficients[1]+logistic_modelday$coefficients[2]))
Probd3y1<-exp(logistic_modelday$coefficients[1]+logistic_modelday$coefficients[3])/(1+exp(logistic_modelday$coefficients[1]+logistic_modelday$coefficients[3]))
Probd4y1<-exp(logistic_modelday$coefficients[1]+logistic_modelday$coefficients[4])/(1+exp(logistic_modelday$coefficients[1]+logistic_modelday$coefficients[4]))
Probd5y1<-exp(logistic_modelday$coefficients[1]+logistic_modelday$coefficients[5])/(1+exp(logistic_modelday$coefficients[1]+logistic_modelday$coefficients[5]))
Probd1y1
Probd2y1
Probd3y1
Probd4y1
Probd5y1
#According to the result, 4th day has the highest probabilty of clients to sign up, which is 0.121


   # Question 5
#Split the data into a training dataset and a test dataset, with 80% of observations randomly going to the training data and 20% randomly going to the test data. 
set.seed(1)
row.number <- sample(x=1:nrow(banking),size = 0.8*nrow(banking))
train= banking[row.number,]
test = banking[-row.number,]

#Using data to fit a logistic regression model
logistic_modelpredict <- glm(y ~ ., family=binomial(link="logit"), data=train)
summary(logistic_modelpredict)
#It is clearly shows, thatsignificant variables are age,occupation,default,contact,duration,campaign,pdays,poutcome

#Select proper variables to construct more accurate model
logistic_modelpredict1<-glm(y ~ age+occupation+default+contact+duration+campaign+pdays+poutcome, family=binomial(link="logit"), data=train)
summary(logistic_modelpredict1)

Predicted_value <- predict(logistic_modelpredict1, newdata = test,type = "response")
#Predicted_value

#Categorize predicted probabilities as either Y=1 or Y=0 based on some cutoff value (usually 0.05 is chosen)
y_pred_num <- ifelse(Predicted_value> 0.5,1,0)
#y_pred_num

y_predicted <- factor(y_pred_num, levels=c(0, 1))
y_observed <- test$y
mean(y_predicted == y_observed, na.rm=TRUE)

#accurancy of the prediction is 0.9021912


  # Question 6
#6.1 Can we?
#install.packages("InformationValue")
library(InformationValue)
sum(is.na(Predicted_value))

# There are 69 NA values, therefore, i need to use mean(Predicted_value) to replace NA
mean(Predicted_value)

Predicted_value1<-na.omit(Predicted_value)
Predicted_value[is.na(Predicted_value)]=mean(Predicted_value1)
optCutOff <- optimalCutoff(test$y,Predicted_value)
optCutOff 

#6.2 How about?
#install.packages("rpart")
library(rpart)

fit <- rpart(y~.,method="class", data=banking)
printcp(fit) # display the results 
plotcp(fit) # visualize cross-validation results
#summary(fit) 3detailed summary of splits

#Plot tree
plot(fit,uniform = TRUE,
     main='Classification Tree for Bank')
text(fit,use.n = TRUE,all = TRUE,cex=0.5)

#Use the tree package to construct model and predict
#install.packages("tree")
library(tree)

tree.model <- tree(y ~ ., data=train)
tree.model
summary(tree.model)
plot(tree.model)
text(tree.model,cex=0.5)

#Get predicted values of y
#Probability prediction
preds <- predict(tree.model, test) # gives the probability for each class
head(preds)

# Point prediction
# Let's translate the probability output to categorical output
maxidx <- function(arr) {
  return(which(arr == max(arr)))
}
idx <- apply(preds, c(1), maxidx)

y_predictedtree <- c(0, 1)[idx]
y_observedtree <- test$y
mean(y_predictedtree == y_observedtree, na.rm=TRUE)
## [1] 0.8970624
# translating predicted probabilities: accurancy of the prediction
#is 0.8970624
