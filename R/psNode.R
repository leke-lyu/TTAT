#' calculate the parsimony score statistic of a given node
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param traits character
#' @param cost matrix
#' @param nTip integer
#' @param node integer
#' @param ... further arguments passed to or from other methods
#'
#' @return Return the PS vector of a given node
#' @export

psNode <- function(tree, data, traits, cost, nTip, node, ...){

  s.all <- vector(mode="numeric", length=nrow(cost))

  for(j in tree$edge[tree$edge[,1] == node, 2]){
    if(j > nTip){
      s <- psNode(tree, data, traits, cost, nTip, j)
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

  return(s.all)

}
