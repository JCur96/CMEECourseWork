# !/usr/bin/env Rscript
# PP_Lattice.R
# Auth: Jake Curry, j.curry18@imperial.ac.uk
# Oct 2018
# Lattice practical, saving lattice graphs to pdf docs
# creating a table of medians/means by interaction type, probably using the aggregate function


# setwd("~/Documents/CMEECourseWork/Week3/Code") # wd for my convienience, will comment out before push


ppd <- read.csv("../Data/EcolArchives-E089-51-D1.csv") # import data
dim(ppd) #check the size of the data frame you
head(ppd) # see tops of columns 

# required packages
require(lattice)
require(reshape2)
require(tidyr)
require(dplyr)

# making sure that density plot is doing what it should
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=ppd)
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data=ppd)
densityplot(~log(Predator.mass/Prey.mass) | Type.of.feeding.interaction, data=ppd)

#### Plotting the three lattices to pdf documents

pdf("../Results/Pred_Lattice.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
  densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=ppd, 
    xlab="log(Predator Mass)", ylab="Density", main = "log Predator Mass by feeding interaction type") # Plot predator lattice
graphics.off(); #you can also use dev.off()

pdf("../Results/Prey_Lattice.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data=ppd, 
            xlab="log(Prey Mass)", ylab="Density", main = "log Prey Mass by feeding interaction type") # Plot predator lattice
graphics.off(); #you can also use dev.off()

pdf("../Results/SizeRatio_Lattice.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
densityplot(~log(Predator.mass/Prey.mass) | Type.of.feeding.interaction, data=ppd, 
            xlab="log(Size Ratio)", ylab="Density", main = "log of Predator/Prey size ratio by feeding interaction type") # Plot predator lattice
graphics.off(); #you can also use dev.off()


# using the tidyverse to vectroize getting summary statistics a little bit 

##### the large chunk commented out exemplifies another way of doing it, however it is not totally complete
# the melt function isn't quite right as it groups both median and mean in one column

# df <- ppd %>% #creates an object of results, takes the original df and pipes it 
#   group_by(Type.of.feeding.interaction) %>% # to group_by (fairly self explanatory), which pipes to
#   summarize(mean_Log.Pred.Mass = mean(log(Predator.mass)), # summarize (prints the summary), does the mean in this case
#             median_Log.Pred.Mass = median(log(Predator.mass)),
#             mean_Log.Prey.Mass = mean(log(Prey.mass)),
#             median_Log.Prey.Mass = median(log(Prey.mass)),
#             mean_Log.Mass.Ratio = mean(log(Predator.mass/Prey.mass)),
#             median_Log.Mass.Ratio = median(log(Predator.mass/Prey.mass)))
# 
# 
# finaldf <- melt(df)


a <- ppd %>% #creates an object of results, takes the original df and pipes it
  group_by(Type.of.feeding.interaction) %>% # to group_by (fairly self explanatory), which pipes to
  summarize(Mean = mean(log(Predator.mass)),
  Median = median(log(Predator.mass))) # summarize (prints the summary), does the mean in this case

a$"Type"<-"Log.Predator.Mass"

b <- ppd %>%
  group_by(Type.of.feeding.interaction) %>%
  summarize(Mean = mean(log(Prey.mass)),
            Median = median(log(Prey.mass)))
b$"Type"<-"Log.Prey.Mass"
 
  
c <- ppd %>%
  group_by(Type.of.feeding.interaction) %>%
  summarize(Mean = mean(log(Predator.mass/Prey.mass)),
            Median = median(log(Predator.mass/Prey.mass)))
c$"Type"<-"Log.Mass.Ratio"

df1 <- rbind(a, b) # inner_join is a dplyr function for merging tables
df2 <- rbind(df1, c)


#### Making a results csv file
write.csv(df2, "../Results/PP_Results.csv", row.names = F) # writing out the matrix of mean and median by feeding type
# and removing the indexing column

