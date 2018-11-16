# !/usr/bin/env ipython3
""" Exemplifying Post-Profiled code in Python
i.e. optimized version of profileme.py """

__appname__ = 'profileme2.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


def my_squares(iters):
    """ Using list comprehension instead of for loops to square iters and add to out"""
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """ Using inbuilt concatentate instead of join to make a string of length iters"""
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """ running both functions with inputs"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")