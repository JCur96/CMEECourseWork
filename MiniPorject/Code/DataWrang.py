# !/usr/bin/env ipython3
""" MiniProject initial opening of data and visualization """

__appname__ = 'DataWrang.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

#Imports
import pandas as pd 
import csv

DF = pd.read_csv("Data/BioTraits.csv") # reads data sheet in
DF = DF[["OriginalTraitValue", "OriginalTraitUnit", "ConTemp", "FinalID", "StandardisedTraitName", "StandardisedTraitValue", "StandardisedTraitUnit"]] #subsets to just what we want
DF.head #checks to make sure it actaully did what expected
DF = DF.dropna(0, subset=['OriginalTraitValue']) # removes rows containing NA's but looking for NA's in only Original trait value
DF = DF[DF['OriginalTraitValue'] > 0] # deals with zero and negative values by removing them
DF = DF.groupby(by='FinalID') # groups by FinalID (unique ID's)
DF = DF.filter(lambda x:len(x) >5) # filters to have only groups containing more than 5 data points

DF.to_csv('Data/UpdataedBioTraits.csv', index=False) # saves the wrangled data to a new csv file 
