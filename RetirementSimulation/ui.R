library(shiny)
library(tidyverse)

shinyUI(pageWithSidebar(
    
    headerPanel(textOutput("heading"), windowTitle = "Kapitalentwicklung"),
    ## interactive header panel screws with the title in the browser window :(
    ##headerPanel("Kapitalentwicklung"),
    
    sidebarPanel(
        radioButtons("language", label="", choices = c("English", "Deutsch")),
        tags$p(textOutput("config_text")),
        # h3("Misc"),
        uiOutput("uiYears"),
        uiOutput("uiNSimulations"),
        h3(textOutput("economy")),
        uiOutput("uiInflation"),
        uiOutput("uiVolInflation"),
        uiOutput("uiNetReturn"),
        uiOutput("uiVolReturn"),
        h3(textOutput("saving")),
        uiOutput("K0"),
        uiOutput("uiMonthlySavings"),
        uiOutput("uiMonthlySavingsIncrease")
        ## actionButton("go", "Go!", icon=icon("refresh"))
    ),
    
    mainPanel(
        tabsetPanel(
            tabPanel("Plots",
                     plotOutput("cap_plot"),
                     tags$p(textOutput("explain_cap_plot")),
                     tags$br(),
                     tags$hr(),
                     tags$br(),
                     plotOutput("final_hist"),
                     tags$p(textOutput("explain_final_hist"))
            ),
            tabPanel("Info",
                     tags$p(htmlOutput("info"))
                     )
        )
    )
    
))
