complete <- function(directory, id=1:332){
    ## the 'directory' argument is a character vector of length 1 
    ## indicating the location of the CSV files
    ## 'id' is an integer vector indicating the monitor ID numbers
    
    files <- list.files(directory)
    nobs <- integer(length(id))
    
    for(i in 1:length(id)){
        data <- read.csv(files[id[i]])
        ## number of complete cases (removing NA for sulfate and nitrate)
        nobs[i] <- length(data[!is.na(data[,'sulfate']) & !is.na(data[,'nitrate']),1])
    } 
    
    completeCases <- data.frame(cbind(id,nobs))
    completeCases
}
