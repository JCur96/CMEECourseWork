# !/usr/bin/env ipython3
""" Coding of the Lotka-Volterra model in python """

__appname__ = 'LV1.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

#Imports
import scipy as sc
import matplotlib.pylab as p
import scipy.integrate as integrate

#Functions
def dCR_dt(pops, t=0): # defining the function that makes the model

    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return sc.array([dRdt, dCdt])



r = 1. # setting inital values. Rate of growth, float
a = 0.1 # search rate
z = 1.5 # mortality
e = 0.75 # efficiency of converting biomass


t = sc.linspace(0, 15,  1000) # setting chosen time, timesteps 0 - 15 with 1000 sample points between


R0 = 10 # setting intial pops, resource
C0 = 5  # consumer
RC0 = sc.array([R0, C0]) # a numpy array containing the populations of both C and R

pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True) # the integration part actually happens here. Think of it like DeSolve in R


f1 = p.figure() # creating a blank figure named f1

p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density') # adding to plot
p.grid() # allocating a gridded background
p.legend(loc='best') # adding a legend to the 'best' location
p.xlabel('Time') # labelling
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
# p.show()# To display the figure


f1.savefig('../Results/LV_model.pdf') #Save figure

f2 = p.figure()

p.plot(pops[:,0], pops[:,1], 'r-') # plot
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')
# p.show()# To display the figure

f2.savefig('../Results/LV_model_CR.pdf') #Save figure


# def main(argv): 
#     """Main entry point of the program """
#     print('This is a boilerplate') 
    
#     return 0
    
# if __name__=="__main__": 
#     """Makes sure the "main" fuction is called from command line"""
#     status = main(sys.argv)
#     sys.exit(status)