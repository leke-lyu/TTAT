#' get rid of redundant
#'
#' @param tree phylo
#' @param nodes vector
#' @param ... further arguments passed to or from other methods
#'
#' @return vector
#' @export


selectMonophyleticGroup <- function(tree, nodes, ...){

  if(length(nodes) < 2){
    return(nodes)
  }else{
    newNodes <- c(nodes[1])
    for(i in 2:length(nodes)){
      add=T
      for(j in 1:length(newNodes)){
        if(isParent(tree, newNodes[j], nodes[i])){
          add=F
          break
        }else if(isParent(tree, nodes[i], newNodes[j])){
          newNodes[j]=nodes[i]
          add=F
        }
      }
      if(add==T){
        newNodes <- c(newNodes, nodes[i])
      }else{
        newNodes <- unique(newNodes)
      }
    }
    return(newNodes)
  }

}
