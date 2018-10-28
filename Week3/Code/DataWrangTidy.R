################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Required packages ##############
require(dplyr)
require(tidyr)
############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = F)) 

# header = true because we do have metadata headers
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

############# Inspect the dataset ###############
# head(MyData) 
dplyr::tbl_df(MyData) # does the same as head
dim(MyData) # gives dimensions of data 
dplyr::glimpse(MyData) # does the same as str 
utils::View(MyData) # opens in a nice table

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
dplyr::tbl_df(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important! 
colnames(TempData) <- MyData[1,] # assign column names from original data 


############# Convert from wide to long format  ###############

MyWrangledData <- TempData %>% gather(., Species, Count, -Cultivation, -Block, -Plot, -Quadrat) %>% mutate(Cultivation = as.factor(Cultivation), Block = as.factor(Block), Plot = as.factor(Plot), Quadrat = as.factor(Quadrat), Count = as.integer(Count)) 
# in tidyverse %>% is used for piping, as | is in python. In this case, TempData is passed to the gahter command, the key: value pair is read, the other 
# col headers are ignored as the - notation signifies it isn't part of a pair. This is all passed to mutate, in which you can set 
# types e.g. factors or integers
glimpse(MyWrangledData)
tbl_df(MyWrangledData)
dim(MyWrangledData)

