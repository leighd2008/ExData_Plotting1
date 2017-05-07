
library(dplyr, lubridate, ggplot2)
## download, unzip and read data files

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("data.zip"))download.file(fileUrl, "data.zip")
if(!file.exists("household_power_consumption.txt"))unzip("data.zip")

powerdata <- read.table("household_power_consumption.txt",sep = ";",
                             header = TRUE, na.strings = "?")

## select data for the appropriate dates (2007-02-01 & 2007-02-02);  convert 
## Date and Time variables to Date/Time classes


plotdata <- powerdata[grepl("^1/2/2007|^2/2/2007", powerdata[,1]),]
plotdata$Date <- as.character(plotdata$Date)
plotdata$Time <-as.character(plotdata$Time)
plotdata$datetime <- dmy_hms(apply(plotdata[,1:2], 1, paste, collapse=" "))

png(filename = "plot2.png")
with(plotdata, plot(datetime, Global_active_power, type = "l", xlab = "", 
                    ylab = "Global Active Power (Kilowatts)"))

dev.off()