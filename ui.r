# ui.R
library(plotly)
library(shiny)
library(markdown)

shinyUI(
  navbarPage("Food World Cup!",
             tabPanel("Overview",
                      fluidRow(
                        column(6,
                               includeMarkdown("scripts/overview.md")
                        )
                      )
             ),
             tabPanel("Average Ratings",
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
                          plotlyOutput('world.map'),
                          h3("Trends"),
                          p("As you fiddle with the preferences of different demographics, you will notice that",
                            strong("Italy"), 
                            "has the most consistently highly-rated cuisine. Who doesn't like pasta and pizza?"),
                          br(),
                          p("Another interesting trend is that the older crowd rates",
                            strong("American"),
                            "cuisine higher on average (> 4) than the younger crowd does (< 4).",
                            "The 45+ crowd also ranks French, Mexican, and Chinese food in their top 5 favorite cuisines,",
                            "whereas the those same cuisines do not make it into the top 7 of the younger generation."
                          ),
                          br(),
                          p("Of the genders,",
                            strong("females"),
                            "on average tend to have higher ratings of all cuisines."),
                          br(),
                          p("Between income brackets, there doesn't seem to be a huge difference in cuisine preferences."),
                          strong("What trends can you find?")
                        )
                      )
             ),
             tabPanel("Rating Distributions",
                      sidebarLayout(      
                        
                        # Define the sidebar with one input
                        sidebarPanel(
                          p("Displayed is a barchart that gives us information of the rating distributions on a scale of 1 (does not taste good) to 5 (best food in the world!) for the selected country."),
                          p("To select a different country, please use the drop down box below."),
                          selectInput("country", "Select country", 
                                      choices=colnames(rd))
                        ),
                        
                        # Create a spot for the barplot
                        mainPanel(
                          plotOutput("rating.dist")  
                        )
                        
                      )
             ),
             tabPanel("Respondent Demographics"
             ),
             tabPanel("About Us",
                      fluidRow(
                        column(6,
                               includeMarkdown("scripts/aboutUs.md")
                        )
                      )
             )
  )
)