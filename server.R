library(RODBC)
library(shiny)
library(DT)
library(xlsx)




myServer <- "tcp:cavvjwxz95.database.windows.net"
myUser <- "OfficeManager@cavvjwxz95"
myPassword <- "Steven1+1"
myDatabase <- "OfficeManager"
myDriver <- "{SQL Server Native Client 10.0}"


# return the connection 
connection <- function(myServer,myUser, myPassword,myDatabase,myDriver){
  
  
  connectionString <- paste0(
    "Driver=", myDriver, 
    ";Server=", myServer, 
    ";Database=", myDatabase, 
    ";Uid=", myUser, 
    ";Pwd=", myPassword)
  
  conn <- odbcDriverConnect(connectionString)
  return(conn)
}





# Define server logic requir
shinyServer(function(input, output) {
  
  
  output$enquiryTable <- renderText({
    paste("You have selected", input$var)

  })
  
  date <- renderText({
    input$val
    })
  
  sqlEnquiryStatement <-sprintf<-("select firstname, lastname, enquiryjourneys.reference,motorhomecampers.name,enquiryjourneys.date as enquiryDate,travelpickupdate,traveldropoffdate, bookingconfirmationDate, generalcountries.name as CountryName from enquiryJourneys inner join customercustomers on customercustomers.id= enquiryJourneys.customerId inner join customermembers on customermembers.customerid = customercustomers.id inner join enquirybookings on enquirybookings.journeyId = enquiryjourneys.id inner join generalcountries on customercustomers.countryId = generalcountries.Id inner join enquirycampers on enquirycampers.id = enquirybookings.camperid inner join motorhomecampers on enquirycampers.camperid = motorhomecampers.id where statusvalue >=4 and statusvalue <=32 and enquiryjourneys.date >'2/08/2015'   and isNegate =0 ") 
  
  
 
  
  
  connect <- connection(myServer,myUser, myPassword,myDatabase,myDriver)
 
  
  rawData <-sqlQuery(connect,sqlEnquiryStatement)
  
  odbcClose(connect)
  
  output$selection <- renderText({
    paste("you have selected", input$range[1], "to", input$range[2])
  
  })
 
  output$enquiryTable <- DT::renderDataTable(rawData, options = list(lengthChange = FALSE))
 
  
  output$downloadData <- downloadHandler("filtered.data.xlsx", content = function(file) {
    rows <- input$table_rows_all
    write.table(rawData[rows, ], file)
  })
  
  output$downloadData <- downloadHandler(filename = function() {paste(Sys.time(), ' Fltered_data.csv', sep='')}, content = function(file) {write.csv(i[input$table_rows_all, ], file, row.names = FALSE)})
  
  
  #output$downloadData <- downloadHandler(
   # filename = function() { paste(input$dataset, '.csv', sep='') },
#content = function(file) {
  #    write.csv(datasetInput(), file)
   # }
  #)
  
  
})



