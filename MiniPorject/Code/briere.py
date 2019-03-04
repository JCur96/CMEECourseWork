# !/usr/bin/env python3
"""Working Briere model applied over the full dataset"""

__appname__ = "briere.py"
__author__ = "Jake Curry (j.curry18@imperial.ac.uk)"
__version__ = "0.0.1"
__license__ = "License for this code/program"

import argparse
from lmfit import Parameters, minimize
import logging
from numpy import sqrt, asarray, NaN
import os
from pandas import DataFrame, read_csv

# Constants
DEFAULT_CSV = os.path.join("Data", "Updated_BioTraits.csv")
DEFAULT_INIT_MIN_TEMP = 0.0
DEFAULT_INIT_MAX_TEMP = 45.0
DEFAULT_CONST = 0.1
TEMPERATURE_LIMIT = 25.0  # +/-50


class DataFit(object):
    def __init__(self, source_csv, min_temp, max_temp, const):
        """Constructor

        :param str source_csv: Source CSV file
        :param float min_temp: Minimum temperature
        :param float max_temp: Maximum temperature
        :param float const: Constant
        """
        self.min_temp, self.max_temp, self.const = min_temp, max_temp, const

        logging.info("Loading %s")
        self.source_df = read_csv(source_csv)

        # Empty data frame to store the Briere fit
        self.briere_fitted_df = DataFrame(data=None)

    @staticmethod
    def briere(params, temperature, data):
        """Briere model function

        :param Parameters params: Parameter estimates
        :param float temperature: Input temperature
        :param float data: Original trait value
        :return: Amount the model deviates from the original trait value
        :rtype: float
        """
        min_temp = params["T0"]
        max_temp = params["Tm"]
        const = params["c"]

        model = const * temperature * \
            (temperature - min_temp) * sqrt(abs(max_temp - temperature))

        return model - data

    def briere_model_fitting(self, unique_id):
        """Fit the briere to all the data grouped by unique unique_id and save the output to a new data frame

        :param unique_id: Unique identifier
        :return: Fitted data frame
        :rtype: DataFrame
        """

        briere_params = Parameters()
        # Set some temperature bounds so things remain sensible
        briere_params.add(
            "T0",
            value=self.min_temp,
            min=min(
                self.source_df.ConTemp) -
            TEMPERATURE_LIMIT)
        briere_params.add(
            "Tm",
            value=self.max_temp,
            max=max(
                self.source_df.ConTemp) +
            TEMPERATURE_LIMIT)
        briere_params.add("c", value=self.const)

        briere_out = minimize(self.briere, briere_params, args=(
            asarray(self.source_df.ConTemp[self.source_df.FinalID == unique_id]),
            asarray(self.source_df.OriginalTraitValue[self.source_df.FinalID == unique_id])
        ))

        return DataFrame({
            "UniqueID": unique_id,
            "T0": [briere_out.params["T0"].value],
            "Tm": [briere_out.params["Tm"].value],
            "c": [briere_out.params["c"].value],
            "chisqr": [briere_out.chisqr],
            "AIC": [briere_out.aic],
            "BIC": [briere_out.bic]
        })

    def CSVWrite(self):
        """Writes the data frame to a csv file"""
        self.briere_fitted_df.to_csv(
            '../Data/briere_fitted.csv',
            index=False,
            header=True)  # saves the output data to a new csv file

    def fit(self):
        """Fit loaded data"""
        for unique_id in self.source_df.FinalID.unique():
            try:
                self.briere_fitted_df = self.briere_fitted_df.append(
                    self.briere_model_fitting(unique_id))
            except ValueError as error:
                logging.error("ValueError encountered %r", error)
         # print(self.cubic_fitted_df)
        print(len(self.briere_fitted_df), 'Models converged!')
        self.CSVWrite()


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)

    parser = argparse.ArgumentParser(description="Briere fitter")
    parser.add_argument("csv_file", default=DEFAULT_CSV)
    parser.add_argument(
        "--max_temp",
        type=float,
        default=DEFAULT_INIT_MAX_TEMP)
    parser.add_argument(
        "--min_temp",
        type=float,
        default=DEFAULT_INIT_MIN_TEMP)
    parser.add_argument("--const", type=float, default=DEFAULT_CONST)
    args = parser.parse_args()

    obj = DataFit(args.csv_file, args.min_temp, args.max_temp, args.const)
    obj.fit()
