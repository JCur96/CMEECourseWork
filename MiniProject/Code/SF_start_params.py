# !/usr/bin/env python3
"""Start parameter calculations for Schoolfield model"""

__appname__ = "SF_start_params.py"
__author__ = "Jake Curry (j.curry18@imperial.ac.uk)"
__version__ = "0.0.1"
__license__ = "License for this code/program"

# Imports
import argparse
from lmfit import Parameters, minimize
import logging
from numpy import sqrt, asarray, NaN, exp, where, mean
import os
from pandas import DataFrame, read_csv
import csv
from scipy import constants, stats
import statistics as stat
import pandas as pd

# Defaults
DEFAULT_CSV = os.path.join("Data", "Updated_BioTraits.csv")
k = constants.value('Boltzmann constant in eV/K')  # this is a constant


class Starting_Calcs(object):
    def __init__(self, source_csv):
        """Constructor

        :param str source_csv: Source CSV file
        """

        logging.info("Loading %s", source_csv)
        self.source_df = read_csv(source_csv)

    @staticmethod
    def start_params(unique_id):
        """Calculates all starting values for schoolfield
        based on unique ID

        :param unique_id: unique identifier based on FinalID
        :return: Original dataframe now with starting parameters
        :rtype: DataFrame
        """

        temp = unique_id.GradientTemp
        temp_k = unique_id.Temp_K
        logtraitval = unique_id.logTraitValue
        midpoint = unique_id.logTraitValue.idxmax()
        midtemp = unique_id.GradientTemp[unique_id.logTraitValue.idxmax()]
        y = NaN

        # at midpoint, split the data into two arrays
        EhVect = where(unique_id.GradientTemp >= midtemp, logtraitval, y)
        EVect = where(unique_id.GradientTemp < midtemp, logtraitval, y)

        Len_EVect = len(EVect)
        Len_EhVect = len(EhVect)

        if Len_EVect < 3:  # all the points are one side of the 'midpoint'):
            EGrad = stats.linregress(temp, logtraitval)
        else:
            try:
                EGrad = stats.linregress(
                    temp[:midpoint], logtraitval[:midpoint])
            except ValueError as error:
                logging.error("ValueError encountered %r", error)
                EGrad = stats.linregress(temp, logtraitval)

        if Len_EhVect < 3:
            EhGrad = stats.linregress(temp, logtraitval)
        else:
            try:
                EhGrad = stats.linregress(
                    temp[midpoint:], logtraitval[midpoint:])
            except ValueError as error:
                #logging.error("ValueError encountered %r", error)
                EhGrad = stats.linregress(temp, logtraitval)

        B0 = exp(EGrad[0] * (1 / (k * 283.15)) + EGrad[1])

        if Len_EhVect < 2:
            Th = midtemp
        else:
            try:
                Th = (
                    ((mean(logtraitval) - logtraitval[B0]) / EhGrad[0]))**(-1) / k
            except BaseException:
                Th = temp_k[logtraitval.idxmax()]  # close to where 50% deactivation would occur

        return DataFrame({
            "E": EGrad[0],
            "Eh": EhGrad[0],
            "B0": B0,
            "Th": Th
        }, index=[0]
        )  # index assignment as passing scalar values

    def Param_gen_and_write(self):
        """ Runs through generating starting
        parameters and writes to a new .csv 
        """
        SF_start_params = self.source_df.groupby(
            "FinalID").apply(self.start_params)
        SF_start_params.reset_index(level=0, inplace=True)
        self.source_df = pd.merge(
            self.source_df,
            SF_start_params,
            on="FinalID")
        self.source_df.to_csv("../Data/Biotraits_with_start_params.csv")


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)

    parser = argparse.ArgumentParser(
        description="Schoolfield start parameter calculator")
    parser.add_argument("csv_file", default=DEFAULT_CSV)
    args = parser.parse_args()

    obj = Starting_Calcs(args.csv_file)
    obj.Param_gen_and_write()
