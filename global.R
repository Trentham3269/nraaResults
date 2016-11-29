# nraaResults Global
library(shiny)
library(dplyr)
library(readr)
library(plotly)

# Set working directory
wd <- "~/Documents/Repos/shinyApps/nraaResults/"
setwd(wd)

# Import csv file 
df <- read_csv("nraaResults.csv")

# Clean columns
df$Score <- as.character(df$Score) #removes issue of grand agg centres 
                                   #being shown as 3 decimal places?



  
