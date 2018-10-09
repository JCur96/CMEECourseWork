# Week 1 readme
# Date: 1-7th Oct 2018
# This directory contains content on the basics of bash commands, scripting 
# use of LaTeX and git
# Week 1 is made up of four directories, Code, Data, Output and Sandbox
# Code contains scripts and bash code, 
# Data is raw data that is used by the scripts and 
# Sandbox contains test files for playing around in the terminal. 
# 
# Scripts + their functions: 
# CompileLaTeX.sh - compiles LaTeX documents including bibliography. Removes extraneous files 
# tab t	generated during this process.
# ConcatenateTwoFiles.sh - takes two files and merges (concatenates) them into one new file 
# CountLines.sh - a shell script which counts the number of lines in a file and prints that number
# MyExampleScript.sh - prints the words Hello 'USER' (where user is replaced by the current user)
#	its a basic example script 	
# UnixPract1.txt - Week1 practical, containing single line solutions to the problems posed at the
# 	end of the Unix notebook
# boilerplate.sh - a basic boilerplate script for bash
# csvtospace.sh - converts comma delimited files to space delimited files
# tabtocsv.sh - converts tab delimited filed to comma delimited files 
# tiff2png.sh - convert .png files to .jpeg files
# variables.sh
#
#
#
# Data: This weeks data include the species lists from the IUCN redlist (under spawannxs.txt), temperature data in csv and processed txt formats (1800.csv, 1801.csv, 1802,csv, 1803.csv + the same filenames with a .txt extension), and genomic data in fasta file format (E.coli.fasta, 407228326.fasta, 407228412.fasta). 
# 
# 
# Output: 
# FirstBiblio.blb -- 
# FirstExample.bbl -- 
# FirstExample.blg ----- Output from running CompileLaTeX.sh on the FirstExample.tex file, with
# 	an imported bibliography (FirstBiblio.blb).  
# FirstExample.pdf -- 
# FirstExample.tex-- 
# 
#
# Sandbox: 
# TestFind - a folder containing multiple directories and files (blank but with different 
# 	extensions) to play with the find command
# TestWild - a folder containing multiple files with different extensions and wildcard c
# 	characters to play with using the wilfcard search functions
# ListRootDir - a file created when playing with the redirection functions
# Sandbox - a file containing the IUCN Red list species data
# test.txt - a file used to test out tab to csv
# test.txt.csv - the result of tab to csv
