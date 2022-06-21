#' present the input data
#' @import magrittr
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param pointSize numeric
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a plot
#' @export

plotTreeWithTrait <- function(tree, data, pointSize, ...){

  traitName <- data %>% colnames() %>% .[2]

  p <- ggtree::ggtree(tree) +
    ggtree::geom_treescale()
  p <- p %<+% data +
    ggtree::geom_tippoint(aes_string(color=traitName), size=pointSize, alpha=1) +
    #scale_color_brewer(palette="Set2") +
    ggtree::theme(legend.title = element_blank(),
          legend.key = element_blank())

  p

}
