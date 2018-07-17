library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Kapitalentwicklung"),

  sidebarPanel(
    tags$p("Konfigurieren Sie die Parameter, um interaktive MCMC-Simulationen zu erhalten."),
    h3("Misc"),
    sliderInput("Betrachtungszeitraum", "Betrachtungszeitraum in Jahren", min=1, max=100, value=30, step=1),
    sliderInput("n_sim", "Anzahl der Simulationen", min=10, max=200, value=100, step=5),
    h3("Wirtschaft"),
    sliderInput("inflation", label = "jährl. Inflation in %", min = 0, max = 10, value = 1.8, step=0.1),
    sliderInput("vol_inflation", label = "Volatilität der Inflation in %", min = 0, max = 10, value = 1.5, step=0.1),
    sliderInput("net_return", label = "jährl. Nachsteuerrendite in %", min = 0, max = 10, value = 5, step=0.25),
    sliderInput("vol_return", label = "Volatilität der Rendite in %", min = 0, max = 10, value = 7, step=0.25),
    h3("Sparen"),
    sliderInput("K0", label = "Startkapital in k€", min = 0, max = 1000, value = 10, step=10),
    sliderInput("monthly_savings", label = "monatlicher Sparbetrag", min=0, max=5000, value = 200, step=100),
    sliderInput("monthly_savings_increase", label = "jährlicher Anstieg des Sparbetrags in Prozent", min=0, max=20, value = 3, step=0.25)
    # actionButton("go", "Go!", icon=icon("refresh"))
  ),
  
  mainPanel(
    plotOutput("cap_plot"),
    tags$br(),
    tags$hr(),
    tags$br(),
    plotOutput("final_hist")	
  )
  
))
