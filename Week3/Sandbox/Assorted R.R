MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = F,  stringsAsFactors = F))
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T,  sep=";", stringsAsFactors = F)
class(MyData)
head(MyData)
MyData<-t(MyData)
head(MyData)
colnames(MyData)
rownames(MyData)
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F)
head(MyData)
colnames(TempData) <- MyData[1,]
require(reshape2)
MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")
head(MyWrangledData); tail(MyWrangledData)
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])
str(MyWrangledData)
View(MyData)
View(MyWrangledData)
require(dplyr)



MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")
dim(MyDF) #check the size of the data frame you loaded
plot(MyDF$Predator.mass,MyDF$Prey.mass)
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass))
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20, xlab = "Predator Mass (kg)", ylab = "Prey Mass (kg)") # Add labels
hist(MyDF$Predator.mass)
hist(log(MyDF$Predator.mass), xlab = "Predator Mass (kg)", ylab = "Count") # include labels
