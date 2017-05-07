
library(dplyr)
## download, unzip and read data files

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("data.zip"))download.file(fileUrl, "data.zip")
if(!file.exists("household_power_consumption.txt"))unzip("data.zip")

powerdata <- read.table("household_power_consumption.txt",sep = ";",
                             header = TRUE, na.strings = "?")

## select data for the appropriate dates (2007-02-01 & 2007-02-02);  convert 
## Date and Time variables to Date/Time classes


plotdata <- powerdata[grepl("^1/2/2007|^2/2/2007", powerdata[,1]),]
plotdata[, "Date"] <- as.Date(plotdata[,"Date"], "%d/%m/%Y")

png(filename = "plot1.png")
with(plotdata, hist(Global_active_power, main = "Global Active Power", 
                    col = "red", xlab = "Global Active Power (Kilowatts)", 
                    ylab = "Frequency"))

dev.off()