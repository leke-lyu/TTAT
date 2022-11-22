#' The function colors the tips by their associated traits.
#' @importFrom magrittr %>%
#' @import utils
#' @import ggplot2
#' @import ggtree
#' @import RColorBrewer
#' @importFrom grDevices colorRampPalette
#'
#' @param tree phylo
#' @param data data.frame
#' @param pointSize numeric
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a plot
#' @export

plotTreeWithTrait <- function(tree, data, pointSize=2, ...){

  traitName <- data %>% colnames() %>% .[2]
  traits <- data[,2] %>% as.factor() %>% attributes() %>% .$levels
  mycolors <- colorRampPalette(brewer.pal(8, "Set2"))(length(traits))

  p <- ggtree(tree) +
    geom_treescale()
  p <- p %<+% data +
    geom_tippoint(aes_string(color=traitName), size=pointSize, alpha=1) +
    scale_color_manual(values = mycolors) +
    theme(legend.title = element_blank(),
          legend.key = element_blank())

  p

}
