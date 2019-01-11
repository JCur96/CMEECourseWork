# !/usr/bin/env Rscript
# MP_DataViz.R
# Jake Curry (j.curry18@imperial.ac.uk)
# Oct 2018
# Visualizing MP data 
##############################################
rm(list=ls())
graphics.off()
############# Required packages ##############
require(dplyr)
require(plyr)
require(tidyr)
require(ggplot2)


##################################################
setwd("~/Documents/CMEECourseWork/MiniPorject/Code")



# Reading data in 
DF <- read.csv("../Data/BioTraits.csv", header = T)

# quick and dirty subsetting
myvars <- c("OriginalTraitValue", "OriginalTraitUnit", "ConTemp", "FinalID", "StandardisedTraitName", "StandardisedTraitValue", "StandardisedTraitUnit")
DF1 <- DF[myvars]

FDF <- DF1 %>%
  group_by(FinalID) %>% # creates unique IDs for identifying unique thermal responses
  filter(n()>5) # removing sets with less than five points


# making indivdual graphs for each unique ID
plot_list = list()
for (var in unique(FDF$FinalID)) { # unique id -- use final ID to make a list of unique ID's
  p = ggplot(DF1[FDF$FinalID==var,], aes(ConTemp, OriginalTraitValue)) + geom_point()
  plot_list[[var]] = p
}

# Save plots to tiff. Makes a separate file for each plot
for (var in unique(FDF$FinalID)) {
  file_name = paste("../Results/Prelim_Graphs/TPC_Graph_", var, ".tiff", sep="")
  tiff(file_name)
  print(plot_list[[var]])
  dev.off()
}

abs()






####################################################################
# DF <- as.matrix(read.csv("../Data/BioTraits.csv", header = T)) 
# ggplot(DF1, aes(x=ConTemp, y=OriginalTraitValue, group=FinalID)) +
#   geom_point() + 
#   facet_wrap( ~ FinalID) # either group=FinalID or facet_wrap(FinalID)
# myvars <- c("OriginalTraitValue", "ConTemp", "FinalID")
# DF1 <- DF[myvars]
# # Need to subset/group by trait name I think, otherwise this is very meaningless
# GDF <- group_by(DF1, FinalID)
# 
# 
# # plot(DF1$FinalID ~ DF1$OriginalTraitValue + DF$ConTemp)
# # plot(DF1$OriginalTraitValue ~ DF1$FinalID + DF$ConTemp)
# # plot(DF1$OriginalTraitValue ~ DF$ConTemp + DF1$FinalID)
# 
# plot(DF1$OriginalTraitValue ~ DF1$ConTemp)

