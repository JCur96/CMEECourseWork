#!/usr/bin/env python3
""" Printing elements of a tuple on new lines and removing the brackets to make it look prettier """

__appname__ = 'tuple.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )


# i is a placeholder for all elements in birds, for makes a loop that goes through 
# all elements, print displays all elements found in birds, each tuple is displayed on 
# a new line. .format allows for the removal of the brackets, making it a little 
# prettier

for i in birds:
    print("{} {} {}".format (i[0], i[1], i[2]), "-".) 

