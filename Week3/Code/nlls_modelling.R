# !/usr/bin/env Rscript
# nlls_modelling.R
# Jake Curry (j.curry18@imperial.ac.uk)
# Oct 2018
# Playing around with non-linear least squares modelling
#########

setwd("~/Documents/CMEECourseWork/Week3/Code") # wd for this fun
rm(list = ls()) # clearing out the workspace casue why not
#####

graphics.off()
#### packages to load in
library("ggplot2")
library(repr)
require("minpack.lm")

#### here be actual code

powMod <- function(x, a, b) { # function for 
  return(a * x^b)
}


MyData <- read.csv("../Data/GenomeSize.csv") # importing the dataset

head(MyData) # shows the first ten lines 



Data2Fit <- subset(MyData,Suborder == "Anisoptera") # subsetting from the data

Data2Fit <- Data2Fit[!is.na(Data2Fit$TotalLength),] # removing the NA's from the subset

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight) # plotting cause why not

ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight)) + geom_point() # add eqn for line here basically, I forget the ggplot cmd for 
# that # eqn is: Weight = 3.94*10^-06 * Length^2.59

PowFit <- nlsLM(BodyWeight ~ powMod(TotalLength, a, b), data = Data2Fit, start = list(a = .1, b = .1)) # fitting a non-linear model
summary(PowFit) # getting the readout from that model

Lengths <- seq(min(Data2Fit$TotalLength),max(Data2Fit$TotalLength),len=200) # 

coef(PowFit)["a"]
coef(PowFit)["b"]

Predic2PlotPow <- powMod(Lengths,coef(PowFit)["a"],coef(PowFit)["b"])

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col = 'blue', lwd = 2.5)

confint(PowFit)