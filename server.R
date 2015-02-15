library(UsingR)
data(babies)

shinyServer(
  function(input, output) {

    meanWt <- reactive({
      
      filteredBabies <- babies[which(babies$age == input$age & babies$smoke == input$smoke),]
      mean(filteredBabies$wt)
    })
    
    filteredDataset <- reactive({
      
      minAge           <- input$age[1]
      maxAge           <- input$age[2]
      includeUnknowAge <- input$unknowAge
      
      if(includeUnknowAge) {
        filteredBabies <- subset(babies, (babies$age >= minAge & babies&age <= maxAge) | babies$age == 99)
      } else {       
       filteredBabies <- subset(babies, babies$age >= minAge & babies&age <= maxAge)
      }
      
      # 99 = All
      if(input$smoke == 99) {
        filteredBabies <- filteredBabies
      } else {
        filteredBabies <- babies[babies$smoke == input$smoke,]
      }
      
      filteredBabies
    
    })
    
    
    output$dtTable1 <- renderDataTable(filteredDataset())
    output$text1 <- renderPrint({input$unknowAge})
    output$meanWt <- renderPrint({meanWt()})
    
    
    
    
    output$newHist <- renderPlot({
      hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
      mu <- input$mu
      lines(c(mu, mu), c(0, 200),col="red",lwd=5)
      mse <- mean((galton$child - mu)^2)
      text(63, 150, paste("mu = ", mu))
      text(63, 140, paste("MSE = ", round(mse, 2)))
    })
    
  }
)