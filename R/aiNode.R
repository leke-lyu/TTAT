#' wrapper function to calculate AI index of a given node
#' @import magrittr
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param node integer
#' @param ... further arguments passed to or from other methods
#'
#' @return Return the AI index of a given node
#' @export

aiNode <- function(tree, data, node, ...){

  frequencyList <- list()
  nTip <- tree$tip.label %>% length()
  traits <- as.factor(data[,2]) %>% attributes() %>% .$levels

  frequencyList <- frequencyOfTraits(tree, data, nTip, traits, node, frequencyList)
  statsList <- lapply(frequencyList, function(i){
    sum <- sum(i)
    max <- max(i)
    (1-max/sum)/(2^(sum-1))
  })

  Reduce(`+`, statsList) %>% return()

}
