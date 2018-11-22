# !/usr/bin/env python3
""" Starting point of miniproject """

__appname__ = 'MPStart.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


################################
#Imports
import scipy
import matplotlib
import sys
import csv

#################################
#Equations

## Phenomenological Model (also linear)
### General Cubic Polynomial

B = B_[0] + (B_[1])*T + (B_[2])*T^2 + (B_[3])*T^3



## Mechanistic model (non-linear)
#### Schoolfield Model 

B = ((B_[0]^e)^(-E/k)*((1/T) - (1/283.15))) / (1 + e^(E_I/k) * ((I/T_I) - (1/T))) + (e^(E_h/k)((I/T_h) - (I/T)))