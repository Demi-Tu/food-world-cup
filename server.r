# server.r 
library(dplyr)
library(plotly)
library(shiny)

setwd("~/INFO-201/food-world-cup/")
source("./scripts/wrangle-data.R")

food <- read.csv("data/food-world-cup-data.csv")
food <- makePretty(food)
ratings <- combineCols(food)

# Create summary table of average ratings
ratings.summ <- ratings %>%
  group_by(country) %>%
  summarise(mean_rating = mean(rating, na.rm = TRUE))

shinyServer(function(input, output) {
  df <- food
  
  # Show only selected gender
   if (input$gender != "Both") {
    df %>% filter(Gender == input$gender)
  }
  
  # Show only selected age groups
  df %>% filter(Age %in% input$age)
  
  # Show only selected income brackets
  df %>% filter(Household.Income %in% input$income)
  
  # Placeholder line of code, I don't think it works
  output$value <- renderPrint({input$gender})
})