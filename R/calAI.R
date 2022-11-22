#' The function returns the AI of each internal node subtended by an interesting clade.
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param statsList list of double
#' @param nTip integer
#' @param node integer
#' @param aiVector a named vector of numeric
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a named vector of numeric
#' @export

calAI <- function(tree, statsList, nTip, node, aiVector=NULL, ...){

  if(is.null(aiVector)) aiVector <- c()
  value <- 0
  value <- node %>% as.character(.) %>% statsList[[.]] %>% + value
  for(j in tree$edge[tree$edge[,1] == node, 2]){
    if(j > nTip){
      aiVector <- calAI(tree, statsList, nTip, j, aiVector)
      value <- aiVector %>% tail(., n=1) %>% + value
    }
  }
  names(value) <- node
  aiVector <- c(aiVector, value)
  return(aiVector)

}
