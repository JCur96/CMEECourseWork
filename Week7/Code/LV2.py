#!/usr/bin/env python3
""" Coding of the Lotka-Volterra model in python, without hard coding the input args """

__appname__ = 'LV2.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

#Imports
import scipy as sc
import matplotlib.pylab as p
import scipy.integrate as integrate
import sys

# Functions 
def main(argv): 
    """ Running the Lotka-Volterra model with carrying 
    capacity as a constrictor on resource growth """

    # These will be set in the cmd line
    r = float(argv[1]) # setting inital values. Rate of growth, float
    a = float(argv[2]) # search rate
    z = float(argv[3]) # mortality
    e = float(argv[4]) # efficiency of converting biomass
    K = float(100.)

    t = sc.linspace(0, 15,  1000) # setting chosen time, timesteps 0 - 15 with 1000 sample points between


    R0 = 10 # setting intial pops, resource
    C0 = 5  # consumer
    RC0 = sc.array([R0, C0]) # a numpy array containing the populations of both C and R

    def dCR_dt(pops, t=0): # defining the function that makes the model
        """ doing d of consumer and resource over dt """
        R = pops[0]
        C = pops[1]
        dRdt = r * R * (1 - R / K) - a * R * C 
        dCdt = -z * C + e * a * R * C
    
        return sc.array([dRdt, dCdt])
    
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True) # the integration part actually happens here. Think of it like DeSolve in 
    # Plotting it all out
    f1 = p.figure() # creating a blank figure named f1

    p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
    p.plot(t, pops[:,1]  , 'b-', label='Consumer density') # adding to plot
    p.grid() # allocating a gridded background
    p.legend(loc='best') # adding a legend to the 'best' location
    p.xlabel('Time') # labelling
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics r={}, a={}, \n z={}, e={} K={}'.format(r,a,z,e,K))
    # p.show()# To display the figure
    f1.savefig('../Results/LV2_model.pdf') #Save figure

    f2 = p.figure()

    p.plot(pops[:,0], pops[:,1], 'r-') # plot
    p.grid()
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer-Resource population dynamics r={}, a={}, \n z={}, e={}, K={}'.format(r,a,z,e,K))
    # p.show()# To display the figure
    f2.savefig('../Results/LV2_model_CR.pdf') #Save figure, 
    
    
if __name__=="__main__": 
    """Makes sure the "main" fuction is called from command line"""
    status = main(sys.argv)
    sys.exit(status)