
library(shiny)
library(tidyverse)

data <- read_csv("../data/lab_sodra.csv")
datafiltered <- data%>%
  filter(ecoActCode == 452000)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectizeInput(inputId = "imones_kodas", label = "Imones kodas", choices = NULL, selected = NULL)
    ),
    mainPanel(tabsetPanel(
      tabPanel("grafikas", plotOutput("plot")),
      tabPanel("lentele", tableOutput("table"))
    )
    )
  )
)
server <- function(input, output, session) {
  updateSelectizeInput(session, "imones_kodas", choices = datafiltered$name, server = TRUE)
  
  output$table <- renderTable(
    datafiltered %>%
      filter(name == input$imones_kodas) , digits = 0
  )
  
  output$plot <- renderPlot(
    datafiltered %>%
      filter(name == input$imones_kodas) %>%
      ggplot(aes(x = month, y = avgWage)) +
      geom_line()      
  )
}
shinyApp(ui, server)