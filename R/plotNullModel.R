#' The function plots the null distribution.
#' @importFrom magrittr %>%
#' @import utils
#' @import ggplot2
#'
#' @param res matrix
#' @param node numeric
#' @param bw numeric
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a plot
#' @export

plotNullModel <- function(res, node=NULL, bw=0.1, ...){

  P <- p.value(res)
  if(is.null(node)) node <- attributes(res)$root
  p <- node %>% as.character() %>% P[[.]] #p-value
  obs <- res[1, colnames(res)==node]
  df <- data.frame(nullM=res[, colnames(res)==node])
  if(attributes(res)$m == "AI"){
    g <- ggplot(df, aes(x=nullM)) + #for variables: aes_string(x=node)
    geom_histogram(binwidth=bw) +
    geom_vline(xintercept=obs, lty=2, col="red") +
    xlab("Association Index") +
    ylab("Count") +
    labs(title=paste0("subtree extended by node", node, "; p.value: ", p, "; AI: ", obs))
  }else{
    dfCount <- table(df$nullM) %>% data.frame()
    g <- ggplot(dfCount, aes(x=Var1, y=Freq)) +
      geom_bar(stat="identity") +
      geom_vline(xintercept=which(dfCount$Var1==obs), lty=2, col="red") +
      xlab("Parsimony Score") +
      ylab("Count") +
      labs(title=paste0("subtree extended by node", node, "; p.value: ", p, "; PS: ", obs))
  }
  g + theme(
    plot.title = element_text(color="red", size=14, face="bold.italic"),
    axis.title.x = element_text(color="blue", size=14, face="bold"),
    axis.title.y = element_text(color="#993333", size=14, face="bold"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_blank(),
    axis.line = element_line(colour = "black")
    )

}
