#!/usr/bin/env Rscript 
# Ricker.R
# Runs a simulation of the Ricker model
# Returns a vector of length generations
Ricker <- function(N0=1, r=1, K=10, generations=50)
{
  
  N <- rep(NA, generations)    # Creates a vector of NA
  
  N[1] <- N0
  for (t in 2:generations)
  {
    N[t] <- N[t-1] * exp(r*(1.0-(N[t-1]/K)))
  }
  return (N)
}

plot(Ricker(generations=10), type="l")