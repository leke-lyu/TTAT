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
<p align="center">
  <img src="https://github.com/leke-lyu/TTAT/files/9640247/AssociationTest.pdf" width="400" height="400"/>
</p>


## Usage
``` r
library(TTAT)
library(ape)
library(magrittr)

#00 generate rtree sample with 60 tips
tree <- rtree(60)
data <- data.frame(tip=tree$tip.label, num=sample(1:2, 60, replace = T))
data[,2] %<>% as.character()
traits <- data[,2] %>% as.factor() %>% attributes() %>% .$levels
cost <- 1-diag(length(traits))
rownames(cost) <- traits
colnames(cost) <- traits

#01 estimate PS and deploy the test
psobs <- psWholeTree(tree, data, cost)
psnullM <- psNullModel(tree, data, psobs, cost, 999)
psP <- p.valueVector(psobs, psnullM)

#02 estimate AI and deploy the test
aiobs <- aiWholeTree(tree, data)
ainullM <- aiNullModel(tree, data, aiobs, 999)
aiP <- p.valueVector(aiobs, ainullM)

```

## Future Step
`Parallel Processing` To boost the speed when estimating the null distribution.

`Extending the Choice of Metrics` the phylogenetic diversity (PD), the net relatedness index (NRI), and nearest taxa index (NTI)
