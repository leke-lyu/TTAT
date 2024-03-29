% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calPS.R
\name{calPS}
\alias{calPS}
\title{The function returns the PS vector of each internal node subtended by an interesting clade.}
\usage{
calPS(tree, data, traits, cost, nTip, node, psList = NULL, ...)
}
\arguments{
\item{tree}{phylo}

\item{data}{data.frame}

\item{traits}{character}

\item{cost}{matrix}

\item{nTip}{integer}

\item{node}{integer}

\item{psList}{list}

\item{...}{further arguments passed to or from other methods}
}
\value{
Return a list of vector
}
\description{
The function returns the PS vector of each internal node subtended by an interesting clade.
}
