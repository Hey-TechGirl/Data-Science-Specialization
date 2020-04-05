pollutantmean <- function(directory, pollutant, id = 1:332){
    ## the 'directory' argument is a character vector of length 1 
    ## indicating the location of the CSV files
    ## 'pollutant' is a character vector of length 1 
    ## indicating the name of the pollutant to be calculated
    ## 'id' is an integer vector indicating the monitor ID numbers
    files <- list.files(directory)
    data <- data.frame()
    
    for(i in id) {
      data <- rbind(data, read.csv(files[i]))
    }
    
    mean(data[[pollutant]],na.rm=TRUE)
    
}
