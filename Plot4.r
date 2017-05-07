
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

png(filename = "plot4.png")

par(mfrow =c(2,2))

## first graph

with(plotdata, plot(datetime, Global_active_power, type = "l", xlab = "",
                    ylab = "Global Active Power (Kilowatts)"))

## second graph

with(plotdata, plot(datetime, Voltage, type = "l", xlab = "datetime",
                    ylab = "Voltage"))
## third graph

with(plotdata, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))

with(plotdata, points(datetime, Sub_metering_2, type = "l", col = "red"))

with(plotdata, points(datetime, Sub_metering_3, type = "l", col = "blue"))

with(plotdata, legend("topright", lty = 1, bty ="n", 
                      c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                      col = c("black", "red", "blue", text.col = "black")))

## forth graph

with(plotdata, plot(datetime, Global_reactive_power, type = "l"))

dev.off()