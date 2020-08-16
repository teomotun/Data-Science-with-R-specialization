library(data.table)
library(base)
library(utils)
library(dplyr)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
wd <- getwd()
if (!file.exists("dataFile.zip")) {
    download.file(url, file.path(wd, "dataFile.zip"))
}
unzip(zipfile = "dataFile.zip")

# Read in PM2.5 Emissions Data (summarySCC_PM25.rds)
NEI <- readRDS("summarySCC_PM25.rds")

# Read in Source Classification Code Table (Source_Classification_Code.rds)
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
NEI$year = as.Date(as.character(NEI$year), "%Y")
NEI$year = year(NEI$year)

year_grouping <- group_by(NEI, year) %>%
    summarize(PM2.5_emmission = sum(Emissions, na.rm=T)) %>%
    as.data.frame 

png("plot1.png", width=580, height=580)
plot(year_grouping$year, year_grouping$PM2.5_emmission, type="l", xlab= "Year", ylab="Emission (Tons)", main="PM2.5 Emission in United States")
dev.off()




