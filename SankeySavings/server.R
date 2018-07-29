library(shiny)
library(plotly)
library(colorspace)

source("functions.R")
sample_csv <- paste(readLines("sample_input.csv"), collapse="\n")

shinyServer(function(input, output) {

    output$csv_textarea <- renderUI({
        textAreaInput("input_csv",
                      "CSV text of cashflows:",
                      rows=20,
                      value=sample_csv)
    })
    
    output$sankeyChart <- renderPlotly({
        
        req(input$input_csv)
        
        nodes_flows <- csv_to_lists(input$input_csv)
        nodes <- nodes_flows$nodes
        flows <- nodes_flows$flows
        
        p <- plot_ly(
            type = "sankey",
            orientation = "h",
            height = 600,

            node = list(
                label = nodes$name,
                color = nodes$color,
                pad = 15,
                thickness = 20,
                line = list(
                    color = "black",
                    width = 0.5
                )
            ),

            link = list(
                source = flows$from_id,
                target = flows$to_id,
                value =  flows$amount
            )
        ) %>%
    layout(
        title = "Cashflow diagram",
        font = list(size = 14)
    )

        p

    })

})
