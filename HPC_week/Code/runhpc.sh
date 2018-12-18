# !/usr/bin/bash
#PBS -l walltime=12;00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
R --vanilla < $HOME/neutral_sim/jc518.R
mv datafilename* $HOME/output
echo "R has finished running"

