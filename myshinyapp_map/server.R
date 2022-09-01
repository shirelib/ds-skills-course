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
  
  # Sentence presenting the table in a reactive expression
  tableText<- reactive({
    paste("This table ranks countries by the suicide rate. You have selected the data from", input$year, ":")
  })
  
  # now I return the tabletText and graphText for printing as a caption
  output$caption<- renderText({
    tableText()
  })
  
  # Plot a table that ranks countries (from most affected to the least) by suicide rate
  output$rank<- renderTable({
    xcont<- subset(x, year==input$year)
      head(xcont[order(xcont$suicide_rate, decreasing=T),], n= input$obs)
      
  })
  
  # Plot a world map visualizing suicide rate incidence.
  
  output$map<- renderPlot({
    
    world_raw <- ne_countries(scale = "medium", returnclass = "sf")
    world <- merge(world_raw, full_long, by.x = "name_long", by.y = "Country")
    filtered <- dplyr::filter(world, year==input$year)
    filtered$suicide_rate_sqrt <- log(filtered$suicide_rate)
    ggplot(data = filtered) +
      geom_sf(aes(fill = suicide_rate_sqrt)) +
      scico::scale_fill_scico(palette = "lajolla") +
      theme(aspect.ratio=0.5) +
      labs(fill='Suicide Rate') 
    
  })
  
})