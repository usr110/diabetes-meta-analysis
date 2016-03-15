scData <- NULL
shinyServer(function(input, output, session){
  
  output$plotMetaAnalysis <- renderChart({
    filterScData()
    # "dose","RR","95Percent-CI-Lower-bound","95Percent-CI-Higher-bound"
    # "dose","RR","Lower Band with 95% CI","Higher Band with 95% CI"
    h1 <- mPlot(x = "dose", 
                y = c("Higher Band with 95% CI", "RR", "Lower Band with 95% CI"), 
                data = scData, type = "Line")
    h1$set(pointSize = 0)
    h1$set(hideHover = "auto")
    h1$set(dom = "plotMetaAnalysis")
    return (h1)
  })
  
  filterScData <- reactive({
    data <- NULL
    if (input$inSc == 'Scenario A'){
      data <- scA
    }else if(input$inSc == 'Scenario B'){
      data <- scB
    }else if(input$inSc == 'Scenario C'){
      data <- scC
    }else if(input$inSc == 'Scenario D'){
      data <- scD
    }
    scData <<- data
  })
})