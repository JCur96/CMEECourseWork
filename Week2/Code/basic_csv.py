# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: basic_csv.py
# Desc: python script for opening and reading a csv file containing species and body mass data, 
# and subsequently creating a file containing only species name and body mass
# Arguments: 2 -> f and g, files that contain the data
# Date: Oct 2018
import csv # importing a module for use in this script - much like packages in R
# Read a file containing: 
# 'Species', 'Infraorder', 'Family', 'Distribution', 'Body mass (Kg)' 
f = open('../Data/testcsv.csv', 'r')

csvread = csv.reader(f)
temp = []
for row in csvread:
    temp.append(tuple(row))
    print(row)
    print("The species is", row[0])
f.close()

# Write a file containing only species name and Body mass
f = open('../Data/testcsv.csv', 'r')
g = open('../Data/bodymass.csv', 'w')

csvread = csv.reader(f)
csvwrite = csv.writer(g)
for row in csvread:
    print(row)
    csvwrite.writerow([row[0], row[4]])

f.close()
g.close()
