rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    library("dplyr")
    defaultW <- getOption("warn")
    displayed_data <- NA
    options(warn=-1)
    hospital_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    if (!(outcome %in% c("heart failure", "heart attack", "pneumonia"))) {
        stop(" invalid outcome")
    }
    if (!(state %in% hospital_data$State)) {
        stop(" invalid state")
    }
    hospital_data <- filter(hospital_data, State ==state)
    if (outcome == "heart attack"){
        hospital_data[,11] <- as.numeric(hospital_data[,11])
        hospital_data <- subset(hospital_data, !is.na(hospital_data[,11]))
        ordered_data <- hospital_data[order(hospital_data[,11],hospital_data[,2]),]
    } else if (outcome == "heart failure"){
        hospital_data[,17] <- as.numeric(hospital_data[,17])
        hospital_data <- subset(hospital_data, !is.na(hospital_data[,17]))
        ordered_data <- hospital_data[order(hospital_data[,17],hospital_data[,2]),]
    } else {
        hospital_data[,23] <- as.numeric(hospital_data[,23])
        hospital_data <- subset(hospital_data, !is.na(hospital_data[,23]))
        ordered_data <- hospital_data[order(hospital_data[,23],hospital_data[,2]),]
    }
    
    if (num == "best") {
        displayed_data <- ordered_data[1,2]
    } else if (num == "worst") {
        displayed_data <- ordered_data[nrow(ordered_data),2]
    } else if (num > ncol(ordered_data)) {
        displayed_data <- NA
    } else {
        displayed_data <- ordered_data[num,2]
    }
    options(warn=defaultW)
    displayed_data
}