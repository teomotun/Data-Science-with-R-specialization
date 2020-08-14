rm(list=ls())
library(data.table)
library(base)
library(utils)
library(dplyr)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
wd <- getwd()
if(!file.exists(dataFiles.zip)) {
    download.file(url, file.path(wd, "dataFiles.zip"))
}
unzip(zipfile = "dataFiles.zip")
power_consumption <- read.table(file = "household_power_consumption.txt", dec = ".", stringsAsFactors = FALSE, 
                                colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), header = TRUE, sep = ";", na.strings = "?")

# subset data to and remove original data table to free space
data <- filter(power_consumption, Date %in% c("1/2/2007", "2/2/2007"))
rm(power_consumption)

# new column date_time for x axis
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- mutate(data, date_time = as.POSIXct(paste(data$Date, data$Time, sep=" "), template = "%d/%m/%Y %H:%M:%S", tz = Sys.timezone()))

png("plot2.png", width=580, height=580)
plot(data$date_time, data$Global_active_power, type="l", xlab= "", ylab="Global Active Power (kilowatts)")
dev.off()
