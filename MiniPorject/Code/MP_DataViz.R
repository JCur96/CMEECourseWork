# !/usr/bin/env Rscript
# MP_DataViz.R
# Jake Curry (j.curry18@imperial.ac.uk)
# Oct 2018
# Visualizing MP data 
##############################################
rm(list=ls())
graphics.off()
############# Required packages ##############
require(dplyr)
require(plyr)
require(tidyr)
require(ggplot2)
#install.packages("minpack.lm")
#library(minpack.lm)

##################################################
# Reading data in 
DF <- read.csv("../Data/BioTraits.csv", header = T)

# quick and dirty subsetting
myvars <- c("OriginalTraitValue", "OriginalTraitUnit", "ConTemp", "FinalID", 
            "StandardisedTraitName", "StandardisedTraitValue", "StandardisedTraitUnit")
DF <- DF[myvars]

DF <- DF %>% # this works after reverting to using filter(n()>5) for some reason
  filter(OriginalTraitValue >0) %>% # removing 0 and negative trait values
  filter(OriginalTraitValue !=is.na(OriginalTraitValue)) %>% # removes rows with NA
  group_by(FinalID) %>% # creates unique IDs for identifying unique thermal responses
  filter(n()>5) # removing sets with less than five data points

# adding columns for use in starting value calculations
# converting to kelvin
DF$Temp_K <- NA # makes a temp in kelvin column
DF$Temp_K<- DF$ConTemp + 273.15 # converts all temps to kelvin

# finding the smallest difference for schoolfield B0 calculations 
DF$difference <- NA
DF$difference <- sqrt((DF$Temp_K - 283.15)^2 )

# logging trait value to calculate graident (E and Eh)
DF$logTraitValue <- NA
DF$logTraitValue <- log(DF$OriginalTraitValue)

# finding 1/kT (k being boltzmann constant) for graident calculations
k = 8.617e-5 # setting the boltzmann constant
DF$GradientTemp <- NA 
DF$GradientTemp <- 1/(DF$Temp_K*k) # calculating the temperature scale for making the gradient calculations

# # starting values for schoolfield calculations
# start_params <- function(IDs) {
#   #"""generates starting values for schoolfield models for each group/FinalID"""
#   temp <- ID$GradientTemp 
#   logtraitval <- ID$logTraitValue   
#   midpoint <- max(ID$logTraitValue)
#   
#   EGrad = lm(temp[:midpoint] ~ logtraitval[:midpoint])
#   EhGrad = lm(temp[midpoint:] ~ logtraitval[midpoint:])
#   
#   B0 = exp(EGrad[2]*(1/(k*283.15)) + EGrad[1])
#   
#   Th = ((mean(logtraitval) - logtraitval*B0/EhGrad[0])**-1)/k
#   list = list(E = EGrad[0], Eh = EhGrad[0], B0 = B0, Th = Th)
#   list = do.call("rbind", df)
#   return(df)
# }
# 
# SF_start_params = list()
# SFlist = list()
# 
# for(unique_id in unique(DF$FinalID)){
#   try(SF_start_params <- start_params(unique_id),
#    silent = TRUE)
# }
 
 

minrows <- DF %>% group_by(FinalID) %>% slice(which.min(difference)) # produces all the rows which have the closest trait value to B0



# making indivdual graphs for each unique ID
plot_list = list()
for (var in unique(DF$FinalID)) { # unique id -- use final ID to make a list of unique ID's
  p = ggplot(DF[DF$FinalID==var,], aes(ConTemp, OriginalTraitValue)) + geom_point()
  plot_list[[var]] = p
}

# Save plots to tiff. Makes a separate file for each plot
for (var in unique(DF$FinalID)) {
  file_name = paste("Results/Prelim_Graphs/TPC_Graph_", var, ".tiff", sep="")
  tiff(file_name)
  print(plot_list[[var]])
  dev.off()
}


write.csv(DF, file = "Data/Updated_BioTraits.csv") # saving the newly prepared data (all prepared barring starting values)















#### initial fit data only ###
MTD2116<- DF %>% filter(FinalID == 'MTD2116')
test_plot = ggplot(MTD2116, aes(ConTemp, OriginalTraitValue)) +geom_point()
test_plot

MTD2116 <- read.csv("../Data/Biotraits_with_start_params.csv", header = T)
write.csv(MTD2116, file ="../Data/MTD2116.csv")

# originaltraitvalue as a function of temperature is what we are looking at here
####################################################################
# cubic is now working on an individual basis
cubic_test <- lm(MTD2116$OriginalTraitValue ~ poly(MTD2116$ConTemp,3))

plot(MTD2116$ConTemp, MTD2116$OriginalTraitValue)
lines(MTD2116$ConTemp, predict(cubic_test, data.frame(x=MTD2116$ConTemp))) # I think this works
summary(cubic_test)#R2 stat
AIC(cubic_test) # gives the AIC score, which I think I'll need later
BIC(cubic_test) # BIC scores


briere <- function(T, T0, Tm, c){
  return(c*T*(T-T0)*(abs(Tm-T)^(1/2))*as.numeric(T<Tm)*as.numeric(T>T0))
}

init_params <- runif(3, 0, 45)
for(i in 1:100){
  init_params <- 
  try(briere(x, y, z), FALSE)
}

y<-((runif(1,0,10)*x)/(runif(1,0,10)+x))# starting values maybe idk

test_br<-nls(OriginalTraitValue~briere(T=ConTemp, T0, Tm, c), start=list(T0=0, Tm=45, c=1), data=MTD2116)































k = 8.617 * 10^-5 # blotzman constant for schoolfield model 
Schoolfield <- function(B0, e, El, Eh, T, EI, TI,  Th, I){
  ((B0^e)^(-E/k)*((1/T) - (1/283.15))) / (1 + e^(EI/k) * ((I/TI) - (1/T))) + (e^(Eh/k)((I/Th) - (I/T)))
}








SchoolFTpk <- function(B0, E, E_D, T_pk, T_ref, T)
{ # Sharpe-Schoolfield model with explicit T_pk parameter
  
  # PARAMETERS/INPUTS (all temperatures in Kelvin) -
  # temp   : temperature values to evaluate function at (single, scalar or vector of values)
  # B0     : Normalisation constant (log transformed)
  # E      : Activation energy (> 0)
  # E_D    : High temperature de-activation energy (> 0) 
  # T_ref  : Standardization (reference) temperature; set to 0 if not wanted   
  # T_pk   : Temperature at which trait reaches peak value
  
  return(B0 + log(exp((-E/k) * ((1/T)-(1/T_ref)))/(1 + (E/(E_D - E)) * exp(E_D/k * (1/T_pk - 1/T)))))
}
####################################################################
# DF <- as.matrix(read.csv("../Data/BioTraits.csv", header = T)) 
# ggplot(DF1, aes(x=ConTemp, y=OriginalTraitValue, group=FinalID)) +
#   geom_point() + 
#   facet_wrap( ~ FinalID) # either group=FinalID or facet_wrap(FinalID)
# myvars <- c("OriginalTraitValue", "ConTemp", "FinalID")
# DF1 <- DF[myvars]
# # Need to subset/group by trait name I think, otherwise this is very meaningless
# GDF <- group_by(DF1, FinalID)
# 
# 
# # plot(DF1$FinalID ~ DF1$OriginalTraitValue + DF$ConTemp)
# # plot(DF1$OriginalTraitValue ~ DF1$FinalID + DF$ConTemp)
# # plot(DF1$OriginalTraitValue ~ DF$ConTemp + DF1$FinalID)
# 
# plot(DF1$OriginalTraitValue ~ DF1$ConTemp)

