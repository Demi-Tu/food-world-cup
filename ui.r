# ui.R
library(plotly)
library(shiny)

shinyUI(
  fluidPage(
    titlePanel('We asked people what their favorite cuisine was... What happened next will shock you!!'),
    sidebarLayout(
      sidebarPanel(
        radioButtons("gender",
                     label = h4("Select gender"),
                     choices = list("Combined" = "Both", "Only female" = "Female", "Only male" = "Male")
                     )
      #   checkboxGroupInput("age", 
      #                      label = h4("Select age group"),
      #                      choices = list("18-29 years" = "18-29",
      #                                     "30-44 years" = "30-44",
      #                                     "45-60 years" = "45-60",
      #                                     "60 and older" = "> 60"),
      #                      selected = c("18-29", "33-44", "45-60", "> 60")
      #                      ),
      #   checkboxGroupInput("income",
      #                      label= h4("Select income bracket"),
      #                      choices = list("Less than 25K" = "$0 - $24,999",
      #                                     "25K to 49K" = "$25,000 - $49,999",
      #                                     "50K to 99K" = "$50,000 - $99,999",
      #                                     "100K to 149K" = "$100,000 - $149,999",
      #                                     "More than 150K" = "$150,000+"),
      #                      selected = c("$0 - $24,999", 
      #                                   "$100,000 - $149,999", 
      #                                   "$150,000+", 
      #                                   "$25,000 - $49,999", 
      #                                   "$50,000 - $99,999")
      #                      )
      ),
      mainPanel(
        plotlyOutput('world.map')
      )
    )
  )
)