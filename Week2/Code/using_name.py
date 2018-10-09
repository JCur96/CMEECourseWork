#!/usr/bin/env python3 
""" Can be run as a self standing program or imported from another module """
__appname__ = 'using_name.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk'
__version__ = '0.0.1'
__license__ = 'license for this software would go here'

# Filename: using_name.py
if __name__ == '__main__':
    print('This program is being run by itself')
else:
    print('I am being imported from another module')