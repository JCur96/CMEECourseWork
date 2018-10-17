#!/usr/bin/env python3
"""Some functions exemplifying control statements"""
__appname__ = 'cfexercises1.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

for i in range(3, 17):
    print('hello')

for j in range(12):
    if j % 3 == 0:
        print('hello')

for j in range(15):
     if j % 5 == 3:
        print('hello')
     elif j % 4 == 3:
        print('hello')

z = 0
while z != 15:
    print('hello')
    z = z + 3

z = 12
while z < 100:
    if z == 31:
        for k in range(7):
            print('hello')
    elif z == 18:
        print('hello')
    z = z + 1

