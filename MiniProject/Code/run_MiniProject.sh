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
python3 -W ignore SF_start_params.py ../Data/Updated_BioTraits.csv
echo "Done!"
echo "Cleaning up"
Rscript TidyData.R
echo "Done!"
printf "Commencing Model Fitting...\nFitting Cubic\n"
python3 -W ignore cubic.py ../Data/Updated_BioTraits.csv
printf "Done!\nFitting Briere\n"
python3 -W ignore briere.py ../Data/Updated_BioTraits.csv
printf "Done!\nFitting Schoolfield\n"
python3 -W ignore schoolfield.py ../Data/Biotraits_start_no_na.csv
echo "Done! All models fitted"
echo "Commencing Plotting..."
Rscript Plotting.R
echo "Plotting complete!"
echo "Writing up"
yes '' | pdflatex MiniProject.tex > NUL 2>&1
yes '' | bibtex MiniProject > NUL 2>&1
yes '' | pdflatex MiniProject.tex > NUL 2>&1
yes '' | pdflatex MiniProject.tex > NUL 2>&1
mv MiniProject.pdf ../Results/
echo "Written"
echo "Tidying up..."
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
rm *.bbl
rm *.blg
rm NUL
echo "All done! Have a nice day"
