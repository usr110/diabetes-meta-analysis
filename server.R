scData <- NULL
shinyServer(function(input, output, session){
  
  output$plotScenarioA <- renderPlotly({
    
    
    getPlot(scA, "Scenario A")
    
  })
  
  output$plotScenarioB <- renderPlotly({
    getPlot(scB, "Scenario B")
    
  })
  output$plotScenarioC <- renderPlotly({
    getPlot(scC, "Scenario C")
    
  })
  output$plotScenarioD <- renderPlotly({
    getPlot(scD, "Scenario D")
    
  })
  
  
  getPlot <- function (dataset, plotTitle){
    
    #par(oma=c(10,2,0,0) )

    outfile <- tempfile(fileext='.png')
    
    # Generate the PNG
    png(outfile, width=400, height=300)
    gg <- ggplot(dataset, aes(dose, RR)) + 
      geom_line(data = dataset) + 
      geom_ribbon(data = dataset, aes(ymin=`Lower Band`,ymax=`Higher Band`),alpha=0.4) +
      coord_cartesian(ylim = c(0, 1)) +
      coord_cartesian(xlim = c(0, 70)) +
      xlab("Dose") +
      ylab("\nRelative Risk\n") +
      theme(axis.title.y=element_text(margin=margin(0,20,0,0))) + 
      geom_vline(xintercept=summary_table$`LTPA MET.hrs/week`, linetype="dotted", alpha=0.4) + 
      ggtitle(plotTitle)
    
    p <- ggplotly(gg)
    dev.off()
    p
  }
  
  #   output$plotScenarioA <- renderChart({
  #     
  #     require(rCharts)
  #     options(stringsAsFactors = F)
  #     library(reshape2)
  #     melted_data = melt(scA, id = "dose")
  #     library(rCharts)
  #     h1 <- hPlot(value ~ dose, group = 'variable', data = melted_data, 
  #                 type = 'line')
  #     # h1$yAxis(overrideMax = 1, overrideMin = 0)
  #     h1$xAxis(axisLabel = 'Scenario B: Leisure Time Physical Activity (MET hours per week)')
  #     h1$yAxis(axisLabel = "RR", width = 30, height = 500)
  #     h1$yAxis(tickFormat = "#! function(d) {return d3.round(d, 2);} !#")
  #     h1$tooltip(shared = T)
  #     h1$exporting(enabled = T)
  #     h1$set(dom = "plotScenarioA")
  #     return(h1)
  #     
  #   })
  #   
  #   
  #   
  #   output$plotScenarioB <- renderChart({
  #     require(rCharts)
  #     options(stringsAsFactors = F)
  #     library(reshape2)
  #     melted_data = melt(scB, id = "dose")
  #     library(rCharts)
  #     h1 <- hPlot(value ~ dose, group = 'variable', data = melted_data, 
  #                 type = 'line')
  #     # h1$yAxis(overrideMax = 1, overrideMin = 0)
  #     h1$xAxis(axisLabel = 'Scenario B: Leisure Time Physical Activity (MET hours per week)')
  #     h1$yAxis(axisLabel = "RR", width = 30, height = 500)
  #     h1$yAxis(tickFormat = "#! function(d) {return d3.round(d, 2);} !#")
  #     h1$tooltip(shared = T)
  #     h1$exporting(enabled = T)
  #     h1$set(dom = "plotScenarioB")
  #     return(h1)
  #   })
  #   
  #   output$plotScenarioC <- renderChart({
  #     require(rCharts)
  #     options(stringsAsFactors = F)
  #     library(reshape2)
  #     melted_data = melt(scC, id = "dose")
  #     library(rCharts)
  #     h1 <- hPlot(value ~ dose, group = 'variable', data = melted_data, 
  #                 type = 'line')
  #     h1$xAxis(axisLabel = 'Scenario C: Leisure Time Physical Activity (MET hours per week)')
  #     h1$yAxis(axisLabel = "RR", width = 30, height = 500)
  #     h1$yAxis(tickFormat = "#! function(d) {return d3.round(d, 2);} !#")
  #     h1$tooltip(shared = T)
  #     h1$exporting(enabled = T)
  #     h1$set(dom = "plotScenarioC")
  #     return(h1)
  #   })
  #   
  #   output$plotScenarioD <- renderChart({
  #     require(rCharts)
  #     options(stringsAsFactors = F)
  #     library(reshape2)
  #     melted_data = melt(scD, id = "dose")
  #     library(rCharts)
  #     h1 <- hPlot(value ~ dose, group = 'variable', data = melted_data, 
  #                 type = 'line')
  #     h1$xAxis(axisLabel = 'Scenario D: Leisure Time Physical Activity (MET hours per week)')
  #     h1$yAxis(axisLabel = "RR", width = 30, height = 500)
  #     h1$yAxis(tickFormat = "#! function(d) {return d3.round(d, 2);} !#")
  #     h1$tooltip(shared = T)
  #     h1$exporting(enabled = T)
  #     h1$set(dom = "plotScenarioD")
  #     return(h1)
  #   })
  
  
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
    # smooth data
    
    #     data1 <- smooth.spline(data$dose, data$RR, spar=1, keep.data = TRUE)
    #     data2 <- smooth.spline(data[,3], data$RR, spar=1, keep.data = TRUE)
    #     data3 <- smooth.spline(data[,4], data$RR, spar=1, keep.data = TRUE)
    
    # cat(length(data1$x), ' : ', length(data2$x), ' : ', length(data3$x), "\n")
    
    # "dose","RR","Lower Band with 95% CI","Higher Band with 95% CI"
    #     data$dose <- data1$x
    #     data$RR <- data1$y
    #     data[["Lower Band with 95% CI"]] <- data2$x
    #     data[["Higher Band with 95% CI"]] <- data3$x
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
  
  # downloadHandler() takes two arguments, both functions.
  # The content function is passed a filename as an argument, and
  #   it should write out data to that filename.
  output$downloadDatascA <- downloadHandler(
    
    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      paste("scenario-a.csv")
    },
    
    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      # Write to a file specified by the 'file' argument
      write.table(scA, file, sep = ",", row.names = FALSE)
    }
  )
  
  # downloadHandler() takes two arguments, both functions.
  # The content function is passed a filename as an argument, and
  #   it should write out data to that filename.
  output$downloadDatascB <- downloadHandler(
    
    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      paste("scenario-b.csv")
    },
    
    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      # Write to a file specified by the 'file' argument
      write.table(scB, file, sep = ",", row.names = FALSE)
    }
  )
  
  # downloadHandler() takes two arguments, both functions.
  # The content function is passed a filename as an argument, and
  #   it should write out data to that filename.
  output$downloadDatascC <- downloadHandler(
    
    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      paste("scenario-c.csv")
    },
    
    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      # Write to a file specified by the 'file' argument
      write.table(scC, file, sep = ",", row.names = FALSE)
    }
  )
  
  # downloadHandler() takes two arguments, both functions.
  # The content function is passed a filename as an argument, and
  #   it should write out data to that filename.
  output$downloadDatascD <- downloadHandler(
    
    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      paste("scenario-d.csv")
    },
    
    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      # Write to a file specified by the 'file' argument
      write.table(scD, file, sep = ",", row.names = FALSE)
    }
  )
  
})