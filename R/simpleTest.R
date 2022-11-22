#' Taking a tree and the trait data as the input, this function deploys one test.
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param tree phylo
#' @param data data.frame
#' @param metric "AI" or "PS"
#' @param rep numeric
#' @param cost matrix
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a matrix
#' @export

simpleTest <- function(tree, data, metric, rep, cost=NULL, ...){

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

  #Excuate the test
  res <- matrix(NA, rep, 1) #declare output matrix
  colnames(res) <- node #name the column as the code for root
  attributes(res)$root <- node
  attributes(res)$ntips <- nTip
  attributes(res)$m <- metric
  pb <- txtProgressBar(min=0, max = rep, style = 3)
  if(metric == "AI"){
    res[1,1] <- aiNode(tree, data, nTip, traits, node) #calculate the AI obs
    for (i in 2:rep){
      newTrait <- data[sample(1:nrow(data)), 2]
      tip <- data[, 1]
      d <- data.frame(tip, newTrait)
      res[i,1] <- aiNode(tree, d, nTip, traits, node)
      setTxtProgressBar(pb, i)
    } #generate null distribution
  }else{
    res[1,1] <- psNode(tree, data, nTip, traits, cost, node) %>% min() #calculate the PS obs
    for (i in 2:rep){
      newTrait <- data[sample(1:nrow(data)), 2]
      tip <- data[, 1]
      d <- data.frame(tip, newTrait)
      res[i,1] <- psNode(tree, d, nTip, traits, cost, node) %>% min()
      setTxtProgressBar(pb, i)
    } #generate null distribution
  }
  return(res)

}
