corr <- function(directory, threshold = 0){
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all variables)
    ## required to compute the correlation between nitrate and 
    ## sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!
    corr_vector <- numeric(1000)
    len_corr <- 1
    for (i in seq_along(1:length(dir(directory)))) {
        df_path <- file.path(directory,paste(sprintf("%03d", id[i]),".csv", sep=""))
        temp_df <- read.csv(df_path)
        good <- complete.cases(temp_df)
        temp_df <- temp_df[good,]
        temp_df <- select(temp_df,sulfate:nitrate)
        if (nrow(temp_df) > threshold) {
            corr_vector[len_corr] <- cor(temp_df$sulfate,temp_df$nitrate)
            len_corr <- len_corr + 1
        }
    }
    corr_vector <- corr_vector[seq_len(len_corr-1)]
    if (length(corr_vector) >= 1) {
        corr_vector
    } else {
        numeric()
    }
}


