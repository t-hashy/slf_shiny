# ==== LOADING ====
library(tidyverse) # Data handling
library(dbplyr) # Data base handling
library(arrow) # Feather files handling
library(googlesheets4) # Google spreadsheet as data bases

# ==== Fixed items ====
ssID_shinytest <- "1oberWgKgCPOEJT9Tc4SUidjxaMirF7-K6XPL0zBTrL4"
ss_shinytest <- gs4_get(ssID_shinytest)
shtName_test <- "test"

# ==== Import data from a spreadsheet
df_test <- range_read(ssID_test, sheet = shtName_test)

# ==== Synch with spreadsheet
syncDFTOSheet <- function(ssID, shtName, df_sync){
  
  # Get the data
  df_db <- NULL
  tryCatch(
    {
      df_db <- range_read(ssID, sheet = shtName)  
    },
    error = function(err){
      message(err)
      return()
    }
  )
  
  
  # IF the data frame to sync has different column names with the sheet data, return error.
  notFoundCols <- NULL
  lstTitlesIndexes_db <- list()
  for(name_sync in names(df_sync)){
    index <- 0
    for(name_db in names(df_db)){
      index = index + 1
      if(name_db == name_sync){
        lstTitlesIndexes_db.append(index)
        break
      }
    }
    if(!found){
      notFoundCols <- paste(name_sync, notFoundCols)
    }
  }
  if(length(notFoundCols)>0){
    message(paste("ERROR | NOT FOUND COLUMN(s):", notFoundCols))
    return()
  }
  
  # Append or update each new rows
  for(df_row in df_sync){
    for()
  }
  
}

addRowToDf_test <- function(numScore, chrFeelings){
  
  # Set a row values as a data frame
  dfToAdd_toTest <- data.frame(
    uid = createNewUID(df_test$uid),
    datetime = Sys.time(),
    score = numScore,
    feelings = chrFeelings,
    expired = FALSE
  )
  
  # Add to spreadsheet
  sheet_append(ss_shinytest, dfToAdd_toTest, sheet = shtName_test)
  
  # Update 
}
