# Mapping practical
# 

# Imports 
require(maps) # loads them if not already present
#
load("../Data/GPDDFiltered.RData") # loads the R data file
str(gpdd) # gives structure of data set
long <- gpdd$long # makes a vector of longitudes
lat <- gpdd$lat # makes a vector of latitudes
map("world", fill=T, col="navy",  bg = "lightblue",ylim=c(-100, 100), mar=c(0,0,0,0)) # calls the map function from package maps
# world specifies the map databse of world map, fill determines if the mapped land will have a color, col is the color 
# it will have, bg is background color, x and ylim are the dimensions of the map, mar is margins 
points(long, lat, col="gold", pch=16) # adds points to the map from the vectors of latitude and longitude, coloring them gold 

# Looking at the map, what biases might you expect in any analysis based on the data represented?
# There's a latitudinal bias, with the northern hemisphere being over represented, there is a longitudinal bais, with the western 
# hemisphere being over represented. This may lead to analysis concluding that these hemispheres have a good LPI, 
# wheres the others have a poor LPI, however this may simply represent a sampling effort discrepencey.
