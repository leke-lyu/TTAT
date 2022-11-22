#' Taking a tree, the trait data, the number of tips, and trait categories as the input, this function returns the AI of an interesting clade.
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param nTip integer
#' @param traits character
#' @param node integer
#' @param ... further arguments passed to or from other methods
#'
#' @return Return the AI index of a given node
#' @export

aiNode <- function(tree, data, nTip, traits, node, ...){

  frequencyList <- frequencyOfTraits(tree, data, nTip, traits, node)
  statsList <- lapply(frequencyList, function(i){
    sum <- sum(i)
    max <- max(i)
    (1-max/sum)/(2^(sum-1))
  })
  Reduce(`+`, statsList) %>% return()

}
