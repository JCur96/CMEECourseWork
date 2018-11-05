# !/usr/bin/env Rscript
# PP_Regress.R
# Auth: Jake Curry, j.curry18@imperial.ac.uk
# Oct 2018


# setwd("~/Documents/CMEECourseWork/Week3/Code") # wd for my convienience, will comment out before push

#### packages
require(ggplot2)
require(plyr)
require(dplyr)
require(tidyr)

#### Reading in the data
raw <- read.csv("../Data/EcolArchives-E089-51-D1.csv") 
head(raw)

##### Standardising the data - all prey mass in grams
ppd <- raw %>% rowwise() %>% mutate(Prey.mass = ifelse(Prey.mass.unit == "mg", Prey.mass/1000, Prey.mass)) # if prey.mass.unit =="mg" 
# then replace prey.mass with prey.mass/1000 

ppd[,"Prey.mass.unit"] = "g" # replaces all the mass units with g as all are now grams

#### plotting 
p <- qplot(data = ppd, x = Prey.mass,
           y = Predator.mass,
           log = "xy",
           xlab = "Prey mass (g)", 
           ylab = "Predator mass (g)",
           shape = I(3),
           facets = Type.of.feeding.interaction ~ .,
           colour = Predator.lifestage) + 
  geom_point(shape = I(3))
p + geom_smooth(method =lm, fullrange=T) + theme_bw() + 
  theme(legend.title = element_text(face = "bold"), legend.position = "bottom", plot.margin = unit(c(1,4,1,4), "cm")) + 
  guides(colour = guide_legend(nrow = 1))


##### Saving the graph to a pdf cause why not 
pdf("../Results/PP_Regress_Results.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
p <- qplot(data = ppd, x = Prey.mass,
           y = Predator.mass,
           log = "xy",
           xlab = "Prey mass (g)", 
           ylab = "Predator mass (g)",
           shape = I(3),
           facets = Type.of.feeding.interaction ~ .,
           colour = Predator.lifestage) + 
  geom_point(shape = I(3))
p + geom_smooth(method =lm, fullrange=T) + theme_bw() + 
  theme(legend.title = element_text(face = "bold"), legend.position = "bottom", plot.margin = unit(c(1,4,1,4), "cm")) + 
  guides(colour = guide_legend(nrow = 1))
graphics.off(); #you can also use dev.off()


##### getting results of lm 
# run a linear model of log prey mass ~ log predator mass 
# but by subset of feeding type and life stage (i.e. juv predatios, adult predatious etc.)

list_reg <- dlply(ppd, .(Type.of.feeding.interaction, Predator.lifestage), function(ppd) 
{lm(log(Predator.mass)~log(Prey.mass),data=ppd)})


outStat <- ldply(list_reg, function(df){ # Makes new df 
  intercept = summary(df)$coefficients[1] # pulls out the stats from the summary matrix 
  slope = summary(df)$coefficients[2] # each [] intger represents a differnt column in the stats matrix
  r2 = summary(df)$r.squared # is a pain so has be be pulled out slightly differently
  pvalue = summary(df)$coefficients[8]
  data.frame(intercept, slope, r2, pvalue)
  })


fstat <- ldply(list_reg, function(df){fStat = summary(df)$fstatistic[1] # is a right pain as it breaks the code if in the outStat bit
         data.frame(fStat)}) # so is kept out here 

finaldf <- merge(outStat, fstat) # merging the two results frames

#### Making a results csv file
write.csv(finaldf, "../Results/PP_Regress_Results.csv", row.names = F) # writing out the final df
# and removing the indexing column
