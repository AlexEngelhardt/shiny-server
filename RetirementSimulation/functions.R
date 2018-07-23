# debug-values for programming

## input <- list()
## input$Betrachtungszeitraum <- 30
## input$n_sim <- 250

## input$inflation <- 1.8
## input$vol_inflation <- 1.5
## input$net_return <- 6
## input$vol_return <- 10

## input$K0 <- 85
## input$monthly_savings <- 2000
## input$monthly_savings_increase <- 3

capital_growth <- function(input){
  n <- input$Betrachtungszeitraum
  
  result <- as.data.frame(matrix(0, nrow=n+1, ncol=input$n_sim))
  result[1,] <- input$K0*1000
  result$year <- 0:n
  
  for(i in 1:input$n_sim){
    df <- data.frame(year = 1:n)
    df$inflation <- rnorm(n, mean=input$inflation, sd=input$vol_inflation)
    df$net_return <- rnorm(n, mean=input$net_return, sd=input$vol_return)
    df$monthly_savings <- input$monthly_savings * (1+(input$monthly_savings_increase/100))^(0:(n-1))
    
    df$K_start <- c(input$K0*1000, rep(NA, n-1))
    df$K_end <- NA
    for(y in 1:n){
      savings <- df$monthly_savings[y]
      interest <- 1 + df$net_return[y]/100
      
      savings_this_year <- sum(savings * interest^((1:12)/12))  # this is yearly accmulated monthly saved amount plus interest
      df$K_end[y] <- df$K_start[y]*interest + savings_this_year
      if(y<n){
        df$K_start[y+1] <- df$K_end[y]
      }
    }
    df$K_end_corrected <- df$K_end * cumprod(1 - df$inflation/100)
    
    result[2:(n+1),i] <- df$K_end_corrected
  }
  
  return(result)
}

# res <- capital_growth(input)

