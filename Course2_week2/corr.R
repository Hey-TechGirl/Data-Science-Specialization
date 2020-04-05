corr <- function(directory, threshold = 0){
    ## the 'directory' argument is a character vector of length 1 
    ## indicating the location of the CSV files
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    files <- list.files(directory)
    completeCases <- complete(directory)        
    
    correlation <- numeric() ## create a numeric vector of correlations       
    for (i in id){
        
        if (completeCases[i,'nobs'] > threshold) {
            data <- read.csv(files[i])
            correlation <- c(correlation, cor(data[,'sulfate'], data[,'nitrate'], use= 'pairwise.complete.obs'))
        }
    }
    
    correlation
    
}