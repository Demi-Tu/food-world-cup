# server.r 
library(dplyr)
library(plotly)
library(shiny)

setwd("~/INFO-201/food-world-cup/")
source("./scripts/wrangle-data.R")
food <- read.csv("data/food-world-cup-data.csv")

ratings <- wrangleData(food)

# THIS CODE DOESN'T WORK-- FIX LATER
ratings.summ <- ratings %>%
  group_by(country) %>%
  summarise(mean_rating = mean(rating, na.rm = TRUE))

shinyServer(function(input, output) {

})