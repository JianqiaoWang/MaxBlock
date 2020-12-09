#' Title The main function of test
#'
#' @param Y1 outcome 1
#' @param X1 genotype 1; maybe a list or a matrix
#' @param Y2 outcome 2
#' @param X2 genotype 2
#' @param Block.list A list of block index
#'
#' @return
#' @export
#'
#' @examples
MaxBlock = function(Y1, X1, Y2, X2, Block.list = NA, same.ind = T ){

  if(ncol(X1)!=ncol(X2)){
    stop("Test statistic vectors must be of same length");
  }

  z.block <- matrix(NA, nrow = M, ncol = 2)
  if(is.list(X1)){
  for(i in 1:M){
    z.block[i,] <- unlist(Z.Block(X.1 = X1[[i]], X.2 = X2[[i]],
                                  outcome.1 = Y1, outcome.2 =Y2))
  }
  }else{
    for(i in 1:M){
      z.block[i,] <-unlist(Z.Block(X.1 = X1[, Block.list[[i]] ], X.2 = X2[, Block.list[[i]] ],
                                   outcome.1 = Y1, outcome.2 =Y2))
    }
  }

  chi2.block = z.block^2

  MAX = maxtest(T1 = chi2.block[,1], T2 = chi2.block[,2])

  return(MAX)


}
