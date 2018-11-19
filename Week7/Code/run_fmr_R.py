# !/usr/bin/env python3
""" Using the subprocess module to run R script via python """

__appname__ = 'run_fmr_R.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


# Imports
import subprocess

# Functions
# def Run_fmr():
#     """ Running fmr.R """
#     print("Running fmr.R")
#     p = subprocess.Popen("/usr/vin/env --verbose fmr.R",
#     stdout=subprocess.PIPE , stderr=subprocess.PIPE)
#     try:
#         outs, errs = p.communicate(timeout=60)
#     except subprocess.TimeoutExpired:
#         p.kill()
#         print("Timeout expired")
#         outs, errs = p.communicate()
    
#     outs.decode()
#     print("Done")






def Run_fmr():
    """ Running fmr.R """
    print("Running fmr.R")
    p = subprocess.Popen(["Rscript", "--verbose", "fmr.R"],
    stdout=subprocess.PIPE , stderr=subprocess.PIPE)
    try:
        outs, errs = p.communicate(timeout=60)
    except subprocess.TimeoutExpired:
        p.kill()
        print("Timeout expired")
        outs, errs = p.communicate()
    
    print(outs.decode())
    print("Done")

Run_fmr()