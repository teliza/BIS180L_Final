library(shiny)
library(ggplot2)

counts <- (read.csv("GxE_Internode_Counts.csv",row.names=1))

#(Taken as reference from may18 lab)
#gt=regmatches(colnames(counts),regexpr("R500|IMB211",colnames(counts)))
#trt=regmatches(colnames(counts),regexpr("NDP|DP",colnames(counts)))

shinyServer(function(input, output) {
  
  output$GenePlot <- renderPlot({

    #after melting, I converted the columns into smaller columns so I can facet by individual types.
    #"t" for table
    t=counts.melt
    t2 = t[t$Var1 %in% input$gene,]
    t2$genotype<-regmatches(t2$Var2,regexpr("R500|IMB211",t2$Var2))
    t2$trt<-regmatches(t2$Var2,regexpr("NDP|DP",t2$Var2))
    t2$rep<-regmatches(t2$Var2,regexpr("REP1|REP2|REP3",t2$Var2))
    
    #finally plotting the data with new columns
    pl <- ggplot(data=t2, aes_string(x="rep", y="value", fill="trt")) 
    pl + geom_bar(stat="identity") + facet_grid(t2$genotype ~ t2$trt) +ylab("RNAseq Read Counts") +xlab("")+ggtitle(input$gene)
    
  })
  
})