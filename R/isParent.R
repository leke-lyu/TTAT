#' This function test if node1 is an ancestor to node2
#'
#' @param tree phylo
#' @param node1 integer
#' @param node2 integer
#'
#' @return Boolean
#' @export

isParent <- function(tree, node1, node2){

  path1 <- pathToRoot(tree, node1)
  path2 <- pathToRoot(tree, node2)
  length(intersect(path1, path2)) == length(path1)

}
