library(shiny)
library(UsingR)
data(babies)

# Get min a max age's for use in sliderinput for user selection
minAge = min(babies$age[babies$age != 99])
maxAge = max(babies$age[babies$age != 99])

shinyUI(fluidPage(
  titlePanel("Babie Weight in Born"),
  fluidRow(
    column(3,
           wellPanel(
             h4("Filter"),
             sliderInput("age", "Age of Mother",
                         minAge, maxAge, value = c(minAge, maxAge)),
             
             checkboxInput("unknowAge", "Include Unknow Age", value = TRUE),
             
             selectInput("smoke", "Smoke", c('All' = 99,
                                             'Never' = 0,
                                             'Smokes now' = 1,
                                             'Until current pregnancy' = 2,
                                             'Until did, not now' = 3,
                                             'Unkown' = 9)),
            
             selectInput("cnumber", "Cigarrets Number", c('All' = 100,
                                             'Never Smoked' = 0,
                                             '1 - 4' = 1,
                                             '5 - 9' = 2,
                                             '10 - 14' = 3,
                                             '15 - 19' = 4,
                                             '20 - 29' = 5,
                                             '30 - 39' = 6,
                                             '40 - 60' = 7,
                                             '60+' = 8,
                                             'Smoke but don\'t know' = 9,
                                             'Unknown' = 98,
                                             'Not asked' = 99))
             
           ),
           wellPanel(
             h4("Tip"),
             tags$small("Select tabs at the top")
           )
    ),
    column(9,
           navbarPage(
             title = ' ',
             tabPanel('Results',           plotOutput("hist"), verbatimTextOutput("mean")),
             tabPanel('DataTable',       dataTableOutput('dtTable1')),
             tabPanel('Documentation', includeHTML("documentation.html"))
            
             )
    )
  )
))