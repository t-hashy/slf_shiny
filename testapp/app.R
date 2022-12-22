# ==== FOR DEPLOYMENT ===
# library(rsconnect)
# rsconnect::deployApp('directorypath/path/where/app.R/Exists)

# ==== LOADING ====

library(shiny)

# ==== UI ====

ui <- fluidPage(
  tags$h1("ENGAGEMENT SURVEY"),
  textInput(inputId = "feelings", label = "How's the feelings now?", placeholder = "e.g. Feels Nice!"),
  numericInput(inputId = "score", label = "Engagement score: 1 ~ 10", value = 5),
  textOutput(outputId = "output")
)

# ==== SERVER ====

server <- function(input, output, session){
  output$output <- renderText({
    paste0("Feelings: ", input$feelings, ", Score: ", input$score)
  })
  
  
  
  
}

# ==== RUN APP ====

shinyApp(ui, server)