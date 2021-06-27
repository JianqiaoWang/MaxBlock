
<!-- README.md is generated from README.Rmd. Please edit that file -->

# MaxBlock

<!-- badges: start -->

<!-- badges: end -->

The goal of MaxBlock is to detect the simultatenous signal between two
outcomes.

## Installation

You can install the released version of MaxBlock from github with:

``` r
devtools::install_github("JianqiaoWang/MaxBlock")
```

## Example

This is a basic example which shows you how to solve a common problem.
The input is

  - data for outcome 1 \((X_1, Y_1)\)
  - data for outcome 2 \(X_2, Y_2\)
  - A list of block range: each element of the list contains the index
    of variants within the block.

<!-- end list -->

``` r
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
#> $p
#> [1] 0.001
#> 
#> $M
#> [1] 52.25729
# ------------------------------- Stepwise block selection 
StepSelect(z.block, alpha = 0.05 )
#> [[1]]
#> [1] 0.001
#> 
#> [[2]]
#> [1] 988
```

## Plink for haplotype block estimation

One may also need to install
[PLINK](https://www.cog-genomics.org/plink/) for haplotype block
estimation, and prepare a suitable reference dataset for PLINK. One
resource of the reference dataset of the European population, which is
also used in our paper, is the 1000 genome European reference panel
downloaded here
<http://fileserve.mrcieu.ac.uk/ld/data_maf0.01_rs_ref.tgz>, from the
[MRCIEU cite](https://github.com/MRCIEU/gwas2vcf).

With the reference file data\_maf0.01\_rs.bed, data\_maf0.01\_rs.bim,
data\_maf0.01\_rs.fam, we estimate the haplotype blocks for each
chromosome. Files Chr\_1\_SNP.csv … Chr\_22\_SNP.csv contain the genetic
variants ID for chromosome 1-22 in our study. The output files contains
the snp ID within each block. More details can be found in
<https://zzz.bwh.harvard.edu/plink/ld.shtml#blox>.

``` r
chr = 1`
command = paste("plink --bfile data_maf0.01_rs --extract Chr_",chr,"_SNP.csv --blocks no-pheno-req no-small-max-span --blocks-strong-lowci 0.5005 --out chr_",chr, sep = "")
```
