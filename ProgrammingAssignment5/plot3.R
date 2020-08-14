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

png("plot3.png", width=580, height=580)
with(data, {
    plot(x=date_time, y=Sub_metering_1, type = "l", col = "black", xlab="", ylab="Energy sub metering")
    lines(x=date_time, y=Sub_metering_2, type = "l", col = "red")
    lines(x=date_time, y=Sub_metering_3, type = "l", col = "blue")
    legend("topright", lty="solid", col=c("black", "red", "blue"), 
           legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
})
dev.off()