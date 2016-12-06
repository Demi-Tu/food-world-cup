# ui.R
library(plotly)
library(shiny)

shinyUI(
  fluidPage(
    titlePanel('Food World Cup'),
    sidebarLayout(
      sidebarPanel(
        p("To your right is a world map. The green-colored countries are countries for which we have survey data on cuisine ratings. If you hover over the country, you can see the average rating for the demographics you have selected."),
        p("Below you will find some options to filter the by gender, age, and income bracket. Selecting multiple boxes includes the survey results of all of those groups and displays the average rating of each country's cuisine on the map to the right."),
        p("What interesting information can you find?"),
        checkboxGroupInput("gender",
                           label = h4("Select gender"),
                           choices = list("Female" = "Female", "Male" = "Male"),
                           selected = c("Female", "Male")
                           ),
        checkboxGroupInput("age",
                           label = h4("Select age group(s)"),
                           choices = list("18-29 years" = "18-29",
                                          "30-44 years" = "30-44",
                                          "45-60 years" = "45-60",
                                          "60 and older" = "> 60"),
                           selected = c("18-29", "30-44", "45-60", "> 60")
                           ),
        checkboxGroupInput("income",
                           label= h4("Select income bracket(s)"),
                           choices = list("Less than 25K" = "$0 - $24,999",
                                          "25K to 49K" = "$25,000 - $49,999",
                                          "50K to 99K" = "$50,000 - $99,999",
                                          "100K to 149K" = "$100,000 - $149,999",
                                          "More than 150K" = "$150,000+"),
                           selected = c("$0 - $24,999",
                                        "$100,000 - $149,999",
                                        "$150,000+",
                                        "$25,000 - $49,999",
                                        "$50,000 - $99,999")
                           )
      ),
      mainPanel(
        plotlyOutput('world.map')
      )
    )
  )
)