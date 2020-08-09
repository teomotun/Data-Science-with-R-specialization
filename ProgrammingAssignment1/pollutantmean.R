pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indication 
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate"
    
    ## 'id' is an integer vector indicating the monitor ID number
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    ## NOTE: Do not round the result!
    
    means_list <-id
    for (i in seq_along(id)) {
        df_path <- file.path(directory,paste(sprintf("%03d", id[i]),".csv", sep=""))
        temp_df <- read.csv(df_path)[pollutant]
        means_list[i]<-sapply(temp_df, mean, na.rm = TRUE)
    }
    mean(means_list, na.rm = TRUE)
}




