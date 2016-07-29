scData <- NULL
shinyServer(function(input, output, session){
  
  output$plotMMET <- renderPlotly({
    
    getPlot(mmet, "Marginal MET", xMax = 55,
            xlab = "Leisure Time Physical Activity (LTPA) Marginal MET.hr/week", interceptMultiplier = (3.5/4.5) )
    
  })
  
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
  
  
  getPlot <- function (dataset, plotTitle, xMax = 70, xlab = "Leisure Time Physical Activity (LTPA) MET.hr/week", interceptMultiplier = 1 ){
    
    outfile <- tempfile(fileext='.png')
    
    # Generate the PNG
    png(outfile, width=400, height=300)
    
    gg <- ggplot(dataset, aes(dose, RR)) + 
      geom_line(data = dataset) + 
      geom_ribbon(data = dataset, aes(ymin=`Lower Band`,ymax=`Higher Band`),alpha=0.4) +
      coord_cartesian(ylim = c(0, 1), xlim = c(0, xMax)) +
      scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0)) + 
      # coord_cartesian(xlim = c(0, 70)) +
      xlab(paste("\n", xlab, "\n")) +
      ylab("\nRelative Risk\n") +
      geom_vline(xintercept= (interceptMultiplier * summary_table$`LTPA MET.hrs/week`), linetype="dotted", alpha=0.4) + 
      
      theme(
        plot.margin = unit(c(2, 1, 1, 1), "cm"), 
        plot.title = element_text(size = 15, face = "bold", colour = "black", vjust = 7), 
        legend.direction = "horizontal",
        legend.position = c(0.1, 1.05)) + 
      ggtitle(plotTitle) +
      labs(fill = "") 
    
    p <- ggplotly(gg)
    dev.off()
    p
  }
  
  output$summaryDT <- DT::renderDataTable({
    if(is.null(summary_table)){
      return()
    }
    
    DT::datatable(summary_table, options = list(pageLength = 10), colnames = names(summary_table)) 
  })
  
  shinyjs::onclick("scAHelp", shinyjs::toggle(id = "scAHelpText", anim = TRUE))
  shinyjs::onclick("scBHelp", shinyjs::toggle(id = "scBHelpText", anim = TRUE))
  shinyjs::onclick("scCHelp", shinyjs::toggle(id = "scCHelpText", anim = TRUE))
  shinyjs::onclick("scDHelp", shinyjs::toggle(id = "scDHelpText", anim = TRUE))
  
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
  
  
  # downloadHandler() takes two arguments, both functions.
  # The content function is passed a filename as an argument, and
  #   it should write out data to that filename.
  output$downloadMMETData <- downloadHandler(
    
    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      paste("MMET.csv")
    },
    
    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      # Write to a file specified by the 'file' argument
      write.table(mmet, file, sep = ",", row.names = FALSE)
    }
  )
  
})