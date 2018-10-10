#!/bin/bash
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: CompileLaTeX.sh
# Desc: Compiles LaTeX documents and cleans up extraneous files from
# the compilation
# Arguments: 1 -> .tex file
# Date: Oct 2018
pdflatex $1.tex # command that compiles pdf from .tex files
bibtex $1 # adds a bibliography to the pdf file 
pdflatex $1.tex # compiles the completed document
pdflatex $1.tex
echo "Compiled! Opening document for you to view" # just something to
# say its done it's thing
evince ../Results/$1.pdf & # GNOME document viewer - opens the compiled pdf in
# a document viewer when done
mv $1.pdf ../Results/ # moving the product to the results dir
## Cleanup of extraneous files
# * means all of 
# .$ specifies the file extensions to be removed
# 
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
