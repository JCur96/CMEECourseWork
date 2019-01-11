# # !/usr/bin/env Rscript
# jc518.R
# Jake Curry (j.curry18@imperial.ac.uk)
# Nov 2018
# HPC week in R 
################clearing the global environment############################## 
rm(list=ls())
graphics.off()


# Creating some dummy  data
community <- as.vector(c(1,4,4,5,1,6,1))
size <- 7

################species richness#########
# Function for species richness 
species_richness <- function(x) {
  sp_num <- unique(x) #finds all the unique numbers in x
  richness <- length(sp_num) #computes the length of the vector of unique
  return(richness) #returns that length so we know how many unique species there are
}
species_richness(communtiy)

################initialise conditions
# generating the initial state of the simulation
initialise_max <- function(x) {
  ComSize <- as.vector(seq(from = 1, to = x, by = 1)) # community size generated to maximum value, having each memeber 
  # be a unique species 
  return(ComSize)
}
initialise_max(size)

# generating alternate monodominace intial condition
initialise_min <- function(x) {
  Sp_Num <- rep(1, x)
  return(Sp_Num)
}
initialise_min(4)

############choose two#############
# picking two random numbers within a uniform distribution
choose_two <- function(x) {
  two <- as.vector(sample(1:x, 2))
  return(two)
}
choose_two(4)

# testing to make sure sample pulls two unique numbers
# for (i in 1:10000000){
#   a = choose_two(4)
#   if (a[1] == a[2]){
#     print("problem")
#     break
#   }
#   if (length(unique(a)) < 2) {
#     print("problem")
#     break
#   }
# }

#############neutral step#############
# writing a single step of a simple neutral model
neutral_step <- function(x) {
  RD <- choose_two(length(x))
  x[RD[1]] = x[RD[2]] #replacing one random choice with the others value
  return(x)
}

#dummy data
community<-c(10,5,13)

neutral_step(community)

#################neutral generation#########
# function to simulate a generation passing in the community 
neutral_generation <- function(c) {
  x <- length(c)
  if(x %% 2 != 0) { #modulo operator - division allowing for fractions/decimals
    #this is saying if x / 2 doesnt = 0 then do the function (essentially a positive number checker)
    x = x+1
  }
  for(i in 1:(x/2)) {
    c <- neutral_step(c)
  }
  return(c)
}

neutral_generation(community)

###############neutral time series###########
# function to run a neutral model time series without specation
neutral_time_series <- function(initial, duration) {
  ts <- c(0:duration) #setting length of time series
  ts[1] <- initial #setting initial (ts 1) to user defined initial conditions
  for(i in 0:duration){
    ts[i+1] <- species_richness(initial)
    initial <- neutral_generation(initial)
     
  }
  return(ts)
}
neutral_time_series(initial = initialise_max(7), duration = 20)

#########################question##############
# plotting a neutral model without speciation
question_8 <- function(){
  plot(neutral_time_series(initial = initialise_max(100), duration = 200), xlab= 'Generation', 
       ylab= 'Species richness', main= 'Time Series of species richness over generations')
}
question_8()



##################### neutral speciation#################
# function to run a neutral model for a single time step
neutral_step_speciation <- function(community, v) {
  RD <- choose_two(length(community))
  p <- runif(1, 0, 1) #uniform distribution generation
  if(p <= v) {
    community[RD[1]] = max(community)+1
  } else {
    community[RD[1]] = community[RD[2]]
  }
  return(community)
}
neutral_step_speciation(c(10,5,13), v = 1)


############neutral generation speciation##########
# function to run a neutral model for one generation
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

neutral_generation_speciation(c(10,13,3), v = 1)

#########neutral time series speciation############
# creating a function that runs a time series of a neutral model including speciation
neutral_time_series_speciation <- function(community, v, duration) {
  ts <- c(0:duration)
  for(i in 0:duration) {
    ts[i+1] <- species_richness(community)
    community <- neutral_generation_speciation(community, v)
    
  }
  return(ts)
}
J = seq(1:100)
neutral_time_series_speciation(community = J, v = 0.7, duration = 200)

##############question_12############
# plotting it for question 12
question_12<- function(){
  max = neutral_time_series_speciation(community = initialise_max(100), v = 0.1, duration = 200)
  min = neutral_time_series_speciation(community = initialise_min(100), v = 0.1, duration = 200)
  plot(max, xlab= 'Generation', ylab= 'Species richness', main = 'Neutral Simulation with Speciation', col = 'blue')
  points(min, col = 'red')
  }
question_12()

##########Species abundance#########
# calculating species abundance
species_abundance <- function(x) { 
  x <- table(x)
  x <- sort(x, decreasing = T)
  return(x)
}
species_abundance(c(1,5,3,6,5,6,1,1))

############octaves###########
# calculating octave bins
octaves <- function(x) {
  #print(x)
  bin <- tabulate(floor(log2(x)+1))
  return(bin)
  
}
octaves(c(100,64,63,5,4,3,2,2,1,1,1,1))

########sum_vect###########
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

sum_vect(c(1,3), c(1,0,5,2))

#########question 16 ##################################
# plotting octaves at equilibrium of 2000 generations, after a burn in of 200 generations
question_16 <- function() {
  SA <- seq(0,0)
  for(i in 1:200) {
    COM <- neutral_generation_speciation(community = initialise_max(100), v = 0.1)
  }
  SA <- c(SA, octaves(species_abundance(COM)))
  for(i in 1:2000) {
    COM <- neutral_generation_speciation(community = COM, v = 0.1)
    if( i %% 20 == 0) {
      SA1 <- octaves(species_abundance(COM)) 
      SA <- sum_vect(SA, SA1)
    }
    AVO <- (SA/101)
    #names(AVO) <- seq(log2()+1) to do later
  }
 barplot(AVO, xlab = 'Abundance bin (population size)', ylab = 'Number of Species', main = 'Average Species Abundance at equilibrium') 
}


question_16()
#############################################HPC code here##################################################################################
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
  Sp_Num <- rep(1, x)
  return(Sp_Num)
}
# initialise_min(10)

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
  COM = initialise_min(size) # community makeup
  SAO <- list() # species abundance octaves
  i <- 0 # octave number 
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
##############processing the output########################################
############################################## 
rm(list=ls())

############################################# loading the results back in ############################
# working directory has be the same place as the results files are kept for this script to work
# setwd("~/Documents/CMEECourseWork/HPC_week/Results")
files <- list.files(pattern = '*.rda') # loading in all the files in a batch, storing them in a list

###########Seperating the runs out by size###########################
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
for(results in list(size_500, size_1000, size_2500, size_5000)){
  sim_oct = c()
  for(i in results){
    load(i) #loads the data from the rda file
    sum_oct = c()
    burn_in_end = burn_in_generations / interval_oct + 2 #determining end point of burn in
    for(data in SAO[burn_in_end:length(SAO)]) {
      #pull out the octaves here
      sum_oct = sum_vect(sum_oct, data) #summing the octave vectors
    }
    avg_oct = unlist(lapply(sum_oct, function(n) n/(length(SAO) - burn_in_end))) #calculating the average octaves
    sim_oct = sum_vect(sim_oct, avg_oct) #making a vector of the averages for the simulation 
  }
  #average simulatin octaves 
  avg_SAO = unlist(lapply(sim_oct, function(n) n/length(results)))
  barplot(avg_SAO, xlab='Octaves (population size)', ylab='Number of Species', main=paste('Size =', size))
  #print(avg_SAO)
  #print(i)
}



##########################################################################################################################################
rm(list=ls())
graphics.off()
########################################here be fractals###################################################################################
################chaos game##########
# plotting a pretty fractal using randomized number picking
chaos_game <- function() {
  plot(1, type="n", xlab="", ylab="", xlim=c(0, 4), ylim=c(0, 4), xaxt='n', yaxt='n', bty="n")
  A = c(0,0)
  B = c(3,4)
  C = c(4,1)
  X = c(0,0)
  VL <- list((A),(B),(C))
  points(X[1],X[2], cex = 0.1)
  for(i in 1:100000) {
    RC <- sample(VL, 1)
    # move x half of the distance between x and RC towards RC
    XH <- X[1]
    XV <- X[2]
    H <- RC[[1]][1]
    V <-  RC[[1]][2]
    NH <- (H + XH)/2
    NV <- (V + XV)/2
    X <- c(NH, NV)
    points(X[1], X[2], cex = 0.1)
  }
}
chaos_game()

#############turtle######
# plotting a line using trig
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10))
# segments for drawing a line
turtle <- function(start_pos, direction, len) {
  x0 = start_pos[1]
  y0 = start_pos[2]
  # work out end point based on both direction and length using trig
  dx = (cos(direction)*len)
  dy = (sin(direction)*len)
  x1 = x0 + dx
  y1 = y0 + dy
  segments(x0, y0, x1 = x1, y1 = y1)
  EV <- c(x1, y1)
  return(EV)
  }
turtle(start_pos = c(4,6), direction = pi, len = 3)

##############elbow#####
#plotting two lines using trig
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10))
elbow <- function(start_pos, direction, len) {
  EV <- turtle(start_pos = start_pos, direction = direction, len = len)
  turtle(start_pos = EV, direction = (direction + (pi/4)), len = (len*0.95))
}
elbow(start_pos = c(4,6), direction = pi, len = 3)

#########################spiral####
# plotting a spiral using trig and recursive functions
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10),xaxt='n', yaxt='n', bty="n")
spiral <- function(start_pos, direction, len) {
  EV <- turtle(start_pos = start_pos, direction = direction, len = len)
  spiral(start_pos = EV, direction = (direction + (pi/4)), len = (len*0.95))
}
spiral(start_pos = c(5,7), direction = pi, len = 3)

######################## spiral_2 ######
# cleaning up sprial so that no error messages are produced
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10), xaxt='n', yaxt='n', bty="n")
spiral_2 <- function(start_pos, direction, len, e = 0.001) {
  if(len > e){
    EV <- turtle(start_pos = start_pos, direction = direction, len = len)
    spiral_2(start_pos = EV, direction = (direction + (pi/4)), len = (len*0.95), e = e) 
  }
}
spiral_2(start_pos = c(5,7), direction = pi, len = 3, e = 0.001)

######################### tree #######
# plotting a tree shape fractal using sprial_2 
plot(1, type="n", xlab="", ylab="", xlim=c(0, 12), ylim=c(0, 10), xaxt='n', yaxt='n', bty="n")
tree <- function(start_pos, direction, len, e = 0.001) {
  if(len > e){
    EV <- turtle(start_pos = start_pos, direction = direction, len = len)
    tree(start_pos = EV, direction = (direction + (pi/4)), len = (len*0.65), e = e)
    tree(start_pos = EV, direction = (direction + -(pi/4)), len = (len*0.65), e = e)
  }
}
tree(start_pos = c(6,0), direction = pi/2, len = 3, e = 0.001)


#################### Fern ################
# plotting a one sided fern using tree as base
plot(1, type="n", xlab="", ylab="", xlim=c(0, 50), ylim=c(0, 50))
fern <- function(start_pos, direction, len, e = 0.001) {
  if(len > e){ #setting bounds on how far it will run
    EV <- turtle(start_pos = start_pos, direction = direction, len = len)
    fern(start_pos = EV, direction = (direction + (pi/4)), len = (len*0.38), e = e)
    fern(start_pos = EV, direction = (direction), len = (len*0.87), e = e)
  }
}
fern(start_pos = c(6,0), direction = pi/2, len = 3, e = 0.001)

################### Fern_2 ####################
# plotting a fully fledged fern
plot(1, type="n", xlab="", ylab="", xlim=c(0, 14), ylim=c(0, 25), xaxt='n', yaxt='n', bty="n")
fern_2 <- function(start_pos, direction, len, e = 0.001, dir = 1) {
  left_dir = 1 #initilising left direction with an arbitrary value
  if(dir == 1){ #assigning direction dependent on input value
    left_dir = direction + (pi/4) 
  } else if(dir == -1){
    left_dir = direction - (pi/4)
  }
  dir = dir * -1 #iteratiely changing direction from positive to negative after each run through
  if(len > e){
    EV <- turtle(start_pos = start_pos, direction = direction, len = len) #setting bounds on how far it will run
    fern_2(start_pos = EV, direction = left_dir, len = (len*0.38), e = e, dir = -dir)
    fern_2(start_pos = EV, direction = (direction), len = (len*0.87), e = e, dir = dir)
  }
}
fern_2(start_pos = c(7,0), direction = pi/2, len = 3, e = 0.01, dir = 1)
                                                                                 



# q21 
# d= log(8) /log(3)
# 
# 3*3*3 
# 
# d= log(20) / log(3)
# x^d = y

                                                                                                                                                                                                                          