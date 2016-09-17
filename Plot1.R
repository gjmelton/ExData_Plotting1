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
## Plot 1
png(filename = "Plot1.png",	width = 480, height = 480)
hist(plotData$Global_active_power, col = "red", main = "Global Active Power", 
	 xlab = "Global Active Power (kilowatts)")
dev.off()

