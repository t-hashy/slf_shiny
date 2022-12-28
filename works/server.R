# ==== LODING ====
library(shiny)
library(shinymanager)
library(shinyjs)
library(arrow) # feather files

# ==== Import data ====
if(initialization){
  df_categories <- data.frame(
    uid = character(),
    category = character(),
    expired = logical(),
    stringsAsFactors = FALSE
  )
  df_tasks <- data.frame(
    uid = character(),
    task = character(),
    category = df_categories,
    expired = logical()
  )
  df_todos <- data.frame(
    uid = character(),
    progress = factor(numeric()), # 0:Yet, 1:on-Going, 2: Done
    task = df_tasks,
    hours.estimated = numeric(),
    hours.real = numeric(),
    date.due = as.POSIXct(numeric()),
    date.work = as.POSIXct(numeric()),
    completed = logical(),
    expired = logical()
  )
  df_timestamps <- data.frame(
    uid = character(),
    task = df_tasks,
    start = as.POSIXct(numeric()), # 1:TRUE,0:FALSE
    end = as.POSIXct(numeric()), # 1:TRUE, 0:FALSE
    completed = logical(), 
    hours = numeric(),
    expired = logical()
  )
}else{
  df_categories <- read_feather(paste(datafolder_path, "categories.feather", sep = "")) 
  df_tasks <- read_feather(paste(datafolder_path, "tasks.feather", sep = "")) 
  df_timestamps <- read_feather(paste(datafolder_path, "timestamps.feather", sep = "")) 
  df_todos <- read_feather(paste(datafolder_path, "todos.feather", sep = "")) 
}

# ==== Export data ===
lst_dfs <- list(categories = df_categories, tasks = df_tasks, timestamps = df_timestamps, todos = df_todos)
counter = 1
for(df in lst_dfs){
  print(names(lst_dfs)[counter])
  write_feather(df ,paste(datafolder_path, names(lst_dfs)[counter] , ".feather", sep = "")) 
  counter = counter + 1
}
