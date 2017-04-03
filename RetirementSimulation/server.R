library(shiny)
library(tidyverse)

source("functions.R")

shinyServer(function(input, output) {
  
  res <- eventReactive(input$go, {
    capital_growth(input)
  })
  
  output$cap_plot <- renderPlot({
    result <- res()
    to_plot <- gather(result, value="money", key="year")
    colnames(to_plot) <- c("year", "n_sim", "money")
    
    ggplot(to_plot) + geom_line(aes(x=year, y=money, group=n_sim), alpha=0.12) +
      ggtitle("MCMC Simulations")
  })
  
  output$final_hist <- renderPlot({
    result <- res()
    final_fortune <- data.frame(fortune=as.numeric(result[input$Betrachtungszeitraum, 1:input$n_sim]))
    
    ggplot(final_fortune) + geom_histogram(aes(x=fortune), bins=30) +
      ggtitle("Inflation-corrected final fortune")
  })
  
})
