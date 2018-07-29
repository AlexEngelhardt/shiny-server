csv_to_lists <- function(csv_text){
    require(colorspace)
    
    flows <- read.csv(text = csv_text, comment.char="#", header=FALSE,
                      col.names=c("from", "to", "amount"),
                      stringsAsFactors=FALSE)

    nodes <- data.frame(
        name = unique(c(flows$from, flows$to))
    )
    
    #nodes$color = 'blue'
    nodes$color = rainbow_hcl(nrow(nodes))
    
    nodes$id = 1:nrow(nodes) - 1

    flows$from_id <- nodes$id[match(flows$from, nodes$name)]
    flows$to_id <- nodes$id[match(flows$to, nodes$name)]
    
    return(list(
        nodes=nodes,
        flows=flows
    ))
}
