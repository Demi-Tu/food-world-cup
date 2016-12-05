# server.r 
library(dplyr)
library(plotly)
library(shiny)

shinyServer(function(input, output) {
  setwd("~/INFO-201/food-world-cup/")
  food <- read.csv("data/food-world-cup-data.csv")
  
})