# Run the setup file which loads all the packages and required data
source("setup.R")

# Create a list of scenarios
choices = c ("Scenario A", "Scenario B", "Scenario C", "Scenario D")

shinyUI(fluidPage(
  useShinyjs(),
  tags$h2("Diabetes Meta Analysis"),
  fluidRow(
    column(width = 6,
           p("This Shiny app is used to display meta analysis of Physical Activity and Type 2 Diabetes"),
           p("Source code:",
             a(href="https://github.com/usr110/diabetes-meta-analysis", "@usr110/diabetes-meta-analysis", target="_blank"))
    )
  ),
  fluidRow(
    column(width = 6,
           plotlyOutput("plotScenarioA")
    ),
    column(width = 6,
           plotlyOutput("plotScenarioB")
    )
  ),
  
  
  fluidRow(
    
    column(width = 6,downloadButton('downloadDatascA', 'Download Scenario A CSV Data') ),
    column(width = 6,downloadButton('downloadDatascB', 'Download Scenario B CSV Data') )
  ),
  
  
  fluidRow(
    column(width = 6,
           plotlyOutput("plotScenarioC")
    ),
    column(width = 6,
           plotlyOutput("plotScenarioD")
    )
  ),
  
  fluidRow(
    
    column(width = 6,downloadButton('downloadDatascC', 'Download Scenario C CSV Data') ),
    column(width = 6,downloadButton('downloadDatascD', 'Download Scenario D CSV Data') )
    
  ),
  fluidRow(
    column(width = 12, br())
  ),
  
  fluidRow(
    column(width = 12,
           a(id = "help", "Help?", href = "#"),
           (div(
             id = "helpText",
             DT::dataTableOutput("summaryDT"),
             helpText(HTML("LTPA converted to MET.hr per week with results pooled in a two stage 
                           random effects model. RRs were derived from a common lowest physical activity category within 
                           each study. Listed exposure levels were chosen to represent meaningful and easy to interpret 
                           PA volumes equivalent to the following: 30 min of MVPA; 1 hour of MVPA; Rounded value to 
                           allow for comparison with GLS PA exposure increment; 150 minutes of PA/current recommended 
                           guidelines; double the recommended guidelines and two high PA exposure levels investigating 
                           the risk reductions at the higher end of the LTPA spectrum. The bold line indicates the 
                           pooled restricted cubic spline model and the black dashed line indicates the 95% 
                           confidence intervals of the pooled curve. Duration assumption was necessary in 9 out of 27 
                           observation (applied as 45 min/session in Scenarios A and C; and 30 min/session in Scenarios 
                           B and D), and intensity assumption was necessary in 15 out of 27observations (applied as LPA=3 MET, 
                           MVPA=4.5MET, and VPA=8 MET in Scenarios A and B; and LPA=2 MET, MVPA=3.5MET, 
                           and VPA=7 MET in Scenarios C and D)."))
             
           ))
    )
  )
))