#!/bin/bash
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: txttocsv.sh
# Desc: substitute the spaces in a file for commas
# saves the output to a .csv file
# Arguments: 1-> txt delimited file
# Date: Oct 2018


echo "Checking file encoding"
file -i $1
echo "Changing encoding to UTF8 and file type to .csv"
nn="../Data/$(basename "$1" .txt)_UTF8.csv"
iconv -f UTF-16LE -t UTF-8 $1 -o $nn

echo "Done!"
exit