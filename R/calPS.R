#' given a root node, return the PS list of all internal nodes
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param traits character
#' @param cost matrix
#' @param nTip integer
#' @param node integer
#' @param psList list
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a list of vector
#' @export

calPS <- function(tree, data, traits, cost, nTip, node, psList=NULL, ...){

  s.all <- vector(mode="numeric", length=nrow(cost))

  if(is.null(psList)) psList <- list()

  for(j in tree$edge[tree$edge[,1] == node, 2]){
    if(j > nTip){
      psList <- calPS(tree, data, traits, cost, nTip, j, psList)
      s <- psList %>% tail(., n=1) %>% .[[1]]
    }else{
      tipLabel <- j %>% tree$tip.label[.]
      trait <- data[data[,1] == tipLabel, 2]
      s <- ( traits != trait ) %>% as.integer()
      s[s==1] <- Inf
    }
    s.add <- vector(mode="numeric", length=nrow(cost))
    for(i in 1:length(s.add)){
      s.add[i] <- min(s+cost[,i])
    }
    s.all <- s.all + s.add
  }
  l <- s.all %>% list()
  names(l) <- node
  psList <- c(psList, l)

  return(psList)

}
