# !/usr/bin/env ipython3
""" Networks in Python """

__appname__ = 'DrawFW.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

# Imports
import networkx as nx
import scipy as sc
import matplotlib.pyplot as p

def GenRdmAdjList(N = 2, C = 0.5): # C is connectance (probability that any two nodes will have a connection). N is nodes, in this case species
    """Generates a random adjacency list """
    Ids = range(N) # range returns a list of the given range
    ALst = [] # creating a list
    for i in Ids:
        if sc.random.uniform(0,1,1) < C: # uniform probability distribution, if probability generated is less than C there is a link (I think)
            Lnk = sc.random.choice(Ids,2).tolist() # appends to a list (and coerces it to a list as opposed to numpy array)
            if Lnk[0] != Lnk[1]: #avoid self (e.g., cannibalistic) loops
                ALst.append(Lnk)
    return ALst


# Setting N and C to something other than defaults
MaxN = 30
C = 0.75

# Making the adjacency list with the new inputs
AdjL = sc.array(GenRdmAdjList(MaxN, C))
AdjL

Sps = sc.unique(AdjL) # get species ids

# Getting body sizes on a log scale to plot
SizRan = ([-10,10]) #use log10 scale
Sizs = sc.random.uniform(SizRan[0],SizRan[1],MaxN)
Sizs

# Plotting some histograms to look at body sizes
# p.hist(10 ** Sizs) #raw scale
# p.show()
# p.hist(Sizs) #log10 scale
# p.show()

p.close('all') # close all open plot objects

# Plotting a network graph using networkx
pos = nx.circular_layout(Sps)
G = nx.Graph()
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL)) # this function needs a tuple input
NodSizs= 1000 * (Sizs-min(Sizs))/(max(Sizs)-min(Sizs)) 
nx.draw_networkx(G, pos, node_size = NodSizs)
# p.show()

p.savefig('../Results/FW.pdf')