# From: http://shiny.rstudio.com/articles/basics.html
library(shiny)

library(dplyr)
library(tidyr)
library(RColorBrewer)

# load GGplot2
library(ggplot2)

setwd("~/Desktop/food-world-cup/Demi/")
#source("./scripts/makeRing.R")
#setwd("~/Desktop/")
#source("./makeRing.R")
#source("./wrangle-data.R")

# Read in data
data <- read.csv("data/food-world-cup-data.csv")

#pretty.data <- makePretty(data)
#information <- select(pretty.data, Gender, Age, Household.Income, Education, Location..Census.Region.)
#information <- rename(information, Census.Region = Location..Census.Region.)

shinyServer(function(input, output) {
  output$ring <- renderPlot({
    knowledge <- group_by(data, Generally.speaking..how.would.you.rate.your.level.of.knowledgeof.cuisines.from.different.parts.of.the.world.) %>%
      summarise(Count = n())
    knowledge <- rename(knowledge, Level.of.Knowledge = Generally.speaking..how.would.you.rate.your.level.of.knowledgeof.cuisines.from.different.parts.of.the.world.)
    
    # Add addition columns, needed for drawing with geom_rect.
    knowledge$fraction = knowledge$Count / sum(knowledge$Count)
    knowledge = knowledge[order(knowledge$fraction), ]
    knowledge$ymax = cumsum(knowledge$fraction)
    knowledge$ymin = c(0, head(knowledge$ymax, n=-1))
    
    # Make the plot
    ggplot(knowledge, aes(fill=Level.of.Knowledge, ymax=ymax, ymin=ymin, xmax=4, xmin=3)) +
      geom_rect() +
      coord_polar(theta="y") +
      xlim(c(0, 4)) +
      theme(panel.grid=element_blank()) +
      theme(axis.text=element_blank()) +
      theme(axis.ticks=element_blank()) +
      annotate("text", x = 0, y = 0, label = "How would you rate yourself?") +
      labs(title="")
  })
})