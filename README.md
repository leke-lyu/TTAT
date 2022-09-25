# Tip-Trait Association Test (TTAT)
Given a phylogenetic tree, we want to ask if more closely related taxa are more likely to share the same trait values than we would expect by chance. This R package provides analytical methods to decide if the association between tips and characters is significant. By traversing the whole tree, the test would highlight all the subclades in which tips and characters are significantly associated.

## Features
`The Association Index (AI)` By measuring the imbalance of internal phylogeny nodes, the AI statistic explicitly considers the shape of the phylogeny.

`The Parsimony Score (PS)` We use Sankoff's Algorithm to calculate the parsimony score. Note that low PS scores represent robust phylogeny–trait association.

`Traverse the Tree` The recursive functions travel all the internal nodes to deploy the test and to identify exciting subclades.

## Development version
``` r
# install.packages("devtools")
devtools::install_github("leke-lyu/TTAT")
```

## Demonstration of the Core Algorithm
[AssociationTest.pdf](https://github.com/leke-lyu/TTAT/files/9640247/AssociationTest.pdf)
<p align="center">
  <img src="https://github.com/leke-lyu/TTAT/files/9640247/AssociationTest.pdf" />
</p>
