##ui.R

library(shiny)

# Define UI
shinyUI(fluidPage(
  
  # Custom CSS, in order to remove an unneeded scrollbar
  tags$head(
    tags$style(HTML('.shiny-split-layout>div {overflow: hidden;}')),
  ),
  
  titlePanel(""),
  
  fluidRow(
      splitLayout(cellWidths = c("50%", "50%"),
                  
                  verticalLayout(selectInput("year","Year:",
                                             list("2000"="2000", "2001"="2001", "2002"="2002", "2003"="2003",
                                                  "2004"="2004", "2005"="2005", "2006"="2006", "2007"="2007",
                                                  "2008"="2008", "2009"="2009", "2010"="2010", "2011"="2011",
                                                  "2012"="2012", "2013"="2013", "2014"="2014", "2015"="2015",
                                                  "2016"="2016", "2017"="2017", "2018"="2018", "2019"="2019"
                                             ), width = "60%"),
                                 numericInput("obs", "Choose how many countries to view in the table", 3, width =  "60%")),
                  
                  tableOutput("rank")
                  ),
      
      h5(textOutput("caption")),
      
      plotOutput("map")
             ),
    
))