library(shiny)

ui <- fluidPage(
  tags$h1("ENGAGEMENT SURVEY"),
  textInput(inputId = "feelings", label = "How's the feelings now?", placeholder = "e.g. Feels Nice!"),
  textOutput(outputId = "feelings")
)

server <- function(input, output, session){
  output$feelings <- readerText({
    paste0("Feelings: ", input$feelings)
  })
}

sinyApp(ui, server)