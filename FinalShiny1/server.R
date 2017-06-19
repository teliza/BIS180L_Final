
library(shiny)
library(ggplot2)

counts <- as.matrix(read.csv("GxE_Internode_Counts.csv",row.names=1))

# Define server logic required to draw a barplot

shinyServer(function(input, output) {
   
  output$GenePlot <- renderPlot({
    barplot(counts[x=input$gene,],las=3)
  })
  
})
