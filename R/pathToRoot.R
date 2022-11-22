#' This function find the path of a given node to the root.
#'
#' @param tree phylo
#' @param node integer
#' @param path vector
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a vector
#' @export

pathToRoot <- function(tree, node, path=NULL, ...){

  if(is.null(path)) path <- c(node)
  root <- setdiff(tree$edge[,1], tree$edge[,2])
  if(node == root){
    stop("The input node is the root")
  }else{
    parent <- tree$edge[,1][node == tree$edge[,2]]
    path <- c(path, parent)
    if(parent == root){
      return(path)
    }else{
      pathToRoot(tree, parent, path)
    }
  }

}
