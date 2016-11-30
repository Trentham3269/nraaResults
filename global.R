# nraaResults Global
library(shiny)
library(DT)
library(dplyr)
library(readr)
library(stringr)
library(plotly)

# Set working directory
wd <- "~/Documents/Repos/shinyApps/nraaResults/"
setwd(wd)

# Import csv file 
df <- read_csv("nraaResults.csv", col_types = str_dup("c", 11))

# Concatenate name column
df$Name <- paste0(df$`Preferred Name`, " ", df$`Last Name`)


  
