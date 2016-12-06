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
  group_by(country, code, Gender, Household.Income, Age, Education) %>%
  summarise(mean_rating = mean(rating, na.rm = TRUE))

shinyServer(function(input, output) {
  df <- ratings.summ
  
  # # Show only selected gender
  #  if (input$gender != "Both") {
  #   df %>% filter(Gender == input$gender)
  # }
  # 
  # # Show only selected age groups
  # df %>% filter(Age %in% input$age)
  # 
  # # Show only selected income brackets
  # df %>% filter(Household.Income %in% input$income)

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
        text = ~country, locations = ~code, marker = list(line = l)
      ) %>%
      colorbar(title = 'Average Rating out of 5') %>%
      layout(
        title = 'Food World Cup! Which Country has the Best Food?',
        geo = g
      )
    return (p)
  })
})