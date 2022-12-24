# ==== LOADING ====
library(tidyverse) # Data handling
library(dplyr) # Manupulating data base
library(GGally) # Multiple variables handling
library(ggplot2) # Plotting
library(arrow) # Feather files
library(googlesheets4) # Spreadsheets

# ==== Import data ==== 
df_pl <- range_read(ssID_pl, sheet = shtName_pnlPLs)
lst_dfLsts <- list()
for(shtName in lstShtNames){
  df <- range_read(ssID_pl, shtName)
}