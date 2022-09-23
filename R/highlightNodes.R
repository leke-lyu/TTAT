#' highlight nodes
#' @importFrom magrittr %>%
#' @import utils
#' @import RColorBrewer
#' @import ggplot2
#'
#' @param tree phylo
#' @param data data.frame
#' @param P vector
#' @param p_value numeric
#' @param pointSize numeric
#' @param highlightSize numeric
#' @param highlightColor character
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a plot
#' @export

highlightNodes <- function(tree, data, P, p_value, pointSize, highlightSize, highlightColor, ...){

  traitName <- data %>% colnames() %>% .[2]
  highlighted <- P[P < p_value] %>% names() %>% as.integer()

  p <- ggtree::ggtree(tree) +
    ggtree::geom_treescale()
  p <- p %<+% data +
    ggtree::geom_tippoint(aes_string(color=traitName), size=pointSize, alpha=1) +
    scale_color_brewer(palette="Set2") +
    ggtree::theme(legend.title = element_blank(),
          legend.key = element_blank()) +
    ggtree::geom_point2(aes(subset=(node %in% highlighted)), shape=21, size=highlightSize, fill=highlightColor)

  return(p)

}
