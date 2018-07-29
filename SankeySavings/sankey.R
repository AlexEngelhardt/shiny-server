library(plotly)
library(tidyverse)

nodes <- list(
    ## Incomes
    list(name="Main job", color="blue"),
    list(name="Side hustle", color="red"),
    list(name="Investment income", color="blue"),

    ## Intermediary stages
    list(name="Gross income", color="blue"),

    ## Expenses
    list(name="Income tax (estd.)", color="blue"),
    list(name="Needs", color="blue"),
    list(name="Wants", color="blue"),
    list(name="Savings", color="blue"),

    ## Savings parts
    list(name="ETFs", color="blue"),
    list(name="Cash", color="blue")
)
nodes <- do.call(rbind, lapply(nodes, as.data.frame, stringsAsFactors=FALSE))
nodes <- as.data.frame(nodes)
nodes$id <- 1:nrow(nodes) - 1

flows <- list(
    ## Incomes
    list(from="Main job", to="Gross income", amount=1000),
    list(from="Side hustle", to="Gross income", amount=1000),
    list(from="Investment income", to="Gross income", amount=100),

    ## Intermediary stages
    list(from="Gross income", to="Income tax (estd.)", amount=100),
    
    ## Expenses
    list(from="Gross income", to="Needs", amount=1000),
    list(from="Gross income", to="Wants", amount=100),
    list(from="Gross income", to="Savings", amount=1000),
    
    ## Savings parts
    list(from="Savings", to="ETFs", amount=1000),
    list(from="Savings", to="Cash", amount=1000)
)
flows <- do.call(rbind, lapply(flows, as.data.frame, stringsAsFactors=FALSE))
flows <- as.data.frame(flows)
flows$from_id <- nodes$id[match(flows$from, nodes$name)]
flows$to_id <- nodes$id[match(flows$to, nodes$name)]

p <- plot_ly(
    type = "sankey",
    orientation = "h",

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
    font = list(
      size = 14
    )
)

p

## TODO:
## - Checks that for each node, sum(incoming) == sum(outgoing)
## - Allow percentages instead of money amounts too
