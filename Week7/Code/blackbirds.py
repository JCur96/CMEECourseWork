# !/usr/bin/env ipython3
""" Completing this script using Regular Expression """

__appname__ = 'blackbirds.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


# Imports
import re

# Read the file (using a different, more python 3 way, just for fun!)
with open('../Data/blackbirds.txt', 'r') as f:
    text = f.read()

# replace \t's and \n's with a spaces:
text = text.replace('\t',' ')
text = text.replace('\n',' ')
# You may want to make other changes to the text. 

# In particular, note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform to ASCII:

text = text.encode('ascii', 'ignore') # first encode into ascii bytes
text = text.decode('ascii', 'ignore') # Now decode back to string

# Now extend this script so that it captures the Kingdom, Phylum and Species
# name for each species and prints it out to screen neatly.


# # Three seperate line solutions
# re.findall(r"Kingdom\s\w+\s", text)
# re.findall(r"Phylum\s\w+\s", text)
# re.findall(r"Species\s\w+\s\w+", text)

# Single line solution, though I feel this could be made better
match = re.findall(r"Kingdom\s(\w+)\s.+?Phylum\s(\w+)\s.+?Species(\s\w+\s\w+)", text)
print(match)

header = ("Kingdom\tPhylum\tSpecies\n")

print(header + "\n".join([", ".join(i) for i in match]))
# Hint: you may want to use re.findall(my_reg, text)... Keep in mind that there
# are multiple ways to skin this cat! Your solution could involve multiple
# regular expression calls (easier!), or a single one (harder!)