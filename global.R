# nraaResults Global
library(shiny)
library(DT)
library(dplyr)
library(readr)
library(stringr)

# Import csv file 
df <- read_csv("data/nraaResults.csv", col_types = str_dup("c", 11))

# Concatenate name column
df$Name <- paste0(df$`Preferred Name`, " ", df$`Last Name`)


  
