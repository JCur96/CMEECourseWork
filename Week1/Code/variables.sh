#!/bin/bash
# Author: Jake Curry j.curry18@imperial.ac.uk
# Script: variables.sh
# Desc: shows how variables can be assinged and used in Unix via shell script
# Date: Oct 2018
MyVar='some string'
echo 'the current value of the variable is' $MyVar
echo 'Please enter a new string'
read MyVar
echo 'the current value of the variable is' $MyVar
## Reading multiple values
echo 'Enter two numbers seperated by space(s)'
read a b 
echo 'you entered' $a 'and' $b '. Their sum is:'
mysum=`expr $a + $b`
echo $mysum

