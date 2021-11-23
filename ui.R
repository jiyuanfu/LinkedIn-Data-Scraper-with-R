library(shiny)
library(rsconnect)
library(readr)
# Define UI for app
ui <- shinyUI(fluidPage(
  
  # Fluid pages scale their components in realtime to fill all available browser width
  # titlePanel: create a header panel containing an application title
  titlePanel("LinkedIn Data Scraper"),
  
  wellPanel(
    p("Please enter your LinkedIn username and password."),
    p("When finished, you can download scoring result table as csv file.")
  ),
  
  # SidebarLayout():create a layout with a sidebar and main area
  sidebarLayout(
    
    sidebarPanel(
      
      #Inupt
      textInput("username", label = ("Your LinkedIn Username"), value = "Enter the username"),
      textInput("password", label = ("Your LinkedIn Password"), value = "Enter the password"),
      textInput("skillname", label = ("Skills you are looking for"), value = "Enter the skillname"),
      #textInput("n", label = ("Number of candidates"), value = 10),
      selectInput("n", label = ("Number of candidates"), choices = c(10,20,30,40,50,60,70,80,90,100)),
      
      actionButton("go","Get"),
      
      downloadButton("downloadData", "Download Resume"),
    ),
    
    mainPanel(
      tabsetPanel(
        #Create Scoring Results tab panel
        tabPanel(
          "Scoring Results",
          tableOutput("summary")
        )
      )
    )
  )))