#' Taking a tree, the trait data, the number of tips, and trait categories as the input, this function returns the proportion of traits under an interesting clade.
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param nTip integer
#' @param traits character
#' @param node integer
#' @param frequencyList list of integer
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a list
#' @export

frequencyOfTraits <- function(tree, data, nTip, traits, node, frequencyList=NULL, ...) {

  if(is.null(frequencyList)) frequencyList <- list()
  l <- list()
  for(j in tree$edge[tree$edge[,1] == node, 2]){
    if(j > nTip){
      frequencyList <- frequencyOfTraits(tree, data, nTip, traits, j, frequencyList)
      l <- frequencyList %>% tail(., n=1) %>% c(l, .)
    }else{
      tipLabel <- j %>% tree$tip.label[.]
      trait <- data[data[,1] == tipLabel, 2]
      l <- ( traits == trait ) %>% as.integer() %>% list() %>% c(l, .)
    }
  }
  list <- Reduce(`+`, l) %>% list()
  names(list) <- node
  frequencyList <- c(frequencyList, list)
  return(frequencyList)

}
