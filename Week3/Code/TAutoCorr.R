# TAutoCorr.R

load("../Data/KeyWestAnnualMeanTemperature.RData", envir = parent.frame(),  verbose = T)
ats
str(ats)
head(ats)
plot(ats)

# Make vector at T0
# Make vector at T-1
# Run correlation test between the two vectors
# Return the result


correlation_finder <- function(v){
  v_T = v[2:length(v)]
  v_T_1 = v[1:length(v)-1]
  cor_out <- cor(v_T, v_T_1)
  return(cor_out)
}


corr.est = correlation_finder(ats$Temp) # producing the correlation coefficient for the unjumbled one 

print(corr.est)
# takes a random sample of the data, in this case assinged length, so
# gives a jumbled version of ats in this case
sample(ats$Temp, length(ats$Temp))

reps = 10000 # making a value for number of replicates

coeff.vec = numeric(length = reps) # making a vector of corr coefficients

# This could be neatened so that it calls the function made earlier to do these again
v_T = ats[1:(nrow(ats)-1),2] # vector that is a subset of the imported data, minus one off the end so that it is the same length as T-1
v_T1 = ats[2:nrow(ats),2]

# iterate 1000 times, can be done using apply, but start by usinig a loop
for(i in 1:reps){
  x = sample(v_T,replace = T) # replacing the values in the T1 vector with a random jumble, 10000 times
  y = sample(v_T1, replace = T) # same as above but for T-1
  coeff.vec[i] = cor(x,y)
}

#Plotting the histogram of frequency of correlation values for the random samples occurs
hist(coeff.vec)
# plot(density(coeff.vec)) # density plot, it looks kinda nicer 

abline(v = corr.est,col = "red")# sticking a line where your unjumbled corr value appears

# Essentially asks which percentile the corr value found falls in, which translates to a p value
length(coeff.vec[coeff.vec>corr.est])/length(coeff.vec)


