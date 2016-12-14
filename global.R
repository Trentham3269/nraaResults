# nraaResults Global
library(shiny)
library(DT)
library(dplyr)
library(readr)
library(stringr)
library(plotly)

# Import csv files
df <- read_csv("data/nraaHistorical.csv")
df2 <- read_csv("data/nraaResults.csv", col_types = str_dup("c", 11))

# Concatenate name column
df2$Name <- paste0(df2$`Preferred Name`, " ", df2$`Last Name`)





  
  


  
