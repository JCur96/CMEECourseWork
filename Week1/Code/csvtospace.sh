#!/bin/bash
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: csvtospace.sh 
# Desc: substitue the commas in a file for spaces 
# Saves the output to a .txt file
# Arguments: 1-> space delimited file
# Date: Oct 2018
echo "Creating a space delimited version of $1..." 
cat $1 | tr -s "," " " >>$1.txt | mv $1.txt ../Results/ #cat function reads file $1, mv, moving the product to the results dir
# tr translates the specified characters,
# -s specifies replacement >>$1.txt sends the 
# output to a .txt file version of file $1 
echo "Done!" 
exit

