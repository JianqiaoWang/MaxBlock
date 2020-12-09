
# MaxBlock

<!-- badges: start -->
<!-- badges: end -->

The goal of MaxBlock is to detect the simultatenous signal between two outcomes.

## Installation

You can install the released version of MaxBlock from github with:

``` r
devtools::install_github("JianqiaoWang/MaxBlock")
```

## Example

This is a basic example which shows you how to solve a common problem:


```{r example}
library(MaxBlock)
## basic example code
# ------------------------------- calculate the blockwise statistics
X.1 = data.list$X
Y.1 = data.list$Y1
Y.2 = data.list$Y2
Block.list = data.list$index
z.block <- matrix(NA, nrow = 1000, ncol = 2)
for(i in 1:1000){
   z.block[i,]  =  Z.Block(X.1 = X.1[, Block.list[[i]] ], X.2 = X.1[, Block.list[[i]] ],
           outcome.1 = Y.1, outcome.2 =Y.2, )
}
# ------------------------------- Max test 
 maxtest(T1 = (z.block[,1])^2, T2 = (z.block[,2])^2)
# ------------------------------- Stepwise block selection 
StepSelect(z.block, alpha = 0.05 )
```


