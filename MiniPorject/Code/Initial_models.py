# !/usr/bin/env python3
""" Starting point of miniproject """

__appname__ = 'Initial_models.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


################################
#Imports
from numpy import sqrt, exp
import pandas as pd
import scipy
import matplotlib.pyplot as p
import sys
import csv
import lmfit
from lmfit import Model, Parameters, minimize
from lmfit.models import PolynomialModel
from scipy.optimize import curve_fit
#################################
# Reading data in
DF = pd.read_csv("Data/Updated_BioTraits.csv")
TestDF = pd.read_csv("Data/MTD2116.csv")

#Equations

## Phenomenological Models
### General Cubic Polynomial

def cubic(params, x, data): # params = parameter estimates, x = Temperature and data = OriginalTraitValue
    """Cubic polynomial function"""
    B0 = params['B0']
    B1 = params['B1']
    B2 = params['B2']
    B3 = params['B3']

    model = B0 + B1*x + B2*(x**2) + B3*(x**3)

    return model - data #return residuals

cubic_params = Parameters()
cubic_params.add('B0', value=0) #zero is fine as cubic polynomial will converge happily 
cubic_params.add('B1', value=0)
cubic_params.add('B2', value=0)
cubic_params.add('B3', value=0)

cubic_out = minimize(cubic, cubic_params, args=(TestDF.ConTemp, TestDF.OriginalTraitValue))
lmfit.printfuncs.report_fit(cubic_out.params, min_correl=0.5)

# plot to see what it did 
p.plot(TestDF.ConTemp, TestDF.OriginalTraitValue, 'bo')
p.plot(TestDF.ConTemp, cubic(cubic_out.params, TestDF.ConTemp, TestDF.OriginalTraitValue) + TestDF.OriginalTraitValue, 'r')
p.show()


# Briere model
def briere(params, T, data): # params = parameter estimates, x = Temperature and data = OriginalTraitValue
    """briere model function"""
    T0 = params['T0'] #min temp
    Tm = params['Tm'] #max temp 
    c = params['c'] #a constant
    

    model = c*T*(T-T0)*sqrt(abs(Tm-T))

    return model - data #return residuals

briere_params = Parameters()
briere_params.add('T0', value=0)
briere_params.add('Tm', value=45)
briere_params.add('c', value=0.1)

briere_out = minimize(briere, briere_params, args=(TestDF.ConTemp, TestDF.OriginalTraitValue))
lmfit.printfuncs.report_fit(briere_out.params, min_correl=0.5)

# the below can be used to pull out information of use
briere_out.aic
briere_out.bic
briere_out.chisqr

p.plot(TestDF.ConTemp, TestDF.OriginalTraitValue, 'bo')
p.plot(TestDF.ConTemp, cubic(cubic_out.params, TestDF.ConTemp, TestDF.OriginalTraitValue) + TestDF.OriginalTraitValue, 'r')
p.plot(TestDF.ConTemp, briere(briere_out.params, TestDF.ConTemp, TestDF.OriginalTraitValue) + TestDF.OriginalTraitValue, 'b')
p.show()