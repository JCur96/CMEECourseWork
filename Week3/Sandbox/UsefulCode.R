

# combinations = expand.grid(unique(ppd$Type.of.feeding.interaction), unique(ppd$Predator.lifestage)) # make a df of all possible combinatation
# for (i in 1:nrow(combinations)){
#   tfi = combinations[[i, "Var1"]]
#   pls = combinations[[i, "Var2"]]
#   subset_model = subset(ppd, Type.of.feeding.interaction == tfi & Predator.lifestage == pls)
#   print(head(subset_model))
# }


# c <- c("Type.of.feeding.interaction", "Predator.lifestage")
# 
# list_reg <- dlply(ppd, c, function(df) 
# {lm(log(Predator.mass)~log(Prey.mass),data=df)})
# 
# length(list_reg)
# #That's how you check out one particular regression, in this case the first
# summary(list_reg[[1]])



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
