#!/bin/bash
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: tiff2png.sh
# Desc: converts .tif files to .png files
# Arguments: 1 -> $f is a file name
# Date: Oct 2018
for f in *.tif; # this is a for loop - basic programming method of running 
	# through a set of commands
	do
		echo "Converting $f"; # prints whats in quotation marks 
		#for you to see 
		convert "$f" "$(basename "$f" .tif).png"; # converts the file
		# type whislt retaining the name
		mv *.png ../Results/ # moving the product to the results dir
	done # ends the loop

