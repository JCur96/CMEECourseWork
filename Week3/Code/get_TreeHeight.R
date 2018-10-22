#!/usr/bin/env Rscript 
#TreeHeight.R
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


# using command args to enable this script to take external input
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

# generalised reading in
trees <- read.csv(args[1], header = T) 


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


# generalised out reading # IMPORTANT - remeber that args basically just provides a string, not the actual file! 
a <- args[1] # assigning the argument to a variable, so that it can be manipulated in R without touching the original file
a <- gsub(".csv", "_TreeHeight.csv", a) # replacing the extension 
a <- gsub("../Data/", "../Results/", a) # replacing the pathway

# function for writing to a comma delimited file
write.csv(TreesF, a)
