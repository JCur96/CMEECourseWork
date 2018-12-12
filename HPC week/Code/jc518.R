# # !/usr/bin/env Rscript
# jc518.R
# Jake Curry (j.curry18@imperial.ac.uk)
# Nov 2018
# HPC week in R 
############################################## 
rm(list=ls())
graphics.off()

##############################species_richness################

# Function for species richness 
species_richness <- function(x) {
  sp_num <- unique(x)
  richness <- length(sp_num)
  return(richness)
}
# species_richness()

###########################initialise_min#####################

# generating alternate monodominace intial condition
initialise_min <- function(x) {
  Sp_Num <- as.vector(rep_len(1, x))
  return(Sp_Num)
}
# initialise_min()

#########choose_two############################################

# picking two random numbers within a uniform distribution
choose_two <- function(x) {
  two <- as.vector(sample(1:x, 2))
  return(two)
}
# choose_two()

################neutral_speciation#############################

# neutral speciation
neutral_step_speciation <- function(community, v) {
  RD <- choose_two(length(community))
  p <- runif(1, 0, 1) 
  if(p <= v) {
    community[RD[1]] = max(community)+1
  } else {
    community[RD[1]] = community[RD[2]]
  }
  return(community)
}
# neutral_step_speciation(c(10,5,13), v = 1)

################neutral_generation_speciation######################

# neutral generation speciation
neutral_generation_speciation <- function(community, v) {
  x <- length(community)
  if(x %% 2 != 0) {
    x = x+1
  }
  for(i in 1:(x/2)) {
    community <- neutral_step_speciation(community, v)
  }
  return(community)
}

# neutral_generation_speciation(c(10,13,3), v = 1)

#################Species_abundance############################

# Species abundance
species_abundance <- function(x) { 
  x <- table(x)
  x <- sort(x, decreasing = T)
  return(x)
}
species_abundance(c(1,5,3,6,5,6,1,1))

##############octaves##################################

# octaves
octaves <- function(x) {
  #print(x)
  bin <- tabulate(floor(log2(x)+1))
  return(bin)
  
}
# octaves(c(100,64,63,5,4,3,2,2,1,1,1,1))

###############sum_vect#####################################

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

# sum_vect(c(1,3), c(1,0,5,2))

##########################################################

cluster_run <- function(speciation_rate, size, wall_time, interval_rich,
                        interval_oct, burn_in_generations, output_file_name) {
  COM = rep(1, size) # community size
  SAO <- list() # species abundance octaves
  i <- 0 # 
  generation <- 0 # which generation it is on
  SR2 <- 0 # species richness vector needed later 
  SR <- vector() # species richness vector needed later
  wall_time <- wall_time*60 # making a clock in seconds
  x <- proc.time()[3] # pulling out system time
  # x <- Sys.time()
  # if(x + wall_time == F) {
  # print('is this on?')
  while((proc.time()[3] - x) <  wall_time) { # making a timer
    #print(proc.time()[3] - x)
      COM <- neutral_generation_speciation(community = COM, v = speciation_rate) # updating the communtiy at each iteration
      generation <- generation + 1 
      if(generation < burn_in_generations){ # whilst burn in is happening
        if(generation %% interval_rich == 0) { # at these intervals
          SR2 <- species_richness(COM) # get species richness
          SR <- append(SR, SR2) # append to the list of species richnesses
        }
      } else {
        if(generation %% interval_oct == 0) { # at these intervals
          i <- i + 1 
          SAO[[i]]  <- octaves(species_abundance(COM)) # get species abundance octaves
        } 
      }
    }
  wall_time <- wall_time/60 # getting time back into minutes
  TotT <- (proc.time()[3] - x) # getting total run time in computer time
  save(SR, SAO, COM, TotT, speciation_rate, size, wall_time, interval_rich,
       interval_oct, burn_in_generations, file = output_file_name) # saving to an .rda outfile
}


# cluster_run(speciation_rate = 0.1, size = 100, wall_time = 10, interval_rich = 1, interval_oct = 10, 
#             burn_in_generations = 200, output_file_name = 'my_test_file_1.rda')
# 
# load(file = 'test.rda')

###############################################################################
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX")) # getting iteration number from computer
# iter <- seq(1, 3, 1)
# iter = 25
set.seed(iter) # setting random seed based on iteration 
##############################setting J (commuity size) based on iteration number#################################################
if(iter <= 25){ 
  J = 500
} else if(iter <= 50){
  J = 1000
} else if(iter <= 75){
  J = 2500
} else if(iter <= 100){
  J = 5000
}
#######################setting outfile names##########################################################
output_file_name = paste('jc518', as.character(iter), '.rda', sep ='')
# cluster_run(speciation_rate = 0.1, size = J, wall_time = 690, interval_rich = 1, interval_oct = size/10, 
#             burn_in_generations = 8*size, output_file_name = output_file_name)

# iter = 20
# iter = 25
# iter = 40
# iter = 66
# iter = 76
cluster_run(speciation_rate = 0.004346, size = J, wall_time = 690, interval_rich = 1, interval_oct = J/10,
            burn_in_generations = 8*J, output_file_name = output_file_name)


############################################# loading the results back in ############################
load('jc5181.rda')


