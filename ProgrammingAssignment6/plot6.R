library(data.table)
library(base)
library(utils)
library(dplyr)
library(ggplot2)

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

# Merge the two datasets to get sources
complete <- merge(NEI, SCC, by="SCC")

# Subset the vehicle sources from Baltimore and Los Angeles
complete_veh <-complete[grepl("Veh",complete$Short.Name),]
both_complete_veh = subset(complete_veh, fips %in% c("24510","06037"))
both_complete_veh = rename(both_complete_veh, County=fips)
year_grouping <- group_by(both_complete_veh, year, County) %>%
    summarize(PM2.5_emmission = sum(Emissions, na.rm=T)) %>%
    as.data.frame 

for (i in 1:nrow(year_grouping)) {
    if (year_grouping[i,2] == "06037") {
        year_grouping[i,2] <- "Los Angeles, CA"
    } else {
        year_grouping[i,2] <- "Baltimore, MD"
    }
}

png("plot6.png", width=580, height=580)
year_grouping %>% ggplot(aes(x=year, y=PM2.5_emmission, group=County, color=County)) + 
    geom_line() + xlab("Year") + ylab("Emission (Tons)") + 
    ggtitle("PM2.5 Emissions from Motor Vehicle Related Sources in Baltimore and Los Angeles")
dev.off()
