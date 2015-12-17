library(RODBC)
library(shiny)



shinyUI(fluidPage(
  titlePanel("Global Camper Statistics App"),
  sidebarLayout(
    sidebarPanel(
      h3("Control Bars"),
     
      selectInput("var", 
                  label = "Choose a country to display booking",
                  choices = c("All", "New Zealand",
                              "Australia", "Canada"),
                  selected = "canada"),
      
      sliderInput("range", 
                  label = "Hire duration:",
                  min = 0, max = 200, value = c(0, 200)),
      dateInput("pickUpDate","pick Up date", format = "yyyy-mm-dd",value = '2015-12-11'),
      dateInput("dropOffDate","Drop off date", format = "yyyy-mm-dd",value = '2015-12-11'),
      downloadButton('downloadData', 'Download to excel'),
      
   
      br(),
      br(),
      br(),
      img(src = "logo.png", height = 'auto', width = 'auto')
      
    ),
    mainPanel(
     
    
      
        
      br(),
     
      h2("Customer Tables"),
      textOutput("selection"),
      dataTableOutput("enquiryTable")
      
    )
  )
))
