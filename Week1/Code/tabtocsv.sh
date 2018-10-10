#!/bin/bash
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: tabtocsv.sh
# Desc: substitute the tabs in a file for commas
# saves the output to a .csv file
# Arguments: 1-> tab delimited file
# Date: Oct 2018
echo "Creating a comma delimited version of $1..."
cat $1 | tr -s "\t" "," >> $1.csv | mv $1.csv ../Results/ # tr -s translates characters, specifying replacement, mv, moving the product to the results dir
echo "Done!"
exit

