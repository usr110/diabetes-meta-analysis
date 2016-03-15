scData <- NULL
shinyServer(function(input, output, session){
  
  output$plotMetaAnalysis <- renderChart({
    filterScData()
#     # "dose","RR","95Percent-CI-Lower-bound","95Percent-CI-Higher-bound"
#     # "dose","RR","Lower Band with 95% CI","Higher Band with 95% CI"
#     h1 <- mPlot(x = "dose", 
#                 y = c("Higher Band with 95% CI", "RR", "Lower Band with 95% CI"), 
#                 data = scData, type = "Line")
#     h1$set(pointSize = 0)
#     h1$set(hideHover = "auto")
#     h1$set(dom = "plotMetaAnalysis")
#     return (h1)
    
    
    require(rCharts)
    options(stringsAsFactors = F)
    library(reshape2)
    melted_data = melt(scData, id = "dose")
    library(rCharts)
    # NVD3
    h1 <- nPlot(value ~ dose, group = 'variable', data = melted_data, 
                type = c('lineChart'))
    
    
                # type = 'lineChart')
    # h1$chart(width=1200, height=500, tooltipContent = "#! function(key, x, y, e)")
    h1$xAxis(axisLabel = 'Leisure Time Physical Activity (MET hours per week)')
    h1$yAxis(axisLabel = "RR", width = 30, height = 500)
    h1$yAxis(tickFormat = "#! function(d) {return d3.round(d, 2);} !#")
    # h1$chart(margin=list(left= 30, right = 30)) 
    h1$chart(useInteractiveGuideline = TRUE)
    h1$set(dom = "plotMetaAnalysis")
    return(h1)
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
  
  output$summaryDT <- DT::renderDataTable({
    if(is.null(summary_table)){
      return()
    }
    
    DT::datatable(summary_table, options = list(pageLength = 10), colnames = names(summary_table)) 
#     %>%
#       formatRound(columns = names(numericZoneColNames), digits=2)
  })
  
  shinyjs::onclick("help", shinyjs::toggle(id = "helpText", anim = FALSE))
})