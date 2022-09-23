#' test if the result reaches equilibrium
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param obs vector
#' @param nullM matrix
#' @param ... further arguments passed to or from other methods
#'
#' @return Return a matrix
#' @export

growingP <- function(obs, nullM, ...){

  gP <- matrix(0, nrow(nullM)-1, length(obs))
  for(i in 2:nrow(nullM)){
    gP[i-1,] <- p.valueVector(obs, nullM[1:i, ])
  }

  return(gP)

}
