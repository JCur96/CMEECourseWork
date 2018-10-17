#!/usr/bin/env python3
""" Aligns two DNA sequences from a single input file and sends the best match to a single output file """

__appname__ = 'align_seqs.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


# Two example sequences to match
# seq2 = "ATCGCCGGATTACGGG"
# seq1 = "CAATTCGGAT"

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest
import sys
import csv

##     



def inreading(lines):
    """ reads files in and makes sure the sequence lengths are correct way round
    by  assigning each sequence to either seq1 or seq2 """
    # D = open(seqfile)
    # lines = D.readlines()
    # D.close 
    seq1 = lines[0].rstrip("\n")
    seq2 = lines[1].rstrip("\n")

    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths
    return s1, s2, l1, l2

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    """ calculates the score of how many bases in the sequences match"""
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output from making sure the code does what was expected
    # print("." * startpoint + matched)           
    # print("." * startpoint + s2)
    # print(s1)
    # print(score) 
    # print(" ")

    return score


# Test the function with some example starting points:
    # calculate_score(s1, s2, l1, l2, 0)
    # calculate_score(s1, s2, l1, l2, 1)
    # calculate_score(s1, s2, l1, l2, 5)
            

# now try to find the best match (highest score) for the two sequences
def best_match(s1, s2, l1, l2):
    """ calculates the best alignment i.e. with the highest score """
    my_best_align = None
    my_best_score = -1

    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # think about what this is doing!
            my_best_score = z 
    return my_best_align, my_best_score


def main(argv):
    """ Reads a single csv file and extracts the data
    then parses through, functions for sequence length,
    alignment and score. Then outputs best alignment, the longest sequence and the best score to a txt file"""
    with open("../Data/seqs.csv", "r") as infile:  
        inreader = csv.reader(infile) # make a reader instance for infile, reads lines in 
        source_data = [x[0] for x in inreader] # makes a list out of the contents of the .reader object
    source_data = source_data[0:2] # Makes sure only the first two lines in the file are used
    print(source_data)
    s1, s2, l1, l2 = inreading(source_data) # calling from inreading function above 
    my_best_align, my_best_score = best_match(s1, s2, l1, l2) # calling from the modularised best_match function
    out_str = "{}\n{}\nBest Score: {}\n".format(my_best_align, s1, my_best_score) # turning the outputs into a string
    with open("../Results/BestMatch.txt", "w") as outfile:
        outfile.write(out_str)
    print(out_str)


if (__name__ == "__main__"):
    status = main(sys.argv) 
    sys.exit