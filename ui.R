# Run the setup file which loads all the packages and required data
source("setup.R")

# Create a list of scenarios
choices = c ("Scenario A", "Scenario B", "Scenario C", "Scenario D")

shinyUI(fluidPage(
  useShinyjs(),
  titlePanel("Diabetes Meta Analysis"),
  fluidRow(
    column(width = 6,
           p("This Shiny app is used to display meta analysis of Physical Activity and Type 2 Diabetes"),
           p("In the meta-analysis, we have included 23 cohorts (27 independent observations) with 1245904 people 
             (82319 cases of incident T2DM)."),
           p("Source code:",
             a(href="https://github.com/usr110/diabetes-meta-analysis", "@usr110/diabetes-meta-analysis", target="_blank"))
    )
  ),
  fluidRow(
    column(width = 5, offset= 1,
           
           plotlyOutput("plotScenarioA"),
           fluidRow(
             column(width = 6,
                    a(id = "scAHelp", "Description", href = "#"),
                    (hidden (div(
                      id = "scAHelpText",
                      helpText(HTML("Scenario A: 
                      <ul>
                      <li>Session duration: 45 minutes</li>
                      <li>Intensity: MVPA = 4.5 MET/h; LPA= 3 MET/h; VPA= 8 MET/h</li>
                      </ul>"))
                    )))
             )
           )
    ),
    column(width = 5,
           plotlyOutput("plotScenarioB"),
           fluidRow(
             column(width = 6,
                    a(id = "scBHelp", "Description", href = "#"),
                    (hidden (div(
                      id = "scBHelpText",
                      helpText(HTML("Scenario B: 
                      <ul>
                      <li>Session duration: 30 minutes</li>
                      <li>Intensity: MVPA = 4.5 MET/h; LPA= 3 MET/h; VPA= 8 MET/h</li>
                      </ul>"))
                    )))
             )
           )
    )
  ),
  
  
  fluidRow(
    
    column(width = 5, offset = 1, downloadButton('downloadDatascA', 'Download Scenario A CSV Data') ),
    column(width = 5, downloadButton('downloadDatascB', 'Download Scenario B CSV Data') )
  ),
  
  
  fluidRow(
    column(width = 5, offset= 1,
           plotlyOutput("plotScenarioC"),
           fluidRow(
             column(width = 6,
                    a(id = "scCHelp", "Description", href = "#"),
                    (hidden (div(
                      id = "scCHelpText",
                      helpText(HTML("Scenario C: 
                                    <ul>
                                    <li>Session duration: 45 minutes</li>
                                    <li>Intensity: MVPA = 3.5 MET/h; LPA= 2 MET/h; VPA= 7 MET/h</li>
                                    </ul>"))
                    )))
             )
           )
    ),
    column(width = 5,
           plotlyOutput("plotScenarioD"),
           fluidRow(
             column(width = 6,
                    a(id = "scDHelp", "Description", href = "#"),
                    (hidden (div(
                      id = "scDHelpText",
                      helpText(HTML("Scenario D: 
                      <ul>
                      <li>Session duration: 30 minutes</li>
                      <li>Intensity: MVPA = 3.5 MET/h; LPA= 2 MET/h; VPA= 7 MET/h</li>
                      </ul>"))
                    )))
             )
           )
    )
  ),
  
  fluidRow(
    
    column(width = 5, offset= 1 ,downloadButton('downloadDatascC', 'Download Scenario C CSV Data') ),
    column(width = 5,downloadButton('downloadDatascD', 'Download Scenario D CSV Data') )
    
  ),
  fluidRow(
    column(width = 12, br())
  ),
  
  fluidRow(
    column(width = 12,
           DT::dataTableOutput("summaryDT"),
           includeHTML("helpMET.html")
    )
    
  ),
  fluidRow(
    column(width = 5, offset= 3,
           
           plotlyOutput("plotMMET")
    )
  ),
  fluidRow(
    column(width = 5, offset = 5,
           downloadButton('downloadMMETData', 'Download Marginal MET Data'))
    
  ),
  fluidRow(
    column(width = 12,
           includeHTML("helpMMET.html")
    )
  )
))