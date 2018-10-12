#!/usr/bin/env python3
"""Some functions exemplifying control statements"""
__appname__ = 'cfexercises2.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## imports ## 
import sys

def foo1(x):
    return x ** 0.5 # give the input to the power of 0.05

def foo2(x, y):
    if x > y:
        return x
    return y # returns the greater of the inputs

def foo3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]   # returns the input in order of lowest to highest

def foo4(x): # calculates factorial iteratively
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result # runs through the range multipying result by each number in the range

def foo5(x): # a recursive function - calls itself until it hits 1
    if x == 1:
        return 1
    return x * foo5(x - 1) # input times by this function but for input minus one until it hits one

def foo6(x): # Calculate the factorial of x in a different way
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv): # defines what main is (argv translates as variable)
    print(foo1(5)) # these statements are here to show that each function works
    print(foo2(1,2))
    print(foo3(2,7,4))
    print(foo4(11))
    print(foo5(10))
    print(foo6(5))
    return 0 # returns 0 on successful run after printing the above


if (__name__=="__main__"): 
    """Makes sure the "main" fuction is called from command line"""
    status = main(sys.argv) # makes the status equal to the system variable/argument
    sys.exit # explicitly exits to the system

