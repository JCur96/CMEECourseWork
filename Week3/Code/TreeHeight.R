#!/usr/bin/env Rscript 
# TreeHeight.R
# This function calculates the height of trees given the distance of each tree
# from its base and angle to its top, using the trigonometric formula
# 
# height = distance * tan(radians)
#
# ARGUMENTS 
# degrees:    The angle of elevation of tree 
# distance:   The distance from the base of the tree (e.g. meters)
#
# OUTPUT
# The heights of the tree, same unit as "distance"


trees <- read.csv("../Data/trees.csv", header = T)

TreeHeight <- function(degrees, distance) {
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  print(paste("Tree height is:", height))
  
  return (height)
}

TreeHts <- TreeHeight(trees$Angle.degrees, trees$Distance.m)

## cbind to make the output into an object, and then to bind (append) one object 
# to the next!
TrHts <- cbind(Height = c(TreeHts))
TreesF <- cbind(trees, TrHts)

# function for writing to a comma delimited file
write.csv(TreesF, "../Results/TreeHts.csv")

