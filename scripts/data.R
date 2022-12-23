# ---- Loading ----
library(tidyverse) # Data handling
library(dbplyr) # SQL like data handling
library(arrow) # feather file reading
library(ggplot2) # Plotting and its aestetics
library(GGally) # for ggpairs: Multiple variables

# ---- Fixed Declarations ----
# Data files
data_dir = "../data"
file_wb = "data.feather"

# ---- Set data frames ----

# Create an empty data frame
df_temp <- data.frame(
  uid = character(),
  datetime = as.POSIXlt(character()),
  score = integer(),
  feelings = character(),
  expired = as.logical.factor(character())
)

# Get data exist
tryCatch(
  {
    df_temp = df_wb
    message("==== df_wb already exists. ====")
  }, 
  error = function(err){
    try(
      {
        df_temp = read_feather(paste(data_dir, "/", file_wb, sep=""))
        message("==== Import the df_wb file ====")
      },
      silent = TRUE
    )
  }
)

# Replace a data frame of temp with that of well-being
df_wb <- df_temp

# Check the data
plt <- checkData(df_wb)
