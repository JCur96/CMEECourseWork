# # !/usr/bin/env Rscript
# jcurry.R
# Jake Curry (j.curry18@imperial.ac.uk)
# Nov 2018
# HPC week in R 
############################################## 
rm(list=ls())
graphics.off()
# Creating the data
community <- as.vector(c(1,4,4,5,1,6,1))
size <- 7
# Function for species richness 
species_richness <- function(x) {
  sp_num <- unique(x)
  richness <- length(sp_num)
  return(richness)
}
species_richness(communtiy)

# generating the initial state of the simulation
initialise_max <- function(x) {
  ComSize <- as.vector(seq(from = 1, to = x, by = 1))
  return(ComSize)
}
initialise_max(size)

# generating alternate monodominace intial condition
initialise_min <- function(x) {
  Sp_Num <- as.vector(rep_len(1, x))
  return(Sp_Num)
}
initialise_min(4)

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

# writing a single step of a simple neutral model
neutral_step <- function(x) {
  RD <- choose_two(length(x))
  x[RD[1]] = x[RD[2]]
  return(x)
}

community<-c(10,5,13)

neutral_step(community)

# function to simulate a generation passing in the community 
neutral_generation <- function(c) {
  x <- length(c)
  if(x %% 2 != 0) {
    x = x+1
  }
  for(i in 1:(x/2)) {
    c <- neutral_step(c)
  }
  return(c)
}

neutral_generation(community)


neutral_time_series <- function(initial, duration) {
  ts <- c(0:duration)
  ts[1] <- initial
  for(i in 0:duration){
    ts[i+1] <- species_richness(initial)
    initial <- neutral_generation(initial)
     
  }
  return(ts)
}
neutral_time_series(initial = initialise_max(7), duration = 20)

# plotting it for question 8
plot(neutral_time_series(initial = initialise_max(100), duration = 200), xlab= 'Generation', ylab= 'Species richness')




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
neutral_step_speciation(c(10,5,13), v = 1)


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

neutral_generation_speciation(c(10,13,3), v = 1)

# neutral time series speciation
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

# plotting it for question 12
plot(neutral_time_series_speciation(community = J, v = 0.1, duration = 200), xlab= 'Generation', ylab= 'Species richness', main = 'Neutral Simulation with Speciation')


# Species abundance
species_abundance <- function(x) { 
  x <- table(x)
  x <- sort(x, decreasing = T)
  return(x)
}
species_abundance(c(1,5,3,6,5,6,1,1))

# octaves
octaves <- function(x) {
  #print(x)
  bin <- tabulate(floor(log2(x)+1))
  return(bin)
  
}
octaves(c(100,64,63,5,4,3,2,2,1,1,1,1))

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

# question 16
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
 barplot(AVO, xlab = 'abundance bin', ylab = '# of species', main = 'average spp abundance by octave at equilibrium') 
}


question_16()

###########################################################################################################################
# Fractals
chaos_game <- function() {
  plot(1, type="n", xlab="", ylab="", xlim=c(0, 4), ylim=c(0, 4))
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

#############
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

##############
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10))
elbow <- function(start_pos, direction, len) {
  EV <- turtle(start_pos = start_pos, direction = direction, len = len)
  turtle(start_pos = EV, direction = (direction + (pi/4)), len = (len*0.95))
}
elbow(start_pos = c(4,6), direction = pi, len = 3)

#########################
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10))
spiral <- function(start_pos, direction, len) {
  EV <- turtle(start_pos = start_pos, direction = direction, len = len)
  spiral(start_pos = EV, direction = (direction + (pi/4)), len = (len*0.95))
}
spiral(start_pos = c(4,6), direction = pi, len = 3)

########################
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10))
spiral_2 <- function(start_pos, direction, len, e = 0.001) {
  if(len > e){
    EV <- turtle(start_pos = start_pos, direction = direction, len = len)
    spiral_2(start_pos = EV, direction = (direction + (pi/4)), len = (len*0.95), e = e) 
  }
}
spiral_2(start_pos = c(4,6), direction = pi, len = 3, e = 0.001)

#########################
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10))
tree <- function(start_pos, direction, len, e = 0.001) {
  if(len > e){
    EV <- turtle(start_pos = start_pos, direction = direction, len = len)
    tree(start_pos = EV, direction = (direction + (pi/4)), len = (len*0.65), e = e)
    tree(start_pos = EV, direction = (direction + -(pi/4)), len = (len*0.65), e = e)
  }
}
tree(start_pos = c(6,0), direction = pi/2, len = 3, e = 0.001)
