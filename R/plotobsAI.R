#' present the frequency of traits by pie chart
#' @importFrom magrittr %>%
#' @importFrom magrittr %<>%
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param obs vector
#' @param pointSize numeric
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a plot
#' @export

plotobsAI <- function(tree, data, obs, pointSize, ...){

  dat <- data.frame(AssociationIndex=obs)
  dat$AssociationIndex %<>% round(., 2)
  dat$node <- data.frame(obs) %>% row.names() %>% as.integer()

  p0 <- plotTreeWithTrait(tree, data, pointSize)
  p1 <- p0 %<+% dat + ggtree::geom_nodelab(aes(label=AssociationIndex), geom = "label")

  return(p1)

}
