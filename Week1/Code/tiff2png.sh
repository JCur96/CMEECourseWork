#!/bin/bash
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: tiff2png.sh
# Desc: converts .tif files to .png files
# Arguments: 1 -> $f is a file name
# Date: Oct 2018
for f in *.tiff: # this is a for loop - basic programming method of running 
	# through a set of commands
	do
		echo "Converting $f"; # prints whats in quotation marks 
		#for use to see 
		convert "$f" "$(basename "$f" .tif).jpg": # converts the file
		# type whislt retaining the name
	done # ends the loop 

