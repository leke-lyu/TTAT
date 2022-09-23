#' present the result of GrowingP
#' @importFrom magrittr %>%
#' @import utils
#' @import ggplot2
#'
#' @param obs vector
#' @param nullM matrix
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a plot
#' @export

plotGrowingP <- function(obs, nullM, ...){

  gP <- growingP(obs, nullM)
  node <- names(obs) %>% sort() %>% .[1]
  df <- data.frame(rep=c(2:nrow(nullM)), pValue=gP[,(names(obs)==node)])
  p <- ggplot(df, aes(x = rep, y = pValue)) + geom_line()

  return(p)

}
