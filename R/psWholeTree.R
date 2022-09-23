#' wrapper function to calculate PS of all internal nodes
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param cost matrix
#' @param ... further arguments passed to or from other methods
#'
#' @return Return the PS of all internal nodes as a vector
#' @export

psWholeTree <- function(tree, data, cost, ...){

  node <- setdiff(tree$edge[,1], tree$edge[,2])
  nTip <- tree$tip.label %>% length()
  traits <- as.factor(data[,2]) %>% attributes() %>% .$levels

  mylist <- calPS(tree, data, traits, cost, nTip, node)
  lapply(mylist, min) %>% unlist

}
