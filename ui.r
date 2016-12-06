# ui.R
library(plotly)
library(shiny)

shinyUI(
  fluidPage(
    titlePanel('We asked people what their favorite cuisine was... What happened next will shock you!!'),
    sidebarLayout(
      sidebarPanel(
        radioButtons("gender", label = h4("Select gender"),
                     choices = list("Both" = "Both", "Female" = "Female", "Male" = "Male"), 
                     selected = "Both"
                     )
      )
    )
  )
)