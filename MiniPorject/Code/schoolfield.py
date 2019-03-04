# !/usr/bin/env python3
"""Working Schoolfield model applied over the full dataset"""

__appname__ = "schoolfield.py"
__author__ = "Jake Curry (j.curry18@imperial.ac.uk)"
__version__ = "0.0.1"
__license__ = "License for this code/program"

import argparse
from lmfit import Parameters, minimize
import logging
from numpy import sqrt, asarray, NaN, exp, log
import os
from pandas import DataFrame, read_csv
import csv
from scipy import constants

# Constants
DEFAULT_CSV = os.path.join("Data", "BioTraits_with_start_params.csv")
# DEFAULT_B0 = 0.1
# DEFAULT_E = 0.1
# DEFAULT_Eh = 0.1
# DEFAULT_Th = 0.1
k = constants.value('Boltzmann constant in eV/K')  # this is a constant
e = exp(1)


class DataFit(object):
    def __init__(self, source_csv, B0, E, Eh, Th):
        """Constructor

        :param str source_csv: Source CSV file
        :param float B0: Trait value which is closest to reference temperature value(set at 10degC or 283.15k)
        :param float E : Before peak rate of change of metabolic rate (gradient of graph)
        :param float Eh: After peak rate of change of metabolic rate (gradient of graph)
        :param float Th: Temperature at which 50% deactivation occurs
        """

        logging.info("Loading %s")
        self.source_df = read_csv(source_csv)

        # self.source_df.B0, self.source_df.E, self.source_df.Eh, self.source_df.Th = B0, E, Eh, Th
        # Empty data frame to store the cubic fit
        self.schoolfield_fitted_df = DataFrame(data=None)

    @staticmethod
    def schoolfield(params, temperature, data):
        """Schoolfield model function

        :param Parameters params: Parameter estimates
        :param float temperature: Input temperature in Kelvin
        :param float data: Logged original trait value
        :return: Amount the model deviates from the original trait value
        :rtype: float
        """

        B0 = params['B0']
        E = params['E']
        Eh = params['Eh']
        Th = params['Th']

        model = log((B0 * e**((-E / k) * ((1 / temperature) - (1 / 283.15)))
                     ) / (1 + (e**((Eh / k) * ((1 / Th) - (1 / temperature))))))

        return exp(model) - exp(data)

    def starting_params(self, unique_id):
        """returns in a dictionary x, y and starting values for fitting schoolfield models"""
        
        start_params = {'unique_id': unique_id,
                        'temp_k': asarray(self.source_df.Temp_K[self.source_df.FinalID == unique_id]),
                        'logtraitval': asarray(self.source_df.logTraitValue[self.source_df.FinalID == unique_id]),
                        # iloc so that pandas or minimise don't throw a fit
                        'B0': self.source_df.B0[self.source_df.FinalID == unique_id].iloc[0],
                        'E': self.source_df.E[self.source_df.FinalID == unique_id].iloc[0],
                        'Eh': self.source_df.Eh[self.source_df.FinalID == unique_id].iloc[0],
                        'Th': self.source_df.Th[self.source_df.FinalID == unique_id].iloc[0]}
        # print(start_params)
        return start_params

    def schoolfield_model_fitting(self, unique_id):
        """Fit Schoolfield to all the data grouped by
        unique_id and save the output to a new data frame

        :param unique_id: Unique identifier
        :return: Fitted data frame
        :rtype: DataFrame
        """

        start_params = self.starting_params(unique_id)
        
        schoolfield_params = Parameters()
        schoolfield_params.add("B0", value=start_params["B0"])
        schoolfield_params.add("E", value=start_params["E"])
        schoolfield_params.add("Eh", value=start_params["Eh"])
        schoolfield_params.add("Th", value=start_params["Th"])

        schoolfield_out = minimize(
            self.schoolfield, schoolfield_params, args=(
                start_params["temp_k"], start_params["logtraitval"]))
        #print(schoolfield_out.params)
        #print(schoolfield_out)
        return DataFrame({
            "UniqueID": unique_id,
            "B0": [schoolfield_out.params["B0"].value],
            "E": [schoolfield_out.params["E"].value],
            "Eh": [schoolfield_out.params["Eh"].value],
            "Th": [schoolfield_out.params["Th"].value],
            "chisqr": [schoolfield_out.chisqr],
            "AIC": [schoolfield_out.aic],
            "BIC": [schoolfield_out.bic]
        })

    def CSVWrite(self):
        """Writes the data frame to a csv file"""
        self.schoolfield_fitted_df.to_csv(
            "../Data/schoolfield_fitted.csv",
            index=False,
            header=True)  # saves the output data to a new csv# or minimise don't throw a fit file

    def fit(self):
        """Fit loaded data"""
        for unique_id in self.source_df.FinalID.unique():
            try:
                self.schoolfield_fitted_df = self.schoolfield_fitted_df.append(
                    self.schoolfield_model_fitting(unique_id))
            except ValueError as error:
                logging.exception("ValueError encountered %r", error)
        print(len(self.schoolfield_fitted_df), 'Models converged!')
        self.CSVWrite()


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)

    parser = argparse.ArgumentParser(description="Schoolfield fitter")
    parser.add_argument("csv_file", default=DEFAULT_CSV)
    parser.add_argument("--B0", type=float)#, default=DEFAULT_B0)
    parser.add_argument("--E", type=float)#, default=DEFAULT_E)
    parser.add_argument("--Eh", type=float)#, default=DEFAULT_Eh)
    parser.add_argument("--Th", type=float)#, default=DEFAULT_Th)
    args = parser.parse_args()

    obj = DataFit(args.csv_file, args.B0, args.E, args.Eh, args.Th)
    obj.fit()
