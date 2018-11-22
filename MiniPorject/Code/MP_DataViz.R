# !/usr/bin/env Rscript
# MP_DataViz.R
# Jake Curry (j.curry18@imperial.ac.uk)
# Oct 2018
# Visualizing MP data 
#########

############# Required packages ##############
require(dplyr)
require(tidyr)

setwd("~/Documents/CMEECourseWork/MiniPorject/Code")




DF <- read.csv("../Data/BioTraits.csv", header = T)

DF <- as.matrix(read.csv("../Data/BioTraits.csv", header = T)) 
head(DF)

plot(DF$IndividualID ~ DF$OriginalTraitValue + DF$ConTemp)
