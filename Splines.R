library(ggplot2)
library(splines)

setwd("C:/Users/ellen/OneDrive/Documents/Spring 2017/Section III/History")
mydata <- read.csv(file="Ex1LS.csv", header=TRUE, sep=",")

mydata$X1 <- mydata$X

p <- ggplot(data = mydata) + geom_point(aes(x = X1, y = Y))
p

model <- lm( formula = Y ~ X, mydata)
modelQ <- lm( formula = Y ~ X + I(X^2), mydata)
modelNS <- lm(data = mydata, Y ~ ns(X, 2)) # you can also specifically set knots, but beware

predData <- data.frame(X = seq(1, 10, 1))

predData$Y <- predict(model, predData)
predData$Q <- predict(modelQ, predData)
predData$NS <- predict(modelNS, predData)

p <- ggplot(predData, aes(x=X, y=Y)) + geom_point()
p <- p + geom_point(data = predData, aes(x=X, y = Y), color = 'black')
p <- p + geom_point(data = predData, aes(x=X, y = Q), color = 'red')
p <- p + geom_point(data = predData, aes(x=X, y = NS), color = 'blue')
p <- p + geom_smooth(data=predData, aes(x=X, y = Y), se=FALSE, color = "black")
p <- p + geom_smooth(data=predData, aes(x=X, y = Q), se=FALSE, color = "red")
p <- p + geom_smooth(data=predData, aes(x=X, y = NS), se=FALSE, color = "blue")
p

summary(model)
summary(modelQ)
summary(modelNS)

setwd("C:/Users/ellen/OneDrive/Documents/Final Content/Projects/AutomobileData")
Auto <- read.csv(file="Automobile Price Prediction.csv")

p <- ggplot(Auto, aes(x=horsepower, y=price))+geom_point() 
p

model <- lm(price ~ horsepower + highway.mpg, data = Auto)
modelQ <- lm( formula = price ~ horsepower + I(horsepower^2) + highway.mpg + I(highway.mpg^2), Auto)
modelNS <- lm(data = Auto, price ~  ns(horsepower, 5) + ns(highway.mpg, 5))

predData <- data.frame(horsepower = seq(min(Auto$horsepower), max(Auto$horsepower), length.out = 50), highway.mpg = seq(min(Auto$highway.mpg), max(Auto$highway.mpg), length.out = 50))

predData$Y <- predict(model, predData)
predData$Q <- predict(modelQ, predData)
predData$NS <- predict(modelNS, predData)

p <- ggplot(predData, aes(x=X, y=Y))
p <- p + geom_point(data = predData, aes(x=horsepower, y = Y), color = 'black')
p <- p + geom_point(data = predData, aes(x=horsepower, y = Q), color = 'red')
p <- p + geom_point(data = predData, aes(x=horsepower, y = NS), color = 'blue')
p <- p + geom_smooth(data=predData, aes(x=horsepower, y = Y), se=FALSE, color = "black")
p <- p + geom_smooth(data=predData, aes(x=horsepower, y = Q), se=FALSE, color = "red")
p <- p + geom_smooth(data=predData, aes(x=horsepower, y = NS), se=FALSE, color = "blue")
p

summary(model)
summary(modelQ)
summary(modelNS)
