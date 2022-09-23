#' create null distribution using AI statistic
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param obs vector
#' @param rep numeric
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a matrix
#' @export

aiNullModel <- function(tree, data, obs, rep, ...){

  nullM <- matrix(NA, rep, length(obs))
  node <- setdiff(tree$edge[,1], tree$edge[,2])
  nTip <- tree$tip.label %>% length()
  traits <- as.factor(data[,2]) %>% attributes() %>% .$levels

  frequencyList <- frequencyOfTraits(tree, data, nTip, traits, node)
  nodes <- obs %>% names() %>% as.integer()
  i <- 0
  pb <- txtProgressBar(min=0, max = rep, style = 3)

  for (i in 1:rep){
    for(j in 1:length(obs)){
      distribution <- j %>% nodes[.] %>% as.character() %>% frequencyList[[.]]
      newTrait <- rep(1:length(traits), distribution) %>% sample()
      tip <- tipsUnderNode(tree, nodes[j], nTip)
      d <- data.frame(tip, newTrait)
      nullM[i, j] <- aiNode(tree, d, nodes[j])
    }
    setTxtProgressBar(pb, i)
  }

  return(nullM)

}
