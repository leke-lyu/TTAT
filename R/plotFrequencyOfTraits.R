#' The function presents the frequency of traits in all internal nodes by pie chart.
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
#' @param wt numeric
#' @param ht numeric
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a plot
#' @export

plotFrequencyOfTraits <- function(tree, data, pointSize=2, wt=0.08, ht=0.08, ...){

  node <- setdiff(tree$edge[,1], tree$edge[,2])
  nTip <- tree$tip.label %>% length()
  traits <- as.factor(data[,2]) %>% attributes() %>% .$levels

  frequencyList <- frequencyOfTraits(tree, data, nTip, traits, node)
  statsList <- lapply(frequencyList, function(i){
    sum <- sum(i)
    i <- i/sum
  })
  dat <- statsList %>% as.data.frame() %>% t() %>% as.data.frame()
  colnames(dat) <- traits
  rownames(dat) <- NULL
  dat$node <- frequencyList %>% attributes() %>% .[[1]] %>% as.integer()

  mycolors <- colorRampPalette(brewer.pal(8, "Set2"))(length(traits))
  pies <- ggtree::nodepie(dat, cols=1:length(traits), color=mycolors) #bars <- nodebar(dat, cols=1:length(traits), color=c)
  p0 <- plotTreeWithTrait(tree, data, pointSize)
  p1 <- ggtree::inset(p0, pies, width=wt, height=ht) #p1 <- inset(p0, bars, width=.04, height=.1)
  return(p1)

}
