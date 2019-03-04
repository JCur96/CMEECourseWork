# !/usr/bin/env Rscript
# Plotting.R
# Jake Curry (j.curry18@imperial.ac.uk)
# Oct 2018
# Plotting Fitted Data 
##############################################
rm(list=ls())
graphics.off()
############# Required packages ##############
require(dplyr)
require(plyr)
require(tidyr)
require(ggplot2)
################ Constants ##############################
# Boltzmann's contant in eV K^-1
k = 8.6173303e-05 
################ Reading data in ##################################
DF <- read.csv("../Data/Biotraits_start_no_na.csv", header = T)
colnames(DF)[colnames(DF)=="FinalID"] <- "UniqueID"
cubic_out <- read.csv("../Data/cubic_fitted.csv", header = T)
briere_out <- read.csv("../Data/briere_fitted.csv", header = T)
schoolfield_out <- read.csv("../Data/schoolfield_fitted.csv", header = T)
colnames(schoolfield_out)[colnames(schoolfield_out)=="B0"] <- "A0"
DF <- DF %>% select(ConTemp, Temp_K, OriginalTraitValue, logTraitValue, UniqueID)
cubic_plot <- cubic_out %>% select(B0, B1, B2, B3, UniqueID)
briere_plot <- briere_out %>% select(T0, Tm, c, UniqueID)  
schlfld_plot <- schoolfield_out %>% select(A0, E, Eh, Th, UniqueID)

DF1 <- merge(DF, cubic_plot, by="UniqueID")
DF1 <- merge(DF1, briere_plot, by="UniqueID")
DF1 <- merge(DF1, schlfld_plot, by="UniqueID")

DF2 <- merge(cubic_plot, briere_plot, by="UniqueID")
DF2 <- merge(DF2, schlfld_plot, by="UniqueID")
#############Plotting#######################
plot_list = list()
for (unique_id in unique(DF1$UniqueID)) {
  data <- DF1[DF1$UniqueID == unique_id, ]
  params <- DF2[DF2$UniqueID == unique_id, ]
  temperature <- seq(min(data$Temp_K), max(data$Temp_K), 0.1)
  tempC <- seq(min(data$ConTemp), max(data$ConTemp), 0.1)
  
  cubic_y <- params$B0 + params$B1*tempC + params$B2*tempC^2 + params$B3*tempC^3 # redo this probs
  cubic_y <- log(cubic_y)
  #briere_y <- params$c * tempC * (tempC - params$T0) * sqrt(abs(params$Tm - tempC)) #redo this probs
  briere_y <- params$c*tempC*(tempC-params$T0)*(abs(params$Tm-tempC)^(1/2))*as.numeric(tempC<params$Tm)*as.numeric(tempC>params$T0)
  #briere_y <- params$c * tempC * (tempC - params$T0) * (params$Tm - tempC)^(1/2)
  briere_y <- log(briere_y)
  schlf_y <- log((params$A0*exp(1)**((-params$E/k)*((1/temperature)-(1/283.15))))/(
    1+(exp(1)**((params$Eh/k)*((1/params$Th)-(1/temperature)))))) #redo this probs
  
  plt_data <- data.frame(temperature, cubic_y, briere_y, schlf_y)
  
  p = ggplot(data = data, aes(Temp_K, logTraitValue)) + # potentiall should be originaltraitvalue 
    geom_point() + 
    geom_line(data=plt_data, mapping = aes(temperature, cubic_y, color = "red", linetype ="dashed")) +
    geom_line(data=plt_data, mapping = aes(temperature, briere_y, color = "blue", linetype="dotted")) +
    geom_line(data=plt_data, mapping = aes(temperature, schlf_y, color = "yellow", linetype="solid")) +
    scale_color_discrete(name = "Model", labels = c("Cubic", "Briere", "Schoolfield")) +
    scale_linetype_discrete(name = "Model", labels = c("Cubic", "Briere", "Schoolfield")) +
    labs(x = "Temperature in Kelvin", y = "Logged Trait Value")
  plot_list[[unique_id]] = p
 
}
  

# Save plots to tiff. Makes a separate file for each plot
for (unique_id in unique(DF1$UniqueID)) {
 
  file_name = paste("../Results/TPC_Graphs/TPC_Graph_", unique_id, ".bmp", sep="")
  bmp(file_name)
  print(plot_list[[unique_id]])
  dev.off()
}

############ Summary stats (which models were the best) ######
# make a df here which combined all three AIC scores, replaces col header with model name
# then goes through by unique ID finding the smallest/lowest, appends to a list and returns which 
# model had the lowest the most
length(unique(DF$UniqueID)) - sum(is.na(cubic_out$AIC) == F) # number which didn't converge
length(unique(DF$UniqueID)) - sum(is.na(briere_out$AIC) == F) # number which didn't converge
length(unique(DF$UniqueID)) - sum(is.na(schoolfield_out$AIC) == F) # number which didn't converge
colnames(cubic_out)[colnames(cubic_out)=="AIC"] <- "cubic_AIC"
colnames(briere_out)[colnames(briere_out)=="AIC"] <- "briere_AIC"
colnames(schoolfield_out)[colnames(schoolfield_out)=="AIC"] <- "schoolfield_AIC"

cubic2merge <- cubic_out %>% select(cubic_AIC, UniqueID)
briere2merge <- briere_out %>% select(briere_AIC, UniqueID)
schlf2merge <- schoolfield_out %>% select(schoolfield_AIC, UniqueID)

mergedAIC <-  merge(cubic2merge, briere2merge, by = "UniqueID")
mergedAIC <- merge(mergedAIC, schlf2merge, by = "UniqueID")

# finds the minimum AIC score across rows (i.e. what fit best)
suppressWarnings(lowestAIC <- as.data.frame(colnames(mergedAIC)[apply(mergedAIC,1,which.min)]))
table(lowestAIC) # Cubic fits best the most frequently, and fits the most models!
print("Cubic fits best the most frequently, and fits the most models!")
