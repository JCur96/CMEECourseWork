#!/usr/bin/env python3
"""Some functions exemplifying control statements"""
__appname__ = 'cfexercises2.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## imports ## 
import sys

def foo1(x):
    return x ** 0.5

def foo2(x, y):
    if x > y:
        return x
    return y

def foo3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo5(x): # a recursive function
    if x == 1:
        return 1
    return x * foo5(x - 1)

def main(argv): # defines what main is (argv translates as variable)
    print(foo1(5)) # these statements are here to show that each function works
    print(foo2(1,2))
    print(foo3(2,7,4))
    print(foo4(11))
    print(foo5(10))
    return 0 # returns 0 on successful run after printing the above


if (__name__=="__main__"): 
    """Makes sure the "main" fuction is called from command line"""
    status = main(sys.argv) # makes the status equal to the system variable/argument
    sys.exit # explicitly exits to the system

