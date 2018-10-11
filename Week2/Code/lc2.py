#!/usr/bin/env python3
""" Using list comprehension to create lists of tuples """

__appname__ = 'lc2.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"


# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.

# list comprehension to create a list of month names and rainfall data where the amount of rain 
# was more than 100mm. List function tells python to create a kind of list, i, is a place-
# holder for all the variables in this original tuple, with [0] defining the first
# variable in the tuple. 
# for loops through all the 
# variables, the if statement determines which tuples are of interest for the 
# new list (in this case those where the second part of the tuple is less than 50)
# print displays the new set

mrethn100 = list ([i for i in rainfall if i[1]>100])
print(mrethn100)

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

# list comprehension to create a list of just month names where the amount of rain 
# was less than 50mm. List function tells python to create a kind of list, i, is a place-
# holder for all the variables in this original tuple, with [0] defining the first
# variable in the tuple. 
# for loops through all the 
# variables, the if statement determines which tuples are of interest for the 
# new list (in this case those where the second part of the tuple is less than 50)
# print displays the new set

lssthn50 = list ([i[0] for i in rainfall if i[1]<50 ])
print(lssthn50)
 
# (3) The same as above, just done using for loops. 
# The major differnce between the two methods is the required addition 
# of the .append statement, which tells the loop to add elements which meet
# the requirements of the if statement to the newly created list. 
# mathematical notation (i.e. >, <, works in python for rule creation as part of the if statement)

mt1_loop = set()
for i in rainfall:
    if i[1]>100:
        mt1_loop.append(i)
print(mt1_loop)



lt50_loop = set ()
for i in rainfall:
    if i[1]<50:
        lt50_loop.append(i[0])
print(lt50_loop)
 
