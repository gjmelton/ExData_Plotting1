## read data in
library(data.table)
library(dplyr)
library(lubridate)

## this is very lengthy, so only perform if needed
if(!exists("plotData", mode = "any")) {
	## read semicolon separated text file
	## assumes the .txt file has been loaded in the defailt directory
	plotData <- fread("household_power_consumption.txt", na.strings = "?", stringsAsFactors = FALSE)
	plotData <- na.omit(plotData)
	
	##extract only needed data for plots
	plotData$StdDate <- as.Date(dmy(plotData$Date))
	plotData <- plotData %>% filter(StdDate >= "2007-2-1" & StdDate <= "2007-2-2") %>% arrange(StdDate, Time)
	plotData$TS <-paste(plotData$Date, plotData$Time)
}
## Plot 3
png(filename = "Plot3.png",	width = 480, height = 480)
plot(strptime(plotData$TS, "%d/%m/%Y %H:%M:%S"), plotData$Sub_metering_1, xlab = "",  ylab = "Energy sub metering", type = "l")
lines(strptime(plotData$TS, "%d/%m/%Y %H:%M:%S"), plotData$Sub_metering_2, col = "red", type = "l")
lines(strptime(plotData$TS, "%d/%m/%Y %H:%M:%S"), plotData$Sub_metering_3, col = "blue", type = "l")
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()