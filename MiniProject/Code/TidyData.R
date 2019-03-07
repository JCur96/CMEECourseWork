# !/usr/bin/env Rscript
# TidyData.R
# Jake Curry (j.curry18@imperial.ac.uk)
# Oct 2018
# Removes NAs from the starting parameters dataset 
##############################################
rm(list=ls())
graphics.off()
####

DF <- read.csv("../Data/Biotraits_with_start_params.csv")
DF <- na.omit(DF)
write.csv(DF, file = "../Data/Biotraits_start_no_na.csv")
