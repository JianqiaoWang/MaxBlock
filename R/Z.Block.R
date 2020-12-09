#' Calculate the z statistics
#'
#' @param X.1 genotypes matrix for outcome 1
#' @param X.2 genotypes matrix for outcome 2
#' @param outcome.1 a vecotr of outcome 1
#' @param outcome.2 a vecotr of outcome 2
#' @param same.ind whether the collected outcome 1 and outcome 2 come from the same group of individuals
#' @return a list of two blockwise z-statistics vectors
#' @export
#'
#' @examples
#' data(test)
#' X.1 = data.list$X
#' Y.1 = data.list$Y1
#' Y.2 = data.list$Y2
#' Block.list = data.list$index
#' z.block <- matrix(NA, nrow = 1000, ncol = 2)
#' for(i in 1:1000){
#'   z.block[i,]  =  Z.Block(X.1 = X.1[, Block.list[[i]] ], X.2 = X.1[, Block.list[[i]] ],
#'                           outcome.1 = Y.1, outcome.2 =Y.2, )
#' }
#'
Z.Block <- function(X.1, X.2, outcome.1, outcome.2, same.ind = T ){
  N = length(outcome.1)
  if(same.ind){
  myPCA <- prcomp(X.1, scale. = T, center = T)
  prsc <- myPCA$x[,1]
  prsc.sd <- myPCA$sdev[1]
  #s1 = (t(prsc)%*%outcome.1/(sqrt(N-1)*prsc.sd * sd(outcome.1)))^2
  # t1 = (t(prsc)%*% outcome.2/(sqrt(N-1)*prsc.sd * sd(outcome.2)))^2
  s1 = (t(prsc)%*%outcome.1/(sqrt(N-1)*prsc.sd * sd(outcome.1)))
  t1 = (t(prsc)%*% outcome.2/(sqrt(N-1)*prsc.sd * sd(outcome.2)))
  }else{

    myPCA <- prcomp(X.1, scale. = T, center = T)
    prsc <- myPCA$x[,1]
    prsc.sd <- myPCA$sdev[1]
    s1 = (t(prsc)%*%outcome.1/(sqrt(N-1)*prsc.sd * sd(outcome.1)))
    myPCA <- prcomp(X.2, scale. = T, center = T)
    prsc <- myPCA$x[,1]
    prsc.sd <- myPCA$sdev[1]
    t1 = (t(prsc)%*% outcome.2/(sqrt(N-1)*prsc.sd * sd(outcome.2)))
  }
  return(c(z1 = s1, z2 = t1))
}
