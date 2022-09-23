#' given a node, return all the tips under this node
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param nTip integer
#' @param node integer
#' @param tipsVector character
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a vector of character
#' @export

tipsUnderNode <- function(tree, node, nTip, tipsVector=NULL, ...){

  if(is.null(tipsVector)) tipsVector <- c()

  for(j in tree$edge[tree$edge[,1] == node, 2]){
    if(j > nTip){
      tipsVector <- tipsUnderNode(tree, j, nTip, tipsVector)
    }else{
      tip <- j %>% tree$tip.label[.]
      tipsVector <- c(tipsVector, tip)
    }
  }

  return(tipsVector)

}
