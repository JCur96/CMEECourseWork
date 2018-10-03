#!/bin/bash
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: CountLines.sh 
# Desc: Counts the number of lines in a specified file
# Arguments: 1, $1 is a file which must be specified at input
# Date: Oct 2018
NumLines=`wc -l < $1` # -l specifies that lines will be counted by the function wc
echo "The file $1 has $NumLines lines" # $NumLines is a placeholder for the actual number of lines counted by the script
echo
