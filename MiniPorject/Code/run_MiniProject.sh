#!/bin/bash
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: runminiproject.sh
# Desc: Script that runs the CMEE miniproject from within the Code direcroty!
# Date: March 2019

echo "Running Mini-Project, Here goes!"
echo "Wrangling Data, please hold..."
Rscript DataWrang.R 
echo "Done!"
echo "Calculating Starting Parameters, please hold..."
Python3 SF_start_params.py ../Data/Updated_BioTraits.csv
echo "Done!"
echo "Cleaning up"
Rscript TidyData.R
echo "Done!"
printf "Commencing Model Fitting...\nFitting Cubic\n"
python3 cubic.py ../Data/Updated_BioTraits.csv
printf "Done!\nFitting Briere\n"
python3 briere.py ../DataUpdated_BioTtraits.csv
printf "Done!\nFitting Schoolfield\n"
python3 schoolfield.py ../Data/Biotraits_start_no_na.csv
echo "Done! All models fitted"
echo "Commencing Plotting..."
Rscript Plotting.R
echo "Plotting complete!"
echo "Writing up"
#CompileLaTex.sh TEX CODE HERE 
echo "Written"
echo "Tidying up..."
echo "All done! Have a nice day"
