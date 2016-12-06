# server.r 
library(dplyr)
library(plotly)
library(shiny)

setwd("~/INFO-201/food-world-cup/")
source("./scripts/wrangle-data.R")
food <- read.csv("data/food-world-cup-data.csv")

food$Gender[food$Gender == ""] <- NA
food <- na.omit(food)

food$Age[food$Age == ""] <- NA
food$Household.Income[food$Household.Income == ""] <- NA
food$Education[food$Education == ""] <- NA

ratings <- wrangleData(food)

# Create summary table of average ratings
ratings.summ <- ratings %>%
  group_by(country) %>%
  summarise(mean_rating = mean(rating, na.rm = TRUE))

shinyServer(function(input, output) {
  df <- food
 
   if (input$gender != "Both") {
    df <- food %>%
      filter(Gender == input$gender)
  }
  
  # Placeholder line of code, I don't think it works
  output$value <- renderPrint({input$gender})
})