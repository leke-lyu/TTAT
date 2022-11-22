#' Taking a tree, the trait data, the number of tips, trait categories and the cost matrix as the input, this function returns the PS vector of an interesting clade.
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param nTip integer
#' @param traits character
#' @param cost matrix
#' @param node integer
#' @param ... further arguments passed to or from other methods
#'
#' @return Return the PS vector of a given node
#' @export

psNode <- function(tree, data, nTip, traits, cost, node, ...){

  s.all <- vector(mode="numeric", length=nrow(cost))
  for(j in tree$edge[tree$edge[,1] == node, 2]){
    if(j > nTip){
      s <- psNode(tree, data, nTip, traits, cost, j)
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
