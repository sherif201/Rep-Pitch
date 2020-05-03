#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Plotting Volumetric Wighted Moving Averages Curves"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      h5("Select the number of periods for the two volumetric moving averages"),
      sliderInput("n1",
                  "Period 1:",
                  min = 5,
                  max = 100,
                  value = 20),
      
      sliderInput("n2",
                  "Period 2:",
                  min = 5,
                  max = 100,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        
      plotOutput("distPlot")
    
  
))))