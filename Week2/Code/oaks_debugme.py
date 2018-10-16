#!/usr/bin/env python3
""" Debugging the oaks script using break points and doc testing """

__appname__ = 'oaks_debugme.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"
 
# Imports
import doctest
import csv
import sys
import fileinput


#Define function - doctests go here
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus'
    >>> is_an_oak("Quercus robur")
    True

    >>> is_an_oak("Fagus slyvatica")
    False

    testing to see if just genus gives a good result    
    >>> is_an_oak("Quercus")
    True
   
    >>> is_an_oak("Quercuss") # solve this using a length seven argument
    False

    >>> is_an_oak("QUERCUS")
    True

    >>> is_an_oak("quercusstart") # for strings longer than just quercus # should also be solved with a length argument
    False

    >>> is_an_oak(" quercus") 
    True

    >>> is_an_oak(1)
    False 
    
    """
    name = str(name).lower()
    name = name.lstrip()
    name = name.split(" ")[0]
    if len(name) !=7:
         return False
    return name.startswith("quercus")

    doctest.testmod()

def main(argv): 
    """ Opens the data sheet, and a results sheet
    makes a set containing the oaks in the dataset
    prints all results on a new line 
    prints FOUND AN OAK every time an oak is found 
    writes oaks found to the results data sheet"""
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    skip_header = next(taxa, None)   
    oaks = set()
    if skip_header:
            csvwrite.writerow(skip_header)
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print("FOUND AN OAK!\n")
            csvwrite.writerow([row[0], row[1]])  
        

    return 0



if (__name__ == "__main__"):
    status = main(sys.argv)