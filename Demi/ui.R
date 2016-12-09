# From: http://shiny.rstudio.com/articles/basics.html
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Info on Respondents"),
  
  # Sidebar with a slider input for the number of bins and a select box for the type of data
  sidebarLayout(
    sidebarPanel(
      selectInput("select", label = h3("Select box"), 
                  choices = list("Gender" = "Gender", "Age" = "Age", "Household Income" = "Household.Income",
                                 "Education" = "Education", "Census Region" = "Census.Region"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("ring")
    )
  )
))