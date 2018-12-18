# # !/usr/bin/env Rscript
# HPC_out_read.R
# Jake Curry (j.curry18@imperial.ac.uk)
# Nov 2018
# HPC week in R 
############################################## 
rm(list=ls())

############################################# loading the results back in ############################
# load('jc5181.rda')
# should probably change this to refelct that you need to have WD set to whereever the actual files are for it to work

files <- list.files('../Results', pattern = '*.rda') # loading in all the files in a batch, storing them in a list

############################## Seperating the runs out by size #############################################
size_500 = c() # make size classes - vectors for files of specific run sizes
size_1000 = c()
size_2500 = c()
size_5000 = c()
for(i in files){
  load(i) # load each file so that size can be examined
  if(size == 500){
    size_500 = append(size_500, i) # adding to appropriate vector
  } else if(size == 1000){
      size_1000 = append(size_1000, i)
  } else if(size == 2500){
      size_2500 = append(size_2500, i)
  } else if(size == 5000){
      size_5000 = append(size_5000,i)
    }
}

###############sum_vect#####################################
# bringing in a funciton needed in a moment
# summing two vectors, the shorter of which has been filled with 0 to equal length
sum_vect <- function(x, y){
  dif <-  (length(x) - length(y))^2
  dif <- sqrt(dif)
  if(length(x) < length(y)) { 
    x <- c(x, seq(0, 0, length.out = dif))
  }
  if(length(x) > length(y)) {
    y <- c(y, seq(0, 0, length.out = dif))
  }
  z <- x + y
  return(z)
}



####### making a multi-pane plot #######
par(mfrow=c(2,2))

######### plotting the data #########
for(i in list(size_500, size_1000, size_2500, size_5000)){
  sim_oct = c()
  for(names in i){
    load(names)
    cum_oct = c()
    burn_in_end = burn_in_generations / interval_oct
    for(octaves in SAO[burn_in_end:length(SAO)]){
      #pull out the octaves here
      cum_oct = sum_vect(cum_oct, octaves) 
    }
    avg_file = unlist(lapply(cum_oct, function(n) n/length(cum_oct) - burn_in_end))
    sim_oct = sum_vect(sim_oct, avg_file)
  }
  #average simulatin octaves 
  avg_SAO = unlist(lapply(sim_oct, function(n) n/length(i)))
  barplot(avg_SAO, xlab='Octaves', ylab='Average Species Abundance', main=paste('Size =', size))
  #print(avg_SAO)
  #print(i)
}






