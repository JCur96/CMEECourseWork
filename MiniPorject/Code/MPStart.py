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
# turn these into functions
  
def Cubic(B0, B1, B2, B3, T):
    """Cubic polynomial function""" 
    B0 + (B1)*T + (B2)*T^2 + (B3)*T^3
    return

def briere(T, T0, Tm, B):
    """briere model"""
    B*T*(T-T0)*(abs(Tm-T)^(1/2))*(T<Tm)*(T>T0)
    return


## Mechanistic model (non-linear)
#### Schoolfield Model 
def Schoolfield(B0, e, E, k, T, EI, TI, Eh, Th, I):
    """Schoolfield model"""
    ((B0^e)^(-E/k)*((1/T) - (1/283.15))) / (1 + e^(EI/k) * ((I/TI) - (1/T))) + (e^(Eh/k)((I/Th) - (I/T)))
    return

## non-linear modelling
#### non-linear least squares (got that semi complete in the R script he gave us)
