# !/usr/bin/env python3
""" Starting point of miniproject """

__appname__ = 'MPStart.py'
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

ConTemp = TestDF.ConTemp
ConTemp = ConTemp.astype(float)
ConTemp

# # Finishing off preparations for fitting by adding starting values column (maybe)
# # pull some random samples, give them upper and maybe lower bounds


# #Equations

## Phenomenological Model (also linear)
### General Cubic Polynomial
# turn these into functions

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



cubic_out_list = [] #preinitilisinig a blank list for cubic outputs
def cubic_fitting_all():

        for var in DF['FinalID'].unique():
        out_'paste the finalID here' = minimize(cubic, cubic_params, args=(DF.ConTemp, DF.OriginalTraitValue)) # perfrom cubic on all unique IDs,
        cubic_out_list.append(out_'') # add to a list of cubic_outs, ordered by unique ID


# will need to write something to get AIC scores
p.plot(TestDF.ConTemp, TestDF.OriginalTraitValue, 'bo')
p.plot(TestDF.ConTemp, cubic(cubic_out.params, TestDF.ConTemp, TestDF.OriginalTraitValue) + TestDF.OriginalTraitValue, 'r')
p.show() # this is encouraging


# ############# the below is quite likely much more on the mark than anything else so far########

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
briere_out.aic
briere_out.bic
briere_out.chisqr

p.plot(TestDF.ConTemp, TestDF.OriginalTraitValue, 'bo')
p.plot(TestDF.ConTemp, cubic(cubic_out.params, TestDF.ConTemp, TestDF.OriginalTraitValue) + TestDF.OriginalTraitValue, 'r')
p.plot(TestDF.ConTemp, briere(briere_out.params, TestDF.ConTemp, TestDF.OriginalTraitValue) + TestDF.OriginalTraitValue, 'b')
p.show()

##################################    

## Mechanistic model (non-linear)
#### simplified Schoolfield Model  params would be B0, Tl, Th, E, El, Eh. t is independent variable, e and k are constants 
B0*exp()**(-E/k)*((1/T) - (1/283.15)) / 1 +exp()**(Eh/k)*((1/Th) - (1/T)) # pretty sure this is corrected version of schoolfield


def Schoolfield(params, T, data): # params = parameter estimates, x = Temperature and data = OriginalTraitValue
    """Schoolfield model function"""
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
## non-linear modelling
#### non-linear least squares (got that semi complete in the R script he gave us)

###########shit that doesnt work but I still need to look at
# # this doesn't really work at all
# C_Model = Model(Cubic)
# C_Model.param_names
# C_Model.independent_vars
# C_params = C_Model.make_params(B0 =10 , B1 =45 , B2=1, B3=5)
# T = ConTemp
# y = C_Model.eval(C_params, T=T)
# result = C_Model.fit(y, C_params, T=T)
# print(result.fit_report())
# p.plot(T, y, 'bo')
# p.plot(T, result.init_fit, 'k--')
# p.plot(T, result.best_fit, 'r-')
# p.show()
# parameters inc. starting value for briere 
params.add('T', value =15 , min =0 , max=45 , vary = True) #contemp, ignore the code, T in the model will be T=ConTemp
params.add('T0', value =0 , vary = False) # minimum feasible temp 
params.add('Tm', value =45 , vary = False # maximum feasible temp
params.add('c', value =0.1 , vary = False) #a constant, can assign arbitrarily I think, later it would help to loop through and find a reasonable one