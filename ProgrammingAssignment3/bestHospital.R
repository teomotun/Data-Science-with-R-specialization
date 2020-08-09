best <- function(state, outcome) {
    ## Read outcome data
    ## Check that state and condition are valid
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    ## Suppress warnings
    library("dplyr")
    defaultW <- getOption("warn")
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
        indexes <- which(hospital_data[,11]==min(hospital_data[,11],na.rm = TRUE))
        lowest_data <- hospital_data[indexes,2]
    } else if (outcome == "heart failure"){
        hospital_data[,17] <- as.numeric(hospital_data[,17])
        indexes <- which(hospital_data[,17]==min(hospital_data[,17],na.rm = TRUE))
        lowest_data <- hospital_data[indexes,2]
    } else {
        hospital_data[,23] <- as.numeric(hospital_data[,23])
        indexes <- which(hospital_data[,23]==min(hospital_data[,23],na.rm = TRUE))
        lowest_data <- hospital_data[indexes,2]
    }
    options(warn=defaultW)
    sort(lowest_data)[1]
}