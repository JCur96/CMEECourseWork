#!/usr/bin/env Rscript 
# break.R 
# Showing how to break out of loops 

i <- 0 # initialize i 
  while (i < Inf) {
    if (i == 20) {
      break }
    else {
      cat("i equals", i, "\n")
      i <- i + 1 # Update i
    }
  }