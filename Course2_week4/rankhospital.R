rankhospital <- function(state, outcome, num = "best") {
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
            data <- data[order(data[, 3], data[, 1], decreasing=FALSE), ]
        } else if (outcome == "heart failure") {
            data <- data[order(data[, 4], data[, 1], decreasing=FALSE), ]
        } else if (outcome == "pneumonia"){
            data <- data[order(data[, 5], data[, 1], decreasing=FALSE), ]
        }
        
        if (num == "worst") {
            num = nrow(na.omit(data))
        } else if (num == "best") {
            num = 1
        } else {num = num}
        
        data[num, 1]
    }

}