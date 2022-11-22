#' This function summarizes the test result.
#' @importFrom magrittr %>%
#' @import utils
#'
#' @param res matrix
#' @param ... further arguments passed to or from other methods
#'
#' @export

testSummary <- function(res, ...){

  paste0("\n", ncol(res), " tests have been deployed on the input tree with ", attributes(res)$ntips, " tips using ", attributes(res)$m, "\n") %>% cat
  cat("----------------------------------------------\n")
  P <- p.value(res)
  r <- matrix(c(res[1,colnames(res)==attributes(res)$root], P[colnames(res)==attributes(res)$root]), ncol=1)
  rownames(r) <- c("Statistic", "Significance")
  colnames(r) <- c("root")
  r <- as.table(r)
  print(r)
  if(ncol(res) > 1){
    cat("----------------------------------------------\n")
    n <- matrix(NA, 2, ncol(res))
    rownames(n) <- c("Statistic", "Significance")
    colnames(n) <- paste0("node", colnames(res))
    for(i in 1:ncol(res)){
      n[1,i] <- res[1,i]
      n[2,i] <- P[i]
    }
    n <- n[,colnames(n)!=paste0("node", attributes(res)$root)]
    n <- as.table(n)
    print(n)
  }
  rootres <- res[, colnames(res)==attributes(res)$root] %>% as.matrix(ncol=1)
  gP <- rep(NA, nrow(rootres)-1)
  for(i in 2:nrow(rootres)){
    gP[i-1] <- p.value(as.matrix(rootres[1:i, ], ncol=1))
  }
  df <- data.frame(rep=c(2:nrow(rootres)), pValue=gP)
  p <- ggplot(df, aes(x = rep, y = pValue)) + geom_line()
  p

}

