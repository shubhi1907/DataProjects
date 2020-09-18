library(MASS)
head(chem)

#Question 1 i
m <- mean(chem)
m#?t.test
t.test(chem,alternative = "greater", mu = m, paired = FALSE)

#Question 1 ii
head(cats)
Male <- subset(cats,subset = (cats$Sex=="M"))
Male <- Male$Bwt
Mm <- mean(Male)

Female <- subset(cats, subset = (cats$Sex=="F"))
Female <- Female$Bwt
Fm <- mean(Female)

mu <- Mm-Fm
mu

t.test(Male, Female ,alternative = "two.sided", mu = 0.5404, paired = FALSE, var.equal = TRUE)


#Question 2 - 1
head(mtcars)
library(corrplot)
corm <- cor(mtcars)
corrplot(corm, method = "color")

#Question 2 - 2
library(ggplot2)
wt <- mtcars$wt
mpg <- mtcars$mpg
lm(mpg~wt)
#the mpg value(-5.344) is the slope of the line.
#total variance of 37.285 in gas mileage is explained by car weight.
ggplot(mtcars, aes(x=mpg, y=wt, color= "red")) + geom_point() + geom_smooth(method = "lm", se=FALSE) + ggtitle("Car Weight vs Car Gas Mileage")

#Summary f main Analytical Findings
summary(lm(mpg~wt)) #for Data Scientists
#for Non-Data Scientists
layout(matrix(1:4,2,2))
plot(lm(mpg~wt))



#Question 3
#hypothesis testing

datasets::attitude
NROW(attitude)
head(attitude)
m2 <- mean(attitude$learning)
m3 <- mean(attitude$complaints)
mdiff <- m3-m2
mdiff
t.test(attitude$complaints, attitude$learning, alternative = "two.sided", mu = mdiff, paired = FALSE, var.equal = TRUE)
