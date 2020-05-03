
#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
Sys.setlocale("LC_ALL","English")
library(dplyr)
library(shiny)
library(tidyquant)
library(lubridate)
library(tibble)
library(ggplot2)
library(rsconnect)

shinyServer(function(input, output) {
  
  
  start<-as.Date("2019-05-01")
  end<-as.Date("2020-05-01")
  start_zoom<- (end-weeks(20))
  
  dataInput <- reactive({
    
    
    FB <- tq_get("FB", get = "stock.prices", from = start, to = end)
    FB <-add_column(FB)
    AMZN <- tq_get("AMZN", get = "stock.prices", from = start, to = end)
    AMZN<-add_column(AMZN)
    AAPL <- tq_get("AAPL", get = "stock.prices", from = start, to = end)
    AAPL<-add_column(AAPL)
    NFLX <- tq_get("NFLX", get = "stock.prices", from = start, to = end)
    NFLX<-add_column(NFLX)
    GOOG  <- tq_get("GOOG" , get = "stock.prices", from = start, to = end)
    GOOG<-add_column(GOOG)
    UBER <- tq_get("UBER", get = "stock.prices", from = start, to = end)
    UBER<-add_column(UBER)
    
    data<-bind_rows(FB,AMZN,AAPL,NFLX,GOOG,UBER)
  })
  
  
  
  output$distPlot <- renderPlot({
    data<-dataInput()
    n1<-input$n1
    n2<-input$n2
    
    data %>%
      # filter(date >= start - days(2 * 50)) %>%
      ggplot(aes(x = date, y = close, volume = volume, group = symbol)) +
      geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
      geom_ma(ma_fun = VWMA, n=n1, wilder = TRUE, linetype = 5) +
      geom_ma(ma_fun = VWMA, n=n2, wilder = TRUE, color = "red") + 
      labs(title = "Tech Stocks Perfromances vs VMWA", 
           y = "Closing Price", x = "") + 
      coord_x_date(xlim = c(start_zoom, end)) +
      facet_wrap(~ symbol, ncol = 2, scales = "free_y") + 
      theme_tq()
    
  })
  
})