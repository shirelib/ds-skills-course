## server.R

library(shiny)
library(maps)
library(ggplot2)
library(rnaturalearth)
library(scico)


# Loading data, from: https://www.kaggle.com/datasets/sandragracenelson/suicide-rate-of-countries-per-every-year
full_long <- read.csv("data/suicide_full_data.csv")
# Creating a smaller dataframe including only variables to display in the
                                          # table (country, year, suicide rate):
x <- full_long[,c(2,6,7)]

# for ui
country_list <- as.list(unique(full_long$Country))
names(country_list) <- country_list
#saveRDS(country_list, file="country_list.rds")

# Define server
shinyServer(function(input,output){
  
  # Sentence presenting the graph
  graphText<- reactive({
    paste("You have chosen to look at", input$country, ":")
  })
  
  # now I return graphText for printing as a caption
  output$caption2<- renderText({
    graphText()
  })
  
  # Suicide rate per country graph
  output$graph<- renderPlot({
    
    ggplot(dplyr::filter(full_long, Country == input$country), aes(x = year, y = suicide_rate, color = Country)) + 
      scale_color_viridis_d() +
      geom_point(shape = 16, alpha = 0.3) + 
      geom_smooth(se = FALSE, color = "darkred") +
      theme_minimal() +
      theme(legend.position = "none") +
      xlab("Year") +
      ylab("Suicide Rate")
    
  })
  
})