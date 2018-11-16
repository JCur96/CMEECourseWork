#!/usr/bin/env ipython3

""" Regex and web crawling/scarping in Python """

__appname__ = 'regexs.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

# Web scraping 
# Use scrapy for a fuller experience in web scraping, or beautiful soup 

# Imports 
import re
import urllib3

## Getting a webpage in a useable format
conn = urllib3.PoolManager() # open a connection
r = conn.request('GET', 'https://www.imperial.ac.uk/silwood-park/academic-staff/') 
webpage_html = r.data #read in the webpage's contents

type(webpage_html)
# decoding to utf8
My_Data  = webpage_html.decode()
print(My_Data)

# Extracting academics form this webpage using regex
pattern = r"Dr\s+\w+\s+\w+"
regex = re.compile(pattern) # example use of re.compile(); you can also ignore case  with re.IGNORECASE 
for match in regex.finditer(My_Data): # example use of re.finditer()
    print(match.group())

#Replacing text using regex
New_Data = re.sub(r'\t'," ", My_Data) # replace all tabs with a space
print(New_Data)