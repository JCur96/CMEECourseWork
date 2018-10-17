#!/usr/bin/env python3
""" Creates a program with a bug, then lets you debug it!"""

__appname__ = 'debugme.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"



def createabug(x):
    y = x**4
    z = 0.1
    y = y/z
    return y

createabug(25)