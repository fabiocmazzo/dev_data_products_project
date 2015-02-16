library(UsingR)
library(corrplot)
data(babies)

shinyServer(
  function(input, output) {

   
    
    filterDataset <- reactive({
      
      minAge           <- input$age[1]
      maxAge           <- input$age[2]
      includeUnknowAge <- input$unknowAge
      
      if(includeUnknowAge) {
        filteredBabies <- babies[which((babies$age >= minAge & babies$age <= maxAge) | babies$age == 99),]
      } else {       
       filteredBabies <- babies[which(babies$age >= minAge & babies$age <= maxAge),]
      }
      
      # 99 = All
      if(input$smoke != 99) {
        filteredBabies <- filteredBabies[filteredBabies$smoke == input$smoke,]
      }
      
      # 100 = All
      if(input$cnumber != 100) {
        filteredBabies <- filteredBabies[filteredBabies$number == input$cnumber,]
      }
      
       colnames(filteredBabies) <- c("id", "Pluralty", "Live Birth", "Date", "Gestation",
                                     "Sex", "Birth Weight (Onces)", "Parity", "Mother's Race",
                                     "Mother's Age", "Mother's Education", "Mother's Height", "Mother's Prepregnancy (Pounds)",
                                     "Father's Race", "Father's Age", "Father's Education", "Father's Height", 
                                     "Father's Weight", "Marital", "Family Yearly Income", "Smoke", "Time Smoke Quit", "Cigarrets Number")
      
      filteredBabies
    
    })
    
    
   
    
    output$dtTable1 <- renderDataTable(filterDataset())
    output$hist <- renderPlot({
      dataFiltered  <- filterDataset()
      if(nrow(dataFiltered) > 0) {
        hist(dataFiltered$"Birth Weight (Onces)",xlab="Weight (Onces)", 
             main="Infant's Birth Weight",breaks=100)
        abline(v = mean(dataFiltered$"Birth Weight (Onces)"), col = "blue", lwd = 2)
      }
    })
   
    output$mean <- renderText({
      dataFiltered  <- filterDataset()
       if(nrow(dataFiltered) > 0) {
         paste("Infant's Weight Mean: ", round(mean(dataFiltered$"Birth Weight (Onces)"),2))
       } else {
         "No data found"
       }
     })
  
    
  
    
  }
)