#' wrapper function to calculate AI index of all internal nodes
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a named vector of numeric
#' @export

aiWholeTree <- function(tree, data, ...){

  node <- setdiff(tree$edge[,1], tree$edge[,2])
  nTip <- tree$tip.label %>% length()
  traits <- as.factor(data[,2]) %>% attributes() %>% .$levels

  frequencyList <- frequencyOfTraits(tree, data, nTip, traits, node)
  statsList <- lapply(frequencyList, function(i){
    sum <- sum(i)
    max <- max(i)
    (1-max/sum)/(2^(sum-1))
  })

  calAI(tree, statsList, nTip, node) %>% return()

}
