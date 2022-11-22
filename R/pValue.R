#' This function create the vector of p.value
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param res matrix
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a vector
#' @export

p.value <- function(res, ...){

  P <- numeric(ncol(res))
  names(P) <- colnames(res)
  for(i in 1:ncol(res)){
    P[i] <- sum(round(res[,i],8) <= round(res[1,i],8))/nrow(res)
  }
  return(P)

}
