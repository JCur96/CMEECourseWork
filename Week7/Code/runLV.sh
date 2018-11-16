#!/bin/bash 
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: runLV.sh
# Desc: Shell script for running LV 1+2 + profiling them
# Arguments: none
# Date: Nov 2018

echo "Running Profile on LV1.py"
ipython3 -m cProfile LV1.py
echo "Done"
echo "Running profile on LV2.py"
ipython3 -m cProfile LV2.py 1. 0.1 1.5 0.75
echo "Done"
