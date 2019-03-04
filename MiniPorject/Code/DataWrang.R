# !/usr/bin/env Rscript
# DataWrang.R
# Jake Curry (j.curry18@imperial.ac.uk)
# Oct 2018
# Wrangling MP data 
##############################################
rm(list=ls())
graphics.off()
############# Required packages ##############
require(dplyr)
require(plyr)
require(tidyr)
require(ggplot2)
#install.packages("minpack.lm")
#library(minpack.lm)

##################################################
# Reading data in 
DF <- read.csv("../Data/BioTraits.csv", header = T)

# quick and dirty subsetting
myvars <- c("OriginalTraitValue", "OriginalTraitUnit", "ConTemp", "FinalID", 
            "StandardisedTraitName", "StandardisedTraitValue", "StandardisedTraitUnit")
DF <- DF[myvars]

DF <- DF %>% # this works after reverting to using filter(n()>5) for some reason
  filter(OriginalTraitValue >0) %>% # removing 0 and negative trait values
  filter(OriginalTraitValue !=is.na(OriginalTraitValue)) %>% # removes rows with NA
  group_by(FinalID) %>% # creates unique IDs for identifying unique thermal responses
  filter(n()>5) # removing sets with less than five data points

# adding columns for use in starting value calculations
# converting to kelvin
DF$Temp_K <- NA # makes a temp in kelvin column
DF$Temp_K<- DF$ConTemp + 273.15 # converts all temps to kelvin

# logging trait value to calculate graident (E and Eh)
DF$logTraitValue <- NA
DF$logTraitValue <- log(DF$OriginalTraitValue)

# finding 1/kT (k being boltzmann constant) for graident calculations
k = 8.617e-5 # setting the boltzmann constant
DF$GradientTemp <- NA 
DF$GradientTemp <- 1/(DF$Temp_K*k) # calculating the temperature scale for making the gradient calculations

write.csv(DF, file = "Data/Updated_BioTraits.csv") # saving the newly prepared data (all prepared barring starting values)
