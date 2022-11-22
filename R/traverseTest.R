#' Taking a tree and the trait data as the input, this function deploys multiple tests traversing all the internal nodes.
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param metric "AI" or "PS"
#' @param rep numeric
#' @param minimumCladeSize numeric
#' @param cost matrix
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a matrix
#' @export

traverseTest <- function(tree, data, metric, rep, minimumCladeSize=10, cost=NULL, ...){

  #Prepare parameters for the test
  node <- setdiff(tree$edge[,1], tree$edge[,2])
  nTip <- tree$tip.label %>% length()
  traits <- as.factor(data[,2]) %>% attributes() %>% .$levels
  if(is.null(cost)){
    cost <- 1-diag(length(traits))
    rownames(cost) <- traits
    colnames(cost) <- traits
  }

  #The error action
  try(if(class(tree) != "phylo") stop("check the format of input phylogeny!"))
  try(if(nrow(data) != nTip) stop("the tree does not match with the data!"))
  try(if(!(metric %in% c("AI","PS"))) stop("please type AI or PS!"))

  #Estimate the obs
  frequencyList <- frequencyOfTraits(tree, data, nTip, traits, node)
  statsList <- lapply(frequencyList, function(i){
    sum <- sum(i)
    max <- max(i)
    (1-max/sum)/(2^(sum-1))
  })
  if(metric == "AI"){
    obs <- calAI(tree, statsList, nTip, node)
  }else{
    obs <- calPS(tree, data, traits, cost, nTip, node) %>% lapply(., min) %>% unlist
  }
  res <- matrix(NA, rep, length(obs))
  colnames(res) <- names(obs)
  for(j in 1:length(obs)){
    res[1,j] <- obs[j]
  } #fill first row with obs

  #Estimate the null distribution
  pb <- txtProgressBar(min=0, max = length(obs), style = 3)
  nodes <- obs %>% names() %>% as.integer()
  boolV <- rep(T, length(obs))
  if(metric == "AI"){
    for(j in 1:length(obs)){
      tip <- tipsUnderNode(tree, nodes[j], nTip)
      if(length(tip) > minimumCladeSize){
        for(i in 2:rep){
          distribution <- j %>% nodes[.] %>% as.character() %>% frequencyList[[.]]
          newTrait <- rep(1:length(traits), distribution) %>% sample()
          d <- data.frame(tip, newTrait)
          res[i,j] <- aiNode(tree, d, nTip, traits, nodes[j])
        }
      }else{
        boolV[j] <- F
      }
      setTxtProgressBar(pb, j)
    }
  }else{
    for(j in 1:length(obs)){
      tip <- tipsUnderNode(tree, nodes[j], nTip)
      if(length(tip) > minimumCladeSize){
        for(i in 2:rep){
          distribution <- j %>% nodes[.] %>% as.character() %>% frequencyList[[.]]
          newTrait <- rep(1:length(traits), distribution) %>% sample()
          d <- data.frame(tip, newTrait)
          res[i,j] <- psNode(tree, d, nTip, traits, cost, nodes[j]) %>% min()
        }
      }else{
        boolV[j] <- F
      }
      setTxtProgressBar(pb, j)
    }
  }
  rb <- res[,boolV]
  attributes(rb)$root <- node
  attributes(rb)$ntips <- nTip
  attributes(rb)$m <- metric
  return(rb)

}
