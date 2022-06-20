#' create null distribution
#' @import magrittr
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

nullModel <- function(tree, data, obs, rep, ...){

  nullM <- matrix(NA, rep, length(obs))
  node <- setdiff(tree$edge[,1], tree$edge[,2])
  nTip <- tree$tip.label %>% length()
  traits <- as.factor(data[,2]) %>% attributes() %>% .$levels

  frequencyList <- list()
  frequencyList <- frequencyOfTraits(tree, data, nTip, traits, node, frequencyList)
  nodes <- obs %>% names() %>% as.integer()
  i <- 0
  pb <- txtProgressBar(min=0, max = rep, style = 3)

  for (i in 1:rep){
    for(j in 1:length(obs)){
      distribution <- j %>% nodes[.] %>% as.character() %>% frequencyList[[.]]
      tipsVector <- c() #vector(mode='character')
      newTrait <- rep(1:length(traits), distribution) %>% sample()
      tip <- tipsUnderNode(tree, nodes[j], nTip, tipsVector)
      data <- data.frame(tip, newTrait)
      nullM[i, j] <- aiNode(tree, data, nodes[j])
    }
    setTxtProgressBar(pb, i)
  }

  return(nullM)

}
