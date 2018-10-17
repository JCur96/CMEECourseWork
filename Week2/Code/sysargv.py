#!/usr/bin/env python3
""" Demonstrates system argument """

__appname__ = 'sysargv.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

import sys
print('This is the name of the script', sys.argv[0])
print('Number of arguments: ', len(sys.argv))
print('The arguments are: ', str(sys.argv))