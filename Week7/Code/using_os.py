#!/usr/bin/env ipython3
""" Learning to use the subprocess module in python """

__appname__ = 'using_os.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

#Imports
import subprocess
import re

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Use the subprocess.os module to get a list of files and  directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

def All_Dir_Files():
    """ Returns a list of all directories and files in home/ """
    ALL = []
    for (directory, subdir, files) in subprocess.os.walk(home): 
        ALL += [i for i in subdir if re.match(r'\w*', i)!=None]
        ALL += [i for i in files if re.match(r'\w*', i)!=None]
    return ALL
All_Dir_Files()
print("\nall dir and files in home")
print(len(All_Dir_Files()))
#print(All_Dir_Files())


#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here: 

# Use a for loop to walk through the home directory.
def F_D_C():
    """ Makes a list of files and directories in home/ with an uppercase C"""
    FDC = []
    for (directory, subdir, files) in subprocess.os.walk(home):
        FDC += [i for i in subdir if re.match(r'^C\w*', i)!=None]
        FDC += [i for i in files if re.match(r'^C\w*', i)!=None]
    return FDC

F_D_C()
print("\ndir in home starting with upper case c")
print(len(F_D_C()))


#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:

def C_orc():
    """ Makes a list of files and directories in home/ with either upper or lowercase C"""
    C_or_c = []
    for (directory, subdir, files) in subprocess.os.walk(home):
        C_or_c += [i for i in subdir if re.match(r'^[Cc]\w*', i)!=None]
        C_or_c += [i for i in files if re.match(r'^[Cc]\w*', i)!=None]
    return C_or_c
C_orc()
print("\nfiles and dir in home starting with upper or lower case c")
print(len(C_orc()))


#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:

def DirC():
    """ Makes a list of directories in home/ with either an uppercase or lowercase C """
    DC = []
    for (directory, subdir, results) in subprocess.os.walk(home):
        DC += [i for i in subdir if re.match(r'^[Cc]\w*', i)!=None]      
    return DC
DirC()
print("\ndir in home starting with upper or lower case c")
print(len(DirC()))


