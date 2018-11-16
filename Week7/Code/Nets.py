# !/usr/bin/env ipython3
""" Networks in Python converted from R """

__appname__ = 'Nets.py'
__author__ = 'Jake Curry (j.curry18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

# Imports
import csv
import networkx as nx
import scipy as sc
import matplotlib.pyplot as p


# Reading data in
links = open("../Data/QMEE_Net_Mat_edges.csv", header=T, as.is=T)
nodes = open("../Data/QMEE_Net_Mat_nodes.csv", header=T, row.names = 1)

#Create graph object
net <- graph.adjacency(as.matrix(links), mode = "directed", weighted=TRUE, diag=F)
        

# Generate colors based on partner type:
colrs <- c("green", "red", "blue")
V(net)$color <- colrs[nodes$Type]

# Set node size based on Number of PIs:
# V(net)$size <- V(net)$Pis*0.9

V(net)$size <- 50

# Set edge width based on weight (PhD Students):
E(net)$width <- E(net)$weight

#change arrow size and edge color:
E(net)$arrow.size <- 1
E(net)$edge.color <- "gray80"

E(net)$width <- 1+E(net)$weight/10

graphics.off()

svg("../Results/QMEENet.svg",width=7,height=7)

plot(net, edge.curved=0, vertex.label.color="black") 

legend(x=-1.5, y=-0.1, c("Hosting Partner", "Non-hosting Partner", "University"), pch=21,
       col="#777777", pt.bg=colrs, pt.cex=2, cex=.8, bty="n", ncol=1)

# Pythonic plotting
pos = nx.circular_layout(Sps)
G = nx.Graph()
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL)) # this function needs a tuple input
NodSizs= 1000 * (Sizs-min(Sizs))/(max(Sizs)-min(Sizs)) 
nx.draw_networkx(G, pos, node_size = NodSizs)

p.close('all') # this is python
