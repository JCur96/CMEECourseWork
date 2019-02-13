#!/usr/bin/env python3
''' Calling C in python ''''
import ctypes
cdll.LoadLibrary("LibraryGoesHere.exten")
Libgoeshere = ctypes.CDLL("Libgoehere.extension")

# types must be coerced to prevent data loss e.g. 

libgoesher.add_floats.argtypes = [ctypes.c_float, ctypes.c_float]
libgoesher.add_floats.restype = ctypes.c_float