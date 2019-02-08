#!/usr/bin/env python3
""" Using list comprehension and traditional loops to make lists from a nested tuple"""
__appname__ = 'lc1.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

        
#(1) Using list comprehension to create three seperate lists, of Latin name, common name and body mass respectively
latin_name_lc = list ([i[0] for i in birds])   # The function list tells python that we are creating a list from the enclosed command
# which say for every element of this nested tuple, use the first (zero) tuple to create
# the new list.
print("\nLatin Names:")
print(latin_name_lc) # Print jsut shows whats in the list. Each new block is for a different list 
# with [] being used to select which element of the nested tuple to use to create the list

common_name_lc = list ([i[1] for i in birds])
print("\nCommon Names:")
print(common_name_lc)

weight_lc = list ([i[2] for i in birds])
print("\nMean body masses:")
print(weight_lc)

# (2) Using loops to create three seperate lists
latin_name_loop = list() # list is a function used to create lists. 
for i in birds:
    latin_name_loop.append(i[0]) # The loop goes through the tuple, birds, finding the 
print("\nLatin Names:")
# specified element (first[0], second[1] or third[2] 
# # depending on which new list is being created) and .appends (adds) it to the new list. 
print(latin_name_loop) # Once this is done print displays the content of each list.


common_name_loop = list()
for i in birds:
    common_name_loop.append(i[1])
print("\nCommon Names:")
print(common_name_loop)

weight_loop = list()
for i in birds:
    weight_loop.append(i[2])
print("\nMean body masses:")
print(weight_loop)


