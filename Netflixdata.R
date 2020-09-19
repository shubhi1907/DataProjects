library(ggplot2)

d <- read.csv(file.choose())
attach(d)
d

head(d)
summary(d)

 


#Question 1
q1 <- ggplot(d, aes(attacker_king, fill=attacker_king)) + 
  geom_histogram(stat = "count") + 
  labs(x="at", title = "df") 
q1
#Question 2
q2<-ggplot(d, aes(defender_king, fill=defender_king)) + 
  geom_histogram(stat = "count") + 
  labs(x="at", title = "df")
q2

#Question 3
q3<-ggplot(d, aes(region, fill=region)) + 
  geom_histogram(stat = "count") + 
  labs(x="at", title = "df")
q3

#Question 4
#used na.omit to remove the null values. 
d2 <- na.omit(d)
head(d2)
summary(d2)

#Question 5
q5<-ggplot(d, aes(battle_type, fill=region)) + 
  geom_histogram(stat = "count", position=position_dodge()) + 
  labs(x="at", title = "df")
#d$location <- d$location > '1'
Q5<-ggplot(d, aes(battle_type, fill=location)) + 
  geom_histogram(stat = "count", position=position_dodge()) + 
  labs(x="at", title = "df")
q5
Q5


#Question 7
q7<- data.frame(d$attacker_king, d$defender_king)
table(as.character(interaction(q7)))


