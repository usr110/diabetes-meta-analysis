source("setup.R")
choices = c ("Scenario A", "Scenario B", "Scenario C", "Scenario D")
shinyUI(fluidPage(
  useShinyjs(),
  width="100%", height="100%",
  sidebarPanel(
    selectInput(inputId = "inSc", label = "Select a Scenario:", choices =  choices)  
    ),
  mainPanel(
    tabsetPanel(
      tabPanel("Meta Analysis",
#                a(id = "MSHelp", "Help?", href = "#"),
#                hidden (div(id = "MSHelpText",
#                            helpText(HTML("Displays plots for mode share of trips based on main mode only. A scenario is selected by a combination of 
#                                          three inputs: Cycling Multiplier, Equity and Ebike. Users can choose to compare mode share between selected 
#                                          sub-populations and the total population, and/or between selected scenarios and baseline."))
#                )),
               showOutput("plotMetaAnalysis", "morris")
      )
    )
  )
))

# shinyUI(
#   navbarPage(
#     title = "Transport Hackathon - Carplus", id="nav",
#     tabPanel(
#       "Interactive map",
#       div(
#         class="outer",
#         br(),
#         leafletOutput("map")#, width="100%", height="95%")
#         
#       )
#     )
#   )
# )