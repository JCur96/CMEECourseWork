# !/usr/bin/env Rscript
# PP_Regress.R
# Auth: Jake Curry, j.curry18@imperial.ac.uk
# Oct 2018


setwd("~/Documents/CMEECourseWork/Week3/Code") # wd for my convienience, will comment out before push

#### packages
require(ggplot2)
require(plyr)
require(dplyr)
require(tidyr)

#### Reading in the data
ppd <- read.csv("../Data/EcolArchives-E089-51-D1.csv") 
head(ppd)

#### plotting 

p <- qplot(data = ppd, x = Prey.mass,
           y = Predator.mass,
           log = "xy",
           main = "Relation between predator and prey mass",
           xlab = "Prey mass (g)", 
           ylab = "Predator mass (g)",
           shape = I(3),
           facets = Type.of.feeding.interaction ~ .,
           colour = Predator.lifestage) + 
           geom_point(shape = I(3))
p + geom_smooth(method =lm, fullrange=T) + theme_bw()


##### getting results of lm 
# run a linear model of log prey mass ~ log predator mass 
# but by subset of feeding type and life stage (i.e. juv predatios, adult predatious etc.)

combinations = expand.grid(unique(ppd$Type.of.feeding.interaction), unique(ppd$Predator.lifestage)) # make a df of all possible combinatation
for (i in 1:nrow(combinations)){
  tfi = combinations[[i, "Var1"]]
  pls = combinations[[i, "Var2"]]
  subset_model = subset(ppd, Type.of.feeding.interaction == tfi & Predator.lifestage == pls)
  print(head(subset_model))
}



# this works I think 
list_reg <- dlply(ppd, .(Type.of.feeding.interaction, Predator.lifestage), function(ppd) 
{lm(log(Predator.mass)~log(Prey.mass),data=ppd)})

c <- c("Type.of.feeding.interaction", "Predator.lifestage")

list_reg <- dlply(ppd, c, function(df) 
{lm(log(Predator.mass)~log(Prey.mass),data=df)
  })

length(list_reg)
#That's how you check out one particular regression, in this case the first
summary(list_reg[[1]])

list_reg

coefs = ldply(list_reg, coef) # pull out parts of the reg_list results

R2 = ldply(list_reg, r.squared)

coefs

list_r2 <- dlply(ppd, function(df){summary(lm(log(Predator.mass)~log(Prey.mass),data=ppd))$r.squared})
  

# model1<- lm(log(ppd$Predator.mass) ~ log(ppd$Prey.mass), data = subset(ppd, Type.of.feeding.interaction, Predator.lifestage))
# 
# lm(y ~ x + z, data=subset(myData, sex=="female"))
# 
# summary(model1)


#### Making a results csv file
write.csv(MyDF, "../Results/PP_Regress_Results.csv", row.names = F) # writing out the final df
# and removing the indexing column








# p <- ggplot(ppd, aes(x = Prey.mass,
#                      y = Predator.mass,
#                      log = "xy",
#                      main = "Relation between predator and prey mass",
#                      xlab = "Prey mass (g)", 
#                      ylab = "Predator mass (g)",
#                      shape = I(3)) + facet_grid(Type.of.feeding.interaction ~ .) +
#                      aes(colour = Predator.lifestage) + geom_point())
# 
# pf <- p + facet_grid(Type.of.feeding.interaction ~ .) # put these inside the main plot 
# pf + aes(colour = Predator.lifestage) + geom_point() # it might sort the labelling issue

# scale_y_continuous() # this might be how we label the axis ticks correclty (remember it is the log so the weight in grams will be x+-*10^)

# pfp <- pf + coord_cartesian(xlim = c(1e-07, 1e+01), ylim = c(1e-06, 1e+06), expand = TRUE) + geom_point() # this bit isnt helping
# just need to do the tick marks and scale 

# ggplot(subset(dat,ID %in% c("P1" , "P3"))) + # can use subset in ggplot, this might be how we do this individually
  # facets =  .~ Type.of.feeding.interaction, # Or facets might be the way to go - this one seems better to me as less writing

# p1 <- ggplot(Prey.mass, Predator.mass, data = ppd, geom = c("point", "smooth"), # need to make it shape= I(3)) I think to get the crosses
       # colour = Predator.lifestage + geom_smooth(method = "lm")) # Type.of.feeding.interaction) 


# t1 <- qplot(Prey.mass, Predator.mass, data = ppd, facets =  .~ Type.of.feeding.interaction, facet_grid(method~., scale='free', space='free')), colour = Predator.lifestage)
# t2 <- t1 + coord_fixed()
# t2



# coord_cartesian(ylim = xlim))) # for fixing scale, but doesnt seem to do anything, might need 
# scale_y_continuous() # beforehand to make it do its thing

# multiplot(p1, p2, p3, p4, p5, cols=1) # makes a single page, one plot on top of the other #facets should do this also
