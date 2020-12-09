#' Stepwise significant block selection
#'
#' @param z.block a M * 2 matrix of z statistics
#' @param alpha thresholding parameter
#'
#' @return Return a list consist of two vectors:
#' 1. A vector of p-value at each step  2.  A vector of identified significant block locations.
#' @export
#'
#' @examples
#'
#' p <- 10^6; ## total number of pairs
#' X <- c(rep(0,p-30),rep(1,10),rep(2,10),rep(3,10));
#' X=0: no signal in either sequence of tests
#' X=1: signal in sequence 1 only
#' X=2: signal in sequence 2 only
#' X=3: simultaneous signal
#' set.seed(1);
#' Z1 <- rnorm(p,0,1); Z1[X==1|X==3] <- rnorm(20,3,1);
#' Z2 <- rnorm(p,0,1); Z2[X==2|X==3] <- rnorm(20,4,1);
#' StepSelect(cbind(Z1,Z2), alpha = 0.05 )
#' @import stats
StepSelect = function(z.block, alpha = 0.05){
  chi2.block = z.block^2
  pval.vector = vector()
  location.vector = vector()
  while(1){
    min.block = pmin(chi2.block[,1], chi2.block[,2])
    pval.rm = maxtest(chi2.block[, 1], chi2.block[, 2])$`p`
    block.rm = which.max(unlist( min.block))
    chi2.block = chi2.block[-block.rm, ]
    if(pval.rm > alpha){
      break
    }

    pval.vector = c(pval.vector, pval.rm)
    location.vector = c(location.vector, block.rm)
    # pval.rm = maxtest(chi2.block[, 1], chi2.block[, 2])$`p`
    #  pval.vector = c(pval.vector, pval.rm)
  }

  return(list(pval.vector, location.vector))
}

