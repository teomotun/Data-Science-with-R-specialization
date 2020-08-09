complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indication the monitor ID numbers
    ## to be used
    
    ## Return a dataframe of the form:
    ## id nobs
    ## 1 117
    ## 2 2041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    df_path <- file.path(directory,paste(sprintf("%03d", id[1]),".csv", sep=""))
    temp_df <- read.csv(df_path)
    good <- complete.cases(temp_df)
    temp_df <- temp_df[good,]
    temp_df <- data.frame(table(temp_df$ID))
    colnames(temp_df) <- c("id", "nobs")
    if (length(id)>1) {
        #for (i in seq_along(id-1)) {
        i <- 2
        while (i < length(id)+1) {
            df_path <- file.path(directory,paste(sprintf("%03d", id[i]),".csv", sep=""))
            temp_df2 <- read.csv(df_path)
            good <- complete.cases(temp_df2)
            temp_df2 <- temp_df2[good,]
            temp_df2 <- data.frame(table(temp_df2$ID))
            colnames(temp_df2) <- c("id", "nobs")
            temp_df <- rbind(temp_df,temp_df2)
            i = i + 1
        }
    }
    temp_df
}



