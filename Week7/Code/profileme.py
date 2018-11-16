# !/usr/bin/env ipython3
""" Exemplifying profiling in python """

__appname__ = 'profileme.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"



def my_squares(iters):
    """Squaring iters and appending to out"""
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """Making a string of length iters"""
    out = ''
    for i in range(iters):
        out += string.join(", ") # += would be the same as out = out + some_object
    return out

def run_my_funcs(x,y):
    """Runs the functions allowing inputs"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")