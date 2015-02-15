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
                                             'Unkown' = 9))
             
           ),
           wellPanel(
             h4("Tips"),
             tags$small("Select the type of presentation in the tabs at the top")
           )
    ),
    column(9,
           navbarPage(
             title = ' ',
             tabPanel('DataTable',       dataTableOutput('dtTable1')),
             tabPanel('Graph',           verbatimTextOutput("text1")),
             tabPanel('Data Dictionary', includeHTML("data_dictionary.html"))
             
             
             )
    )
  )
))