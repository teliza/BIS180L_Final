library(shiny)
library(ggplot2)

counts <- (read.csv("GxE_Internode_Counts.csv",row.names=1))

gt=regmatches(colnames(counts),regexpr("R500|IMB211",colnames(counts)))
trt=regmatches(colnames(counts),regexpr("NDP|DP",colnames(counts)))

shinyServer(function(input, output) {
  
  output$GenePlot <- renderPlot({
    col <- c(
      IMB211_DP_REP1 = "IMB211",
      IMB211_DP_REP2 = "IMB211",
      IMB211_DP_REP3 = "IMB211",
      IMB211_NDP_REP1 = "IMB211",
      IMB211_NDP_REP2 = "IMB211",
      IMB211_NDP_REP3 = "IMB211",
      R500_DP_REP1 = "R500",
      R500_DP_REP2 = "R500",
      R500_DP_REP3 = "R500",
      R500_NDP_REP1 = "R500",
      R500_NDP_REP1 = "R500",
      R500_NDP_REP1 = "R500"
    )
    
    col2 <- c(
      IMB211_DP_REP1 = "DP",
      IMB211_DP_REP2 = "DP",
      IMB211_DP_REP3 = "DP",
      IMB211_NDP_REP1 = "NDP",
      IMB211_NDP_REP2 = "NDP",
      IMB211_NDP_REP3 = "NDP",
      R500_DP_REP1 = "DP",
      R500_DP_REP2 = "DP",
      R500_DP_REP3 = "DP",
      R500_NDP_REP1 = "NDP",
      R500_NDP_REP1 = "NDP",
      R500_NDP_REP1 = "NDP"
    )
    col3 <- c(
      IMB211_DP_REP1 = "REP1",
      IMB211_DP_REP2 = "REP2",
      IMB211_DP_REP3 = "REP3",
      IMB211_NDP_REP1 = "REP1",
      IMB211_NDP_REP2 = "REP2",
      IMB211_NDP_REP3 = "REP3",
      R500_DP_REP1 = "REP1",
      R500_DP_REP2 = "REP2",
      R500_DP_REP3 = "REP3",
      R500_NDP_REP1 = "REP1",
      R500_NDP_REP1 = "REP2",
      R500_NDP_REP1 = "REP3"
    )
    
    t=counts.melt
    t2 = t[t$Var1 %in% input$gene,]
    t2$column<-col[t2$Var2]
    t2$trt<-col2[t2$Var2]
    t2$column3<-col3[t2$Var2]
    print(t2)
    pl <- ggplot(data=t2, aes_string(x="column3", y="value", fill="trt")) 
    pl + geom_bar(stat="identity") + facet_grid(t2$column ~ t2$trt) +ylab("RNAseq Read Counts") +xlab("")+ggtitle(input$gene)
    
  })
  
})
