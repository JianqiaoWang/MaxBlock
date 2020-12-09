# Calculate the blockwise statistics 
 
BlockStat = function(SNP, Y, Block.list, chr, cores = 1){
  
  # return a vector of statistics with the same length as the Block.list at most
  
  print(nrow(SNP))
  
  if(nrow(SNP) != length(as.numeric(Y) ) ){
    
    stop("SNP and Y must be of same length")
    
  }
  
  
  # Y = as.matrix(Y, nrow = nrow(SNP))
  
  SNP = SNP[!is.na(Y),]
  
  if(is.null(dim(Y))){
    
    Y = Y[!is.na(Y)]
    
    # cov = crossprod(SNP, Y)
    
    Y.sd =  sd(Y, na.rm = T)
  }else{
    
    
    Y.sd = apply(Y, 2, function(x){  sd(x, na.rm = T) } )
    
  }
  
  
  BLOCK.STAT = mclapply(Block.list, function(x){
    
    tag = x
    
    if( any(tag %in% colnames(SNP)) ){
      
      tag = intersect(x, colnames(SNP))
      
      SNP_Selected = SNP[,tag]
      
      SNP_Selected = scale(SNP_Selected)
      
      edc <- eigen(cov(SNP_Selected), symmetric = TRUE)
      
      #prin = princomp(SNP_Selected)
      
      lambda = edc$values[1]
      
      eta = edc$vectors[,1]
      
      COV = crossprod(SNP_Selected, Y)/sqrt(nrow(SNP_Selected))
      
      return(eta %*% COV/(sqrt(lambda) * Y.sd))
      
    }else{
      return(NA)
    }
    
  }, mc.cores = cores)
  
  #BLOCK.STAT = as.data.frame(do.call(c, BLOCK.STAT))
  
  BLOCK.STAT = as.data.frame(unlist(BLOCK.STAT))
  
  #BLOCK.STAT = rbindlist(BLOCK.STAT)
  
  #print(nrow(BLOCK.STAT))
  
  rowname.vector = paste("Chr_",chr,":",1:length(Block.list), sep = "")
  
  rownames(BLOCK.STAT) = rowname.vector
  
  print(head(BLOCK.STAT))
  
  return(BLOCK.STAT)
  
}
