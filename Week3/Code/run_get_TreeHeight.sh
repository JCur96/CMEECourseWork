#!/bin/bash
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: run_get_TreeHeight.R
# Desc: # A simple shell script that calls the get_TreeHeights R script, 
# using the trees.csv file as input data
# Arguments: 1 -> ../Data/trees, input data file
# Date: Oct 2018a
Rscript get_TreeHeight.R ../Data/trees.csv
