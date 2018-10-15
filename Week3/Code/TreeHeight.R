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

TreeHeight <- function(degrees, distance) {
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  print(paste("Tree height is:", height))
  
  return (height)
}

TreeHeight(37,40)