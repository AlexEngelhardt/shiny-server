library(shiny)
library(plotly)

shinyUI(pageWithSidebar(

    headerPanel("Sankey Charts!"),

    sidebarPanel(

        uiOutput('csv_textarea'),

        # submitButton("Update plot"),

        tags$p("TODOs"),
        tags$ul(
                 tags$li("Checks that for each node, sum(incoming) == sum(outgoing)"),
                 tags$li("Allow percentages instead of money amounts too"),
                 tags$li("two Action buttons that load simple and complex sample data"),
                 tags$li("Node colors less chaotic, either per layer or just a less random rainbow_hsv")
             )
        ),

    mainPanel(
        plotlyOutput("sankeyChart"),
        tags$p(tags$a("Sankey Charts",
                      href="https://en.wikipedia.org/wiki/Sankey_diagram"),
               " can visualize the flow of numerical values, which makes them ",
               "very applicable to personal finance themes. ",
               "There is already a webapp called ",
               tags$a("SankeyMATIC", href="http://sankeymatic.com/build/"),
               "out there, but I wanted to implement a Shiny version."
               )
    )
))
