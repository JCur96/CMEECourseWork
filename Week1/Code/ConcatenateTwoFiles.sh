#!/bin/bash
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Desc: Script that takes two files and merges their content in one new file
# Arguments: 3, files in place of $1 $2 $3, with $3 being the destination file created by this script (but named at input)
# Date: Oct 2018
cat $1 > $3 # cat reads the contents of file $1, converts them to a standard output and places them in file $3. 
# file $3 is a file you name and create as part of the input for the script
cat $2 >> $3 # file $2 is read and output into file $3 
echo "Merged File is" # returns the contents of the merged file
cat $3
 
