
# A. One-sample t-tests
# Ex. An outbreak of Salmonella-related illness was attributed to ice cream produced at a certain factory. 
# Scientists measured the level of Salmonella in 9 randomly sampled batches of ice cream. 
# The levels (in MPN/g) were:
x = c(0.593, 0.142, 0.329, 0.691, 0.231, 0.793, 0.519, 0.392, 0.418)

# Is there evidence that the mean level of Salmonella in the ice cream is greater than the cut-off of 0.3 MPN/g?

summary(x)

# Ho: mu=0.3
# Ha: mu>0.3
# alpha: 0.05
t.test(x, alternative="greater", mu=0.3)
#Results:
# t=2.2
# p=0.0297
# Conclusion: 
# There is sufficient evidence to reject the null hypothesis that the sample of ice cream has greater than 0.3 MPN/g.


# B. Two-sample t-tests

# Ex. 6 subjects were given a drug (treatment group) and an additional 6 subjects a placebo (control group). 
#Their reaction time to a stimulus was measured (in ms). 
#We want to perform a two-sample t-test for comparing the means of the treatment and control groups.

#Here the hypothesis of interest can be expressed as: Ho: Control=Treatment
#Let's say we are uncertain about whether the treatment will increase or decrease reaction time; 
#the alternative hypothesis can be stated as a two-tailed test Ha: Treatment != (does not equal) Control
#We again set alpha to 0.05

Control = c(91, 87, 99, 77, 88, 91)
Treat = c(101, 110, 103, 93, 99, 104)

#We can calculate an equal variance t-test for the hypotheses stated above using the following function:
t.test(Control,Treat, var.equal=TRUE)
#p=0.006

#Let's say we hypothesize that treatment group will have a lower average reaction time
#We can instead test a single-tail hypothesis test Ha: Treatment < Control, and implement this via:
t.test(Control,Treat,alternative="less", var.equal=TRUE)
#p=0.003


# C. Paired t-tests

# There are many experimental settings where each subject in the study is in both the treatment and control group. 
#For example, in a matched pairs design, subjects are matched in pairs and different treatments are given to each subject in the pair. 
#The outcomes are thereafter compared pair-wise. Alternatively, one can measure each subject twice, before and after a treatment. 
#In either of these situations we can’t use two-sample t-tests since the independence assumption is not valid. 
#Instead we need to use a paired t-test. This can be done using the option paired =TRUE.

# Ex. A study was performed to test whether cars get better mileage on premium gas than on regular gas. 
#Each of 10 cars was first filled with either regular or premium gas, decided by a coin toss, and the mileage for that tank was recorded. 
#The mileage was recorded again for the same cars using the other kind of gasoline. 
#We use a paired t- test and a one-tailed hypothesis test to determine whether cars get significantly better mileage with premium gas.

reg = c(16, 20, 21, 22, 23, 22, 27, 25, 27, 28)
prem = c(19, 22, 24, 24, 25, 25, 26, 26, 28, 32)
t.test(prem,reg,alternative="greater", paired=TRUE)

#Conclusion: premium gas yields significantly better mileage.


# D. Linear Regression

#An engineer working for an automanufacturer is working on a new car
#and wants to know the relationship between the speed of the car and distance it takes to stop.
#So, she takes a sample of cars from the population of newly designed cars and records 50 observations,
#noting the distance taken to stop (in feet) associated with specific speeds (in miles per hour). 
#How can we use linear regression to answer this question?



# Please install the MASS package to access the data:
install.packages("MASS")
library(MASS)

#First, let's examine the data visually, descriptively, and graphically:
#The data are in a built-in dataset called "cars"
View(cars)

#to get descriptive statistics for all dataset variables:
summary(cars)

#or we can examine just the variables of interest:
summary(cars$speed)
summary(cars$dist)

#plot distance by speed:
plot(x=cars$speed, y=cars$dist)

#we can also construct a plot with a fitted line:
scatter.smooth(x=cars$speed, y=cars$dist, main="Dist ~ Speed")  # scatterplot

#fit a linear regression model with "lm()" and get the results with "summary()":
#To test the null hypothesis that Ho: B=0 (i.e., that the parameter estimate associated with X(speed) is no different from 0), 
#with alpha set at a=0.05.:
model1 <- lm(dist~speed,  data=cars)
summary(model1)

#Interpretation:
#We reject the null hypothesis that B=0 due to a t-statistic of 9.46 and it's corresponding p-value of <0.001.
#I.e., it is highly unlikely that the coefficient "speed" is different from 0 purely by change.
#Further, we see that for every 1-MPH increase in speed, the distance taken to stop is increased by 3.932 feet.

#The Standard Error (SE) associated with "speed" shows us how much the coefficient estimate varies from the actual 
#value of the response variable. So our estimate of 3.9 feet per 1-MPH increase may vary by 0.4155 feet.
#We can also use the SE to calculate 95% Confidence Intervals (CIs), either by hand (3.932+/-1.96*0.4155), 
#or using the command:
confint(model1)
#This 95%CI gives us a range of values which are likely to include the true population parameter of interest.
#Specifically, there is a 95% chance that the true value for speed is between the interval 3.10 and 4.77.
#In other words, if you re-sampled the data many, many times and re-ran the model, the true population parameter for speed would
#lie between the interval 3.10 and 4.77 95% of the time.

#Overall goodness of fit for entire model:
#We also see that the F-statistic is statistically significant, indicating that our model is a good fit to the data.

#Furthermore, based on the R-squared value of 0.6511 we see that our model explains 65% of the total variation in stopping distance (note: this is quite high)
#(Note: use the Multiple R-squared value. The Adjusted R-squared value is helpful for comparing nested models)

#Lastly, we see that the Residual Standard Error is 15.38. This tell us how closely the model fit is to the actual observed values.
#It is a measure of the quality of our linear regression fit.
#The value 15.38 suggests that the actual distance required to stop may deviate from the true regression line by around 15.38 feet, on average.




