#!/usr/bin/env python3
"""A basic boilerplate program for python! Prints the statement 'This is a boilerplate'
    after importing the sys module, and closes the program once its done"""
__appname__ = 'boilerplate.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## imports ##
import sys # module to interface our program with the operating system

## constants ## 

## functions ## 
def main(argv): 
    """Main entry point of the program """
    print('This is a boilerplate') #NOTE: indented using two tabs of 4 spaces
    return 0
    sys.exit("I am exiting right now")
if __name__=="__main__": 
    """Makes sure the "main" fuction is called from command line"""
    status = main(sys.argv)
    sys.exit(status)
