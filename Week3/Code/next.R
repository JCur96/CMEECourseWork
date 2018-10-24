#!/usr/bin/env Rscript 
# next.R
# Showing use of the next statement in within a loop 
# next allows skipping to the next iteration 

for (i in 1:10){
  if((i %% 2) == 0)
    next # pass to the next iteration of the loop
  print(i)
}