library(shiny)
library(tidyverse)
library(scales)  # for labels=comma in ggplot axis

source("functions.R")
dictionary <- read_csv("dictionary.csv")

shinyServer(function(input, output) {

    tr <- function(key_arg){
        ## Translator, using dictionary.csv
        dictionary %>%
            filter(key == key_arg) %>%
            pull(input$language)
    }
    
    res <- reactive({
        req(input$Betrachtungszeitraum)  # otherwise "NA" error for first second of app
        capital_growth(input)
    })

    output$cap_plot <- renderPlot({
        result <- res()
        to_plot <- gather(result, key="n_sim", value="money", -year)

        ggplot(to_plot) + geom_line(aes(x=year, y=money, group=n_sim), alpha=0.12) +
            scale_x_continuous(tr("year")) +
            scale_y_continuous(tr("capital_today"), labels=comma, limits=c(0, NA)) +
            ggtitle(tr("mcmc_simulations"))
    })

    output$final_hist <- renderPlot({
        result <- res()
        final_fortune <- data.frame(fortune=as.numeric(result[input$Betrachtungszeitraum, 1:input$n_sim]))

        ggplot(final_fortune) + geom_histogram(aes(x=fortune), bins=30) +
            scale_x_continuous(tr("capital_today"), labels=comma) +
            scale_y_continuous(tr("n")) +
            ggtitle(tr("final_capital"))
    })

    ################################################################
    ## UI elements
    ## (I render UI in the server for the multilingual stuff to work)
    
    output$uiYears <- renderUI({
        sliderInput("Betrachtungszeitraum",
                    tr("years"),
                    min=1, max=100, value=30, step=1)
    })
    output$uiNSimulations <- renderUI({
        sliderInput("n_sim",
                    tr("n_simulations"),
                    min=10, max=200, value=100, step=5)
    })
    output$uiInflation <- renderUI({
        sliderInput("inflation",
                    label = tr("inflation"),
                    min = 0, max = 10, value = 1.8, step=0.1)
    })
    output$uiVolInflation <- renderUI({
        sliderInput("vol_inflation",
                    label = tr("vol_inflation"),
                    min = 0, max = 10, value = 1.5, step=0.1)
    })
    output$uiNetReturn <- renderUI({
        sliderInput("net_return",
                    label = tr("net_return"),
                    min = 0, max = 10, value = 5, step=0.25)
    })
    output$uiVolReturn <- renderUI({
        sliderInput("vol_return",
                    label = tr("vol_return"),
                    min = 0, max = 10, value = 7, step=0.25)
    })
    output$K0 <- renderUI({
        sliderInput("K0",
                    label = tr("K0"),
                    min = 0, max = 1000, value = 10, step=10)
    })
    output$uiMonthlySavings <- renderUI({
        sliderInput("monthly_savings",
                    label = tr("monthly_savings"),
                    min=0, max=5000, value = 200, step=100)
    })
    output$uiMonthlySavingsIncrease <- renderUI({
        sliderInput("monthly_savings_increase",
                    label = tr("monthly_savings_increase"),
                    min=0, max=20, value = 3, step=0.25)
    })

    output$economy <- renderText(tr("economy"))
    output$saving <- renderText(tr("saving"))
    output$config_text <- renderText(tr("config_text"))
    output$heading <- renderText(tr("heading"))
    output$explain_cap_plot <- renderText(tr("explain_cap_plot"))
    output$explain_final_hist <- renderText(tr("explain_final_hist"))

})
