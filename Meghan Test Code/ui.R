
library(markdown)

navbarPage("Food World Cup!",
           tabPanel("Overview",
                    fluidRow(
                      column(6,
                             includeMarkdown("overview.md")
                      )
                    )
           ),
           tabPanel("Overview",
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("plotType", "Plot type",
                                     c("Scatter"="p", "Line"="l")
                        )
                      ),
                      mainPanel(
                        plotOutput("plot")
                      )
                    )
           ),
           tabPanel("Average Ratings",
                    verbatimTextOutput("summary")
           ),
           tabPanel("Rating Distributions"
           ),
           tabPanel("Respondent Demographics"
           ),
           tabPanel("About Us",
                    fluidRow(
                      column(6,
                             includeMarkdown("aboutUs.md")
                      )
                    )
           )
)
