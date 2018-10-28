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

a <- ppd %>% #creates an object of results, takes the original df and pipes it 
  group_by(Type.of.feeding.interaction) %>% # to group_by (fairly self explanatory), which pipes to
  summarize(mean_Log.Pred.Mass = mean(log(Predator.mass))) # summarize (prints the summary), does the mean in this case

b <- ppd %>%
  group_by(Type.of.feeding.interaction) %>%
  summarize(median_Log.Pred.Mass = median(log(Predator.mass)))

c <- ppd %>%
  group_by(Type.of.feeding.interaction) %>%
  summarize(mean_Log.Prey.Mass = mean(log(Prey.mass)))

d <- ppd %>%
  group_by(Type.of.feeding.interaction) %>%
  summarize(median_Log.Prey.Mass = median(log(Prey.mass)))

e <- ppd %>%
  group_by(Type.of.feeding.interaction) %>%
  summarize(mean_Log.Mass.Ratio = mean(log(Predator.mass/Prey.mass)))

f <- ppd %>%
  group_by(Type.of.feeding.interaction) %>%
  summarize(median_Log.Mass.Ratio = median(log(Predator.mass/Prey.mass)))

#### Making a unified table (it's a bit messy I know, but it works)

df1 <- inner_join(a, b) # inner_join is a dplyr function for merging tables
df2 <- inner_join(df1, c) # I couldn't think of a way to merge more than two tables at a time
df3 <- inner_join(df2, d)
df4 <- inner_join(df3, e)
finaldf <- inner_join(df4, f)

# I feel like it could be neatened using the combine(...) function, but that throws up errors

#### Making a results csv file
write.csv(finaldf, "../Results/PP_Results.csv", row.names = F) # writing out the matrix of mean and median by feeding type
# and removing the indexing column


