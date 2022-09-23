#' present the frequency of traits by pie chart
#' @importFrom magrittr %>%
#' @import utils
#' @import ggimage
#' @import RColorBrewer
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

plotFrequencyOfTraits <- function(tree, data, pointSize, wt, ht, ...){

  frequencyList <- list()
  node <- setdiff(tree$edge[,1], tree$edge[,2])
  nTip <- tree$tip.label %>% length()
  traits <- as.factor(data[,2]) %>% attributes() %>% .$levels
  frequencyList <- frequencyOfTraits(tree, data, nTip, traits, node, frequencyList)

  statsList <- lapply(frequencyList, function(i){
    sum <- sum(i)
    i <- i/sum
  })
  dat <- statsList %>% as.data.frame() %>% t() %>% as.data.frame()
  colnames(dat) <- traits
  rownames(dat) <- NULL
  dat$node <- frequencyList %>% attributes() %>% .[[1]] %>% as.integer()

  c <- traits %>% length() %>% brewer.pal(., name="Set2")
  #bars <- nodebar(dat, cols=1:length(traits), color=c)
  pies <- ggtree::nodepie(dat, cols=1:length(traits), color=c)
  #p1 <- inset(p0, bars, width=.04, height=.1)
  p0 <- plotTreeWithTrait(tree, data, pointSize)
  p1 <- ggtree::inset(p0, pies, width=wt, height=ht)

  return(p1)
}
