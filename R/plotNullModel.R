#' create the vector of p.value
#' @importFrom magrittr %>%
#' @import utils
#' @import ggplot2
#'
#' @param obs vector
#' @param nullM matrix
#' @param P vector
#' @param node numeric
#' @param bw numeric
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a plot
#' @export

plotNullModel <- function(obs, nullM, P, node, bw, ...){

  o <- node %>% as.character() %>% obs[[.]]
  nullm <- (as.character(node) == names(obs)) %>% nullM[,.]
  df <- data.frame(ai=c(o, nullm))
  p <- node %>% as.character() %>% P[[.]]

  g <- ggplot(df, aes(x=ai)) + #for variables: aes_string(x=node)
    geom_histogram(binwidth=bw) +
    geom_vline(xintercept=o, lty=2, col="red") +
    xlab("Association Index") +
    ylab("Count") +
    labs(title=paste0("subtree extended by node_", node, "; p.value: ", p)) +
    theme(
      plot.title = element_text(color="red", size=14, face="bold.italic"),
      axis.title.x = element_text(color="blue", size=14, face="bold"),
      axis.title.y = element_text(color="#993333", size=14, face="bold"),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_blank(),
      axis.line = element_line(colour = "black")
    )

  g

}
