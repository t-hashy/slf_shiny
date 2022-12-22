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

# ---- Utility functions ----

# Data files
getStrNow <- function(){
  return(format(Sys.time(), "%Y%m%d-%H%M"))
}
makeFilePath <- function(title = "test", extension = ".feather", datetime = TRUE){
  if(datetime){
    title = paste(title, getStrNow(), sep = "_")
  }
  path <- paste(data_dir, "/", title, extension, sep = "")
  
  return(path)
}

# Data checks
checkData <- function(df){
  message("==== Glimpse ====")
  print(glimpse(df))
  message("==== Summary ==== ")
  print(summary(df))
  tryCatch(
    {
      tryCatch(
        {
          df <- df %>% select(!c(uid))
          if(length(df$expired[df$expired == TRUE]) > 2){
            ggpairs(df, mapping = aes(colour = df$expired))
            message("==== Plot without uid and with the factor of expired ====")
          }else{
            df <- df %>% select(!expired)
            ggpairs(df)
            message("==== Plot without uid and expired ====")
          }
        }, 
        error = function(err) {
          ggpairs(df)
          message("==== Plot all ====")
        }
      )
    },
    error = function(err) message("*Having Some Plotting Errors.")
  )
}

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
