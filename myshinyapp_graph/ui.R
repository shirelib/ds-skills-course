##ui.R

library(shiny)
country_list <- readRDS("data/country_list.rds")

# Define UI
shinyUI(pageWithSidebar(
  
  # my Application title
  headerPanel(""),
  
  # a sidebar with which to choose a year to look at
  
  sidebarPanel(
    selectInput("country","Country:",
                country_list)
  ),
  
  mainPanel(
    
    h5(textOutput("caption2")),
    
    plotOutput("graph", width = "100%")
    
  )
  
))