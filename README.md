# TTAT
R package for tip-trait association test

Features:
Phylogenetic trees and trait dataframe as input
Highlight clades with strong association signals
Two metric (the parsimony score and the association index) would be applied to qualify the tip-traits association
Apply functions using parallel to accelerate calculation

![image](https://user-images.githubusercontent.com/46392207/176354882-5d8961ff-51a2-4135-97dd-478afbb659b2.jpeg)

Calculation function:
frequencyOfTraits, tipsUnderNodes, nullModel, calAI, aiWholeTree, aiNode, calPS, psWholeTree, PsNode, p.valueVector

Plot function:
plotTreeWithTrait, plotFrequencyOfTraits, plotobsAI, plotobsPS, highlightNodes
