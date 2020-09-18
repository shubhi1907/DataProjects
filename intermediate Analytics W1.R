getwd()
  setwd("/Users/shubh/Desktop/Intermediate Analytics/Week 1/")
    data1 <- read.csv("assignment1.csv",header = T)
    data2 <- read.csv("height_weight_by_gender.csv",header = T)
    
#Q1 Descriptive statistics
  #summary statistics (mean, median, standard deviation, min, max, Q1, and Q3) 
  #converting Sepal.width to numeric
  Sepal.Width <- sapply(data1[,3], as.numeric)
    mean(Sepal.Width)
    median(Sepal.Width)
    sd(Sepal.Width)
    min(Sepal.Width)
    max(Sepal.Width)
    quantile(Sepal.Width,probs=seq(0,1,0.25))

  #create a histogram for Sepal.Width
  width<- data1$Sepal.Width
  hist(width,main = "Histogram of Sepal.Width")


#Q2 A histogram of mens and womens height
  Gender<-data2$Gender
  Height<-data2$Height..inches.
  Weight<-data2$Weight..lbs.
hist(Height,xlab="Height",ylab="Gender", main="Histogram of men’s and women’s height")

#Q2 Scatterplot comparing the weight and height of men and women
  library(ggplot2)
    dataG <- as.factor(data2$ï..Gender)
    head(data2)
    ggplot(data2, aes(x=Height..inches., y=Weight..lbs., color=dataG, Shape=dataG)) + geom_point() + geom_smooth(method = "auto", se=FALSE) + ggtitle("Height & Weight of Men vs Women")


#Q3 Scatter plot of height Vs weight for men or women
  par(mfrow=c(1,2))

  #Female Data
    femaledata <- data2 [ which(data2$ï..Gender=='Female'), ]
    Height..inches<- femaledata$Height..inches.
    Weight..lbs<- femaledata$Weight..lbs.
    plot(Weight..lbs, Height..inches, pch = 20, col = "pink", main = "Female Height vs Weight")
    lines(lowess(Weight..lbs, Height..inches), lty = 1, col="black") # lowess line (x,y)

  #Male Data
    maledata <- data2 [ which(data2$ï..Gender=='Male'), ]
    Height..inches<- maledata$Height..inches.
    Weight..lbs<- maledata$Weight..lbs.
    plot(Weight..lbs, Height..inches, pch = 20, col = "cyan", main = "Male Height vs Weight")
    lines(lowess(Weight..lbs, Height..inches), lty = 1, col="black") # lowess line (x,y)





