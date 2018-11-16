# !/usr/bin/env ipython3
""" Exemplifying profiling of a portion of a program in python """

__appname__ = 'timeitme.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

#################################################
# loops vs list comprehension; which is faster? #
#################################################

#Imports 
import timeit
from profileme import my_squares as my_squares_loops
from profileme2 import my_squares as my_squares_lc
from profileme import my_join as my_join_join
from profileme2 import my_join as my_join
import time

#Running it
iters = 1000000

# %timeit my_squares_loops(iters) # commented out for commit as would break marking script
# %timeit my_squares_lc(iters)

###########################################################
# loops vs. the join method for strings: which is faster? #
###########################################################

mystring = "my string"

# %timeit(my_join_join(iters, mystring))
# %timeit(my_join(iters, mystring))


#############################################
# A simpler way to time individual commands #
#############################################

start = time.time()
my_squares_loops(iters)
print("my_squares_loops takes %f s to run." % (time.time() - start))

start = time.time()
my_squares_lc(iters)
print("my_squares_lc takes %f s to run." % (time.time() - start))