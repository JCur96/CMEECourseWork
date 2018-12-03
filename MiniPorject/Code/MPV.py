# !/usr/bin/env ipython3
""" MiniProject initial opening of data and visualization """

__appname__ = 'MVP.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

#Imports
import pandas as pd 
import scipy as sc
import matplotlib.pyplot as p 

#### Reading the data in
print('Reading in the data, Please wait...')
DF = pd.read_csv('../Data/BioTraits.csv', sep = ',')
print('Done!')
DF.head()

DF1 = DF[['OriginalTraitValue', 'ConTemp', 'FinalID']]
DF1.head()

p.plot(['OriginalTraitValue'],['ConTemp'],['FinalID'])
p.show()
#### Subsetting the data

