# ==== LOADING ====
library(tidyverse) # data frame handling
library(dplyr) # data base management


# ==== Data base management ====
createNewUID <- function(lenUID = 8, currentUIDs = list()){
  
  chrs <- c(LETTERS, letters, 0:9)
  newUID <- paste(sample(chrs, lenUID), collapse = "")
  
  checker <- FALSE
  while(!checker){
    if((length(currentUIDs) > 0) && (newUID %in% currentUIDs)){
      message("Duplicated UID")
      newUID <- paste(sample(chrs, lenUID), collapse = "")
    }else{
      checker <- TRUE
    }
  }
  
  return(newUID)
}

# ==== Add to Data frame ====
addToCategories <- function(categoryToAdd){
  if(categoryToAdd %in% df_categories$category){
    message("Already Exits.")
    return(df_categories)
  }
  df_categories <- df_categories %>%
    add_row(data.frame(
      uid = createNewUID(currentUIDs = list(df_categories$uid)),
      category = categoryToAdd,
      expired = 0,
      stringsAsFactors = FALSE
    ))
  return(df_categories)
}
addToTasks <- function(taskToAdd, taskCategory){
  if(taskToAdd %in% df_tasks$task){
    message("Already Exists.")
    return(df_tasks)
  }
  df_category <- data.frame()
  if((length(df_categories) > 0) %% (taskCategory %in% df_categories$category)){
    df_category <- df_categories[df_categories$category == taskCategory,]
  }else{
    df_categories <- df_categories %>%
      add_row(data.frame(
        uid = createNewUID(),
        category = taskCategory,
        expired = 0,
        stringsAsFactors = FALSE
      ))
    df_category <- df_categories
  }
  df_tasks <- df_tasks %>%
    add_row(data.frame(
      uid = createNewUID(currentUIDs = list(df_tasks$uid)),
      task = taskToAdd,
      category = df_category,
      expired = 0,
      stringsAsFactors = FALSE
    ))
  return(df_tasks)
}
addToTimeStamps <- function(taskToAdd, lgCompleted = 0, time.start = 0, time.end = 0){
  if(taskToAdd %in% df_tasks$task){
    df_task <- df_tasks[df_tasks$task == taskToAdd,]
    if(time.start != 0){
      df_timestamps <- df_timestamps %>%
        add_row(data.frame(
          uid = createNewUID(currentUIDs = list(df_timestamps$uid)),
          task = df_task,
          start = as.POSIXct(time.start),
          end = Sys.time(),
          completed = lgCompleted,
          hours = difftime(start,end, units = "hours" ),
          expired = 0,
          stringsAsFactors = FALSE
        ))
    }
    if(time.end != 0){
      df_timestamps[df_timestamps$task.task == taskToAdd, "end"] <- as.POSIXct(time.end)
      df_timestamps[df_timestamps$task.task == taskToAdd, "hours"] <- difftime(
        df_timestamps[df_timestamps$task.task == taskToAdd, "start"],
        as.POSIXct(time.end),
        units = "hours"
      )
      df_timestamps[df_timestamps$task.task == taskToAdd, "completed"] <- lgCompleted
    }
  }else{
    message("NO SUCH TAKS FOUND.")
  }
  return(df_timestamps)
}
addToTodos <- function(taskToAdd, estHours = 0, dueDate = NULL, workDate = NULL){
  if(taskToAdd %in% df_tasks$task){
    df_task <- df_tasks[df_tasks$task == taskToAdd,]
    df_todos <- df_todos %>%
      add_row(data.frame(
        uid = createNewUID(currentUIDs = list(df_timestamps$uid)),
        progress = 0,
        task = df_task,
        hours.estimated = estHours,
        hours.real = 0,
        date.due = as.POSIXct(dueDate),
        date.work = as.POSIXct(workDate),
        completed = 0,
        expired = 0,
        stringsAsFactors = FALSE
      ))
  }else{
    message("NO SUCH TAKS FOUND.")
  }
  return(df_todos)
}
changeTodoProgress <- function(todoToChange){
  
}