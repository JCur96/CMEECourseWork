# !/usr/bin/env python3
"""Working Cubic Polynomial model applied over the full dataset"""

__appname__ = "cubic.py"
__author__ = "Jake Curry (j.curry18@imperial.ac.uk)"
__version__ = "0.0.1"
__license__ = "License for this code/program"

import argparse
from lmfit import Parameters, minimize
import logging
from numpy import sqrt, asarray, NaN
import os
from pandas import DataFrame, read_csv
import csv

# Constants
DEFAULT_CSV = os.path.join("Data", "Updated_BioTraits.csv")
DEFAULT_B0 = 0.0
DEFAULT_B1 = 0.0
DEFAULT_B2 = 0.0
DEFAULT_B3 = 0.0


class DataFit(object):
    def __init__(self, source_csv, B0, B1, B2, B3):
        """Constructor

        :param str source_csv: Source CSV file
        :param float B0: A constant
        :param float B1: A constant
        :param float B2: A constant
        :param float B3: A constant
        """
        self.B0, self.B1, self.B2, self.B3 = B0, B1, B2, B3

        logging.info("Loading %s")
        self.source_df = read_csv(source_csv)

        # Empty data frame to store the cubic fit
        self.cubic_fitted_df = DataFrame(data=None)

    @staticmethod
    def cubic(params, temperature, data):
        """Cubic model function

        :param Parameters params: Parameter estimates
        :param float temperature: Input temperature
        :param float data: Original trait value
        :return: Fit of the model to the data
        :rtype: float
        """
        B0 = params["B0"]
        B1 = params["B1"]
        B2 = params["B2"]
        B3 = params["B3"]

        model = B0 + B1 * temperature + B2 * \
            (temperature**2) + B3 * (temperature**3)

        return model - data

    def cubic_model_fitting(self, unique_id):
        """Fit the cubic to all the data grouped by
        unique_id and save the output to a new data frame

        :param unique_id: Unique identifier
        :return: Fitted data frame
        :rtype: DataFrame
        """

        cubic_params = Parameters()
        cubic_params.add("B0", value=self.B0)
        cubic_params.add("B1", value=self.B1)
        cubic_params.add("B2", value=self.B2)
        cubic_params.add("B3", value=self.B3)

        cubic_out = minimize(self.cubic, cubic_params, args=(
            asarray(self.source_df.ConTemp[self.source_df.FinalID == unique_id]),
            asarray(self.source_df.OriginalTraitValue[self.source_df.FinalID == unique_id])
        ))

        return DataFrame({
            "UniqueID": unique_id,
            "B0": [cubic_out.params["B0"].value],
            "B1": [cubic_out.params["B1"].value],
            "B2": [cubic_out.params["B2"].value],
            "B3": [cubic_out.params["B3"].value],
            "chisqr": [cubic_out.chisqr],
            "AIC": [cubic_out.aic],
            "BIC": [cubic_out.bic]
        })

    def CSVWrite(self):
        """Writes the data frame to a csv file"""
        self.cubic_fitted_df.to_csv(
            '../Data/cubic_fitted.csv',
            index=False,
            header=True)   # saves the output data to a new csv file

    def fit(self):
        """Fit loaded data"""
        for unique_id in self.source_df.FinalID.unique():
            try:
                self.cubic_fitted_df = self.cubic_fitted_df.append(
                    self.cubic_model_fitting(unique_id))
            except ValueError as error:
                logging.error("ValueError encountered %r", error)
        print(len(self.cubic_fitted_df), 'Models converged!')
        self.CSVWrite()


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)

    parser = argparse.ArgumentParser(description="Cubic fitter")
    parser.add_argument("csv_file", default=DEFAULT_CSV)
    parser.add_argument("--B0", type=float, default=DEFAULT_B0)
    parser.add_argument("--B1", type=float, default=DEFAULT_B1)
    parser.add_argument("--B2", type=float, default=DEFAULT_B2)
    parser.add_argument("--B3", type=float, default=DEFAULT_B3)
    args = parser.parse_args()

    obj = DataFit(args.csv_file, args.B0, args.B1, args.B2, args.B3)
    obj.fit()
