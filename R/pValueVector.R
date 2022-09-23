#' create the vector of p.value
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param obs vector
#' @param nullM matrix
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a vector
#' @export

p.valueVector <- function(obs, nullM, ...){

  P <- numeric(length(obs))
  for(i in 1:length(obs)){
    P[i] <- sum(nullM[,i] <= obs[i])/(nrow(nullM)+1)
  }
  names(P) <- names(obs)

  return(P)

}
