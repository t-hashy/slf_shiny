# ==== LOADING ====
library(tidyverse) # Data handling
library(GGally) # Multiple variables handling
library(ggplot2) # Plotting
library(dbplyr) # Data base handling
library(googlesheets4) # Google spreadsheet as data bases

# ==== With Data files ====
getStrOfTimeNow <- function(){
  return(format(Sys.time(), "%Y%m%d-%H%M"))
}

makeFilePath <- function(title = "test", extension = ".feather", withDatetime = TRUE){
  if(withDatetime){
    title = paste(title, getStrNow(), sep = "_")
  }
  path <- paste(data_dir, "/", title, extension, sep = "")
  
  return(path)
}

# ==== Data Frames Basics ====

checktheData <- function(df){
  
  message("==== GLIMPSE ====")
  print(glimpse(df))
  
  message("==== SUMMARY ==== ")
  print(summary(df))
  
  message("==== PLOT")
  plot(df)
  
}

# ==== Data Base Management ====

createNewUID <- function(currentUIDs = list(), lenUID = 8, lrgLetters = TRUE, smlLetters = TRUE){
  
  # Repeat until uid goes as unique one
  newUID <- NULL
  checker <- FALSE
  while(!checker){
    
    # Create a UID
    newUID <- NULL
    if(lrgLetters){
      if(smlLetters){
        newUID = sample(c(LETTERS, letters, 0:9), lenUID)
      }else{
        newUID = sample(c(LETTERS, 0:9),lenUID)
      }
    }else{
      if(smlLetters){
        newUID = sample(c(letters,0:9), lenUID) 
      }else{
        newUID = sample(0:9, lenUID)  
      }
    }
    newUID = paste(newUID, collapse = "")
    
    # Check duplication
    for(currentUID in currentUIDs){
      if(currentUID == newUID){
        break
      }
    }
    checker = TRUE
  }
  
  # Return
  return(newUID)
}