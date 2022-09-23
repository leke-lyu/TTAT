NULL
## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
if(getRversion() >= "2.15.1")  utils::globalVariables(c("ai"))
if(getRversion() >= "2.15.1")  utils::globalVariables(c("AssociationIndex"))
if(getRversion() >= "2.15.1")  utils::globalVariables(c("node"))
if(getRversion() >= "2.15.1")  utils::globalVariables(c("pValue"))
