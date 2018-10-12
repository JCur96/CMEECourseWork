#!/usr/bin/env python3
""" Making a dictionary from a list """

__appname__ = 'dictionary.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa. 
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc. 

# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING! 

# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT 
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS

# Write your script here:


taxa_dict = {key: value for (value, key) in taxa} ## Using list (dictionary) comprehension to make a dictionary, 
# where species (values) are mapped to orders (keys)
print(taxa_dict)

from collections import defaultdict ## importing the subclass defaultdict from the collections module, which
# provides an alternative to dict, allowing for lists to be turned into dictionaries directly
taxa_dic = defaultdict(list)
for v, k in taxa: # v and k are stand ins for values and keys respectively
    taxa_dic[k].append(v) # adds values to the keys the correspond to, prevents deletion of duplicate key:value pairs, 
    # as it appends the value of a duplicate key to the already existing key
print(taxa_dic) # prints the dictionary, allowing verification that this has worked