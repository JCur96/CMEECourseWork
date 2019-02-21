# !/usr/bin/env python3
""" Starting point of miniproject """

__appname__ = 'Initial_models.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


################################
#Imports
import numpy as np
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
IDList = DF.FinalID.unique() # producing a list of unique IDs for a for loop to work from
Cubic_testDF = pd.DataFrame(data = None) # making an empty data frame to store the results of cubic fitting to
Briere_testDF = pd.DataFrame(data = None)
Schoolfield_testDF = pd.DataFrame(data = None)
# Equations
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



# this is essentially Davids so I can't use it
def cubic_start(ID, DF):
    """making a dictionary containing ConTemp, OriginalTraitValue and parameter 
    starting values for fitting cubic model"""
    
    # cubic_params = ['UniqueID', 'Temp', 'TV', 'B0', 'B1', 'B2', 'B3'] # list of parameter names
    # # gotta work out how to assign these values 
    # cubic_params['UniqueID'] = ID.astype(int)
    # cubic_params['Temp'] = np.asarray(DF.ConTemp[DF.FinalID == ID])
    # cubic_params['Temp'] = np.asarray(DF.OriginalTraitValue[DF.FinalID == ID])
    # cubic_params['B0'] = 0.
    # cubic_params['B1'] = 0.
    # cubic_params['B2'] = 0.
    # cubic_params['B3'] = 0.
    
    cubic_params = {'UniqueID' : ID,
                      'Temp'   : np.asarray(DF.ConTemp[DF.FinalID == ID]),
                      'TV'     : np.asarray(DF.OriginalTraitValue[DF.FinalID == ID]),
                      'B0'     : 0.,
                      'B1'     : 0.,
                      'B2'     : 0.,
                      'B3'     : 0.} #zero is fine as cubic polynomial will converge happily

    return cubic_params





# as is this
def cubic_model_fitting(ID, DF):
    """fits the cubic to all the data grouped by unique ID, saves the output to a new data frame"""

    init_vals = {'UniqueID' : ID,
            'Temp' : np.asarray(DF.ConTemp[DF.FinalID == ID]),
            'TV' : np.asarray(DF.OriginalTraitValue[DF.FinalID == ID]),
            'B0'     : 0.,
            'B1'     : 0.,
            'B2'     : 0.,
            'B3'     : 0.}
            
    # init_vals = cubic_start(ID, DF)

    x = init_vals["Temp"] 
    y = init_vals["TV"]
    
    cubic_params = Parameters()
    cubic_params.add('B0', value = init_vals["B0"]) #zero is fine as cubic polynomial will converge happily 
    cubic_params.add('B1', value = init_vals["B1"])
    cubic_params.add('B2', value = init_vals["B2"])
    cubic_params.add('B3', value = init_vals["B3"])
    
    Cubic_Output = {'UniqueID'  : init_vals["UniqueID"],
            'B0'      : init_vals["B0"],
            'B1'      : init_vals["B1"],
            'B2'      : init_vals["B2"],
            'B3'      : init_vals["B3"],
            'chisqr'  : [np.NaN],        
            'AIC'     : [np.NaN],  
            'BIC'     : [np.NaN]}
    
    
    cubic_out = minimize(cubic, cubic_params, args=(x, y))
    

    Cubic_Output = pd.DataFrame({'UniqueID'  : ID,
            'B0'      : [cubic_out.params["B0"].value],
            'B1'      : [cubic_out.params["B1"].value],
            'B2'      : [cubic_out.params["B2"].value],
            'B3'      : [cubic_out.params["B3"].value],
            'chisqr'  : [cubic_out.chisqr],        
            'AIC'     : [cubic_out.aic],  
            'BIC'     : [cubic_out.bic]})


    return Cubic_Output

print(IDList.astype(int))

for i in IDList:
    try:
        Cubic_testDF = Cubic_testDF.append(cubic_model_fitting(i, DF))
    except ValueError:
        print('something is not quite right')

Cubic_testDF

# Briere model
def briere(params, T, data): # params = parameter estimates, x = Temperature and data = OriginalTraitValue
    """briere model function"""
    T0 = params['T0'] #min temp
    Tm = params['Tm'] #max temp 
    c = params['c'] #a constant
    

    model = c*T*(T-T0)*sqrt(abs(Tm-T))

    return model - data #return residuals


def briere_model_fitting(ID, DF):
    """fits the cubic to all the data grouped by unique ID, saves the output to a new data frame"""

    init_vals = {'UniqueID' : ID,
            'Temp' : np.asarray(DF.ConTemp[DF.FinalID == ID]),
            'TV' : np.asarray(DF.OriginalTraitValue[DF.FinalID == ID]),
            'T0'     : 0.,
            'Tm'     : 45.,
            'c'     : 0.1}
            
    # init_vals = cubic_start(ID, DF)

    x = init_vals["Temp"] 
    y = init_vals["TV"]
    
    briere_params = Parameters()
    briere_params.add('T0', value = init_vals["T0"], min=min(DF.ConTemp)-50) #set some bounds so things remain sensible
    briere_params.add('Tm', value = init_vals["Tm"], max=max(DF.ConTemp)+50)
    briere_params.add('c', value = init_vals["c"])
    
    
    Briere_Output = {'UniqueID'  : init_vals["UniqueID"],
            'B0'      : init_vals["T0"],
            'B1'      : init_vals["Tm"],
            'B2'      : init_vals["c"],
            'chisqr'  : [np.NaN],        
            'AIC'     : [np.NaN],  
            'BIC'     : [np.NaN]}
    
    
    briere_out = minimize(briere, briere_params, args=(x, y))
    

    Briere_Output = pd.DataFrame({'UniqueID'  : ID,
            'B0'      : [briere_out.params["T0"].value],
            'B1'      : [briere_out.params["Tm"].value],
            'B2'      : [briere_out.params["c"].value],
            'chisqr'  : [briere_out.chisqr],        
            'AIC'     : [briere_out.aic],  
            'BIC'     : [briere_out.bic]})


    return Briere_Output


for i in IDList:
    try:
        Briere_testDF = Briere_testDF.append(cubic_model_fitting(i, DF))
    except ValueError:
        print('ValueError encountered')


for i in IDList:
    try:
        Cubic_testDF = Cubic_testDF.append(cubic_model_fitting(i, DF))
    except ValueError:
        print('something is not quite right')
    try:
        Briere_testDF = Briere_testDF.append(cubic_model_fitting(i, DF))
    except ValueError:
        print('ValueError encountered')



Out_data = pd.DataFrame(data = None, columns=)



def Schoolfield(params, T, trait): # params = parameter estimates, x = Temperature and data = OriginalTraitValue
    """Schoolfield model function"""
    B0 = params['B0']
    E = params['E']
    Eh = params['Eh']
    Th = params['Th']

    model = B0*exp()**(-E/k)*((1/T) - (1/283.15)) / 1 +exp()**(Eh/k)*((1/Th) - (1/T))

    return model - data #return residuals






