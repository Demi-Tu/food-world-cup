# server.r 
library(dplyr)
library(plotly)
library(shiny)

setwd("~/INFO-201/food-world-cup/")
source("./scripts/wrangle-data.R")

food <- read.csv("data/food-world-cup-data.csv")
food <- makePretty(food)
ratings <- read.csv("data/food-world-cup-combined-cols.csv")

# Create summary table of average ratings
ratings.summ <- ratings %>%
  group_by(country, Gender, Household.Income, Age) %>%
  summarise(mean_rating = mean(rating, na.rm = TRUE))

shinyServer(function(input, output) {
  df <- ratings.summ
  
  # Show only selected gender
   if (input$gender != "Both") {
    df %>% filter(Gender == input$gender)
  }
  
  # Show only selected age groups
  df %>% filter(Age %in% input$age)
  
  # Show only selected income brackets
  df %>% filter(Household.Income %in% input$income)
  
  # Placeholder line of code, I don't think it works
  output$world.map <- renderPlotly({
    # light grey boundaries
    l <- list(color = toRGB("grey"), width = 0.5)
    
    # specify map projection/options
    g <- list(
      showframe = FALSE,
      showcoastlines = FALSE,
      projection = list(type = 'Mercator')
    )
    
    p <- plot_geo(df) %>%
      add_trace(
        z = ~mean_rating, color = ~mean_rating, colors = 'Greens',
        text = ~Country, locations = ~CODE, marker = list(line = l)
      ) %>%
      colorbar(title = 'GDP Billions US$', tickprefix = '$') %>%
      layout(
        title = '2014 Global GDP<br>Source:<a href="https://www.cia.gov/library/publications/the-world-factbook/fields/2195.html">CIA World Factbook</a>',
        geo = g
      )
  })
})