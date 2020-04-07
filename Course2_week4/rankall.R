rankall <- function(outcome, num = "best") {
    ## Reading and cleaing necessary data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    data[, 11] <- suppressWarnings(as.numeric(data[, 11]))
    data[, 17] <- suppressWarnings(as.numeric(data[, 17]))
    data[, 23] <- suppressWarnings(as.numeric(data[, 23]))
    
    data <- data[,c(2,7,11,17,23)]
    
    colnames(data) <- c("hospital","state","heart attack","heart failure","pneumonia")
    
    ## Check that state and outcome are valid
    valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
    
    if (!is.element(outcome,unlist(valid_outcomes))) {
        stop("invalid state")
    }
    
    state <- unique(data[,c("state")])
    state <- state[order(nchar(state), state)]
    
    hospital.name  <- character(0)
    hospital.state <- character(0)
    empty.name  <- character(0)
    
    for (i in state) { 
        data.state <- data[which(data$state==i),]
        
        ## Sorting data by State  
        if (outcome == "heart attack") {
            df <- data.state[order(data.state[, 3],data.state[, 1], decreasing=FALSE), ]
            df <- data.frame(hospital = df[, 1], state = df[, 2], "heart attack" = df[, 3])
        } else if (outcome == "heart failure")  {
            df <- data.state[order(data.state[, 4],data.state[, 1], decreasing=FALSE), ]
            df <- data.frame(hospital = df[, 1], state = df[, 2], "heart failure" = df[, 4])
        } else if (outcome == "pneumonia")  {
            df <- data.state[order(data.state[, 5],data.state[, 1], decreasing=FALSE), ]
            df <- data.frame(hospital = df[, 1], state = df[, 2], pneumonia = df[, 5])
        }
        
        data.clean<- na.omit(df)
        
        if (is.character(num) == TRUE) {
            if (num == "worst") {num = nrow(data.clean)}
            if (num == "best") {num = 1}
        } else {num = num}
        
        if (num <= nrow(data.clean)) {
            empty.name <- as.character(data.clean[num, ]$hospital)
        }else {empty.name = "<NA>"}
        
        ## Return the Hospital Name and State by the selected Number
        hospital.name  <- c(hospital.name, empty.name)
        hospital.state <- c(hospital.state, i)
        
    }
    
    return(data.frame(hospital=hospital.name, state = hospital.state))
    
}