best <- function(state, outcome) {
    ## Reading and cleaing necessary data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", header = TRUE)
    data <- data[, c(2, 7, 11, 17, 23)]
    
    data[, 3] <- suppressWarnings(as.numeric(data[, 3]))
    data[, 4] <- suppressWarnings(as.numeric(data[, 4]))
    data[, 5] <- suppressWarnings(as.numeric(data[, 5]))
    
    valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
    
    ## Check that state and outcome are valid
    if (!is.element(state,unlist(data[, 2]))) {
        stop("invalid state")
    } else if(!is.element(outcome,unlist(valid_outcomes))) {
        stop("invalid outcome")
    } else {
        data <- data[data[, 2] == state, ]
        
        if(outcome == "heart attack") {
            hospital.nrow <- which(data[, 3] == min(data[, 3], na.rm = TRUE))
        } else if (outcome == "heart failure") {
            hospital.nrow <- which(data[, 4] == min(data[, 4], na.rm = TRUE))
        } else if (outcome == "pneumonia") {
            hospital.nrow <- which(data[, 5] == min(data[, 5], na.rm = TRUE))
        }
        
        data[hospital.nrow, 1]
    }
    
}