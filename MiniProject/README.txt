CMEE Mini-Project Readme

Candidate Problem: Model fitting of Thermal Performance Curves 

Languages used
Python -- version: 3.6.7
R -- version:  3.4.4 (2018-03-15)
Bash -- version: 4.4.19(1)-release)

Packages used:
Python:
argparse -- Used to allow command line arguments
lmfit -- Used for model fitting
logging -- Used to log error events (especially at the debug stage)
numpy -- Used for easy math operations
os -- Used to provide a default pathway for reading in files
pandas -- Used for creation of DataFrame objects for easy importation into R
csv -- Used for writing out final .csv's
scipy -- Boltzmann constant taken from here
statistics -- Used in gradient calculations (linregress)

R:
dplyr -- Used in data handling (pipes are useful)
ggplot2 -- Used for end plotting

Directories:
Code:
briere.py -- fits briere model
ComplieLaTex.sh -- compiles the LaTex document
cubic.py -- fits the cubic model
DataWrang.R -- wrangles the initial raw data
Plotting.R -- plots the final data
run_MiniProject.sh -- ties the entire workflow together
schoolfield.py -- fits the schoolfield model
SF_start_params.py -- calculates the starting values for all parameters of schoolfield
TidyData.R -- tidies up output from SF_Start_Params for Schoolfield fitting
LATEX DOC -- report writting in latex awaiting compliation
BIBTEX DOC -- references for latex document

Data:
BioTraits.csv -- raw data file for the BioTraits data

Results:
Figure_Graphic -- folder for the graphic used in the latex figure
TPC_Graphs -- folder for all graphics generated


