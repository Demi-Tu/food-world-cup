# server.r 
library(dplyr)
library(plotly)
library(shiny)

setwd("~/food-world-cup")
source("./scripts/wrangle-data.R")

#Anushna's data/work

food <- read.csv("data/food-world-cup-data.csv")
food <- makePretty(food)
ratings <- read.csv("data/food-world-cup-combined-cols.csv")
ratings.summ <- ratings %>%
  group_by(country, 
           code, 
           Gender, 
           Age,
           Household.Income) %>%
  summarize(mean_rating = mean(rating, na.rm = TRUE))

#shinyServer

shinyServer(function(input, output) {
  df <- ratings.summ
  
  #Creates world chloropleth map
  output$world.map <- renderPlotly({

    ##Show only selected age groups and income brackets
    df <- ratings.summ %>% filter(Gender %in% input$gender,
                                  Age %in% input$age,
                                  Household.Income %in% input$income)
    
    #Light grey boundaries
    l <- list(color = toRGB("grey"), width = 0.5)
    
    #Specify map projection/options
    g <- list(
      showframe = TRUE,
      showcoastlines = TRUE,
      projection = list(type = 'Mercator')
    )
    
    p <- plot_geo(df) %>%
      add_trace(
        z = ~mean_rating, color = ~mean_rating, colors = 'Greens',
        text = ~country, locations = ~code, marker = list(line = l)
      ) %>%
      colorbar(title = 'Average Rating out of 5') %>%
      layout(
        title = 'Food World Cup! Which Country has the Best Food?',
        geo = g
      )
    return (p)
  })
  
  rd <- read.csv("data/food-world-cup-rating-instances.csv")
  
  output$rating.dist <- renderPlot({
    
    # Render a barplot
    return(barplot(rd[,input$country], 
                   main=input$country,
                   ylab="Number of Respondents",
                   xlab="Rating",
                   names.arg = c('1', '2', '3', '4', '5'),
                   col = 'pink'
          )
    )
  })
})