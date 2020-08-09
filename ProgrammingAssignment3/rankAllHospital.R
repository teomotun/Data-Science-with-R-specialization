rankall <- function(outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    library("dplyr")
    defaultW <- getOption("warn")
    displayed_data <- NA
    options(warn=-1)
    hospital_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    if (!(outcome %in% c("heart failure", "heart attack", "pneumonia"))) {
        stop(" invalid outcome")
    }
    
    if (outcome == "heart attack"){
        hospital_data[,11] <- as.numeric(hospital_data[,11])
        state_group <- group_by(hospital_data,hospital_data$State)
        state_group <- filter(state_group,is.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
        state_group <- arrange(state_group,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,Hospital.Name)
    } else if (outcome == "heart failure"){
        hospital_data[,17] <- as.numeric(hospital_data[,17])
        state_group <- group_by(hospital_data,hospital_data$State)
        state_group <- filter(state_group,is.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
        state_group <- arrange(state_group,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,Hospital.Name)
    } else {
        hospital_data[,23] <- as.numeric(hospital_data[,23])
        state_group <- group_by(hospital_data,hospital_data$State)
        state_group <- filter(state_group,is.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
        state_group <- arrange(state_group,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,Hospital.Name)
    }
    
    if (num == "best") {
        displayed_data <- summarize(state_group, hospital=nth(Hospital.Name,1), state=nth(State,1))
    } else if (num == "worst") {
        displayed_data <- summarize(state_group, hospital=nth(Hospital.Name,n()), state=nth(State,n()))
    } else {
        displayed_data <- summarize(state_group, hospital=nth(Hospital.Name,num), state=nth(State,num))
    }
    
    options(warn=defaultW)
    displayed_data
}




