## read data in
library(data.table)
library(dplyr)
library(lubridate)

## this is very lengthy, so only perform if needed
if(!exists("plotData", mode = "any")) {
	# assumes the .txt file has been loaded in the defailt directory
	## read semicolon separated text file
	plotData <- fread("household_power_consumption.txt", na.strings = "?", stringsAsFactors = FALSE)
	plotData <- na.omit(plotData)
	
	##extract only needed data for plots
	plotData$Date <- as.Date(dmy(plotData$Date))
	plotData <- plotData %>% filter(Date >= "2007-2-1" & Date <= "2007-2-2") %>% arrange(Date, Time)
	plotData$TS <-paste(plotData$Date, plotData$Time)
}
## Plot 4
png(filename = "Plot4.png",	width = 480, height = 480)
par(mfrow = c(2, 2))
## Plot 4-1
plot(strptime(plotData$TS, "%d/%m/%Y %H:%M:%S"), plotData$Global_active_power, type = "l",  
	 xlab = "", ylab = "Global Active Power (kilowatts)")

## Plot 4-2
plot(strptime(plotData$TS, "%d/%m/%Y %H:%M:%S"), plotData$Voltage, type = "l",  
	 xlab = "datetime", ylab = "Voltage")

##P lot 4-3
plot(strptime(plotData$TS, "%d/%m/%Y %H:%M:%S"), plotData$Sub_metering_1, xlab = "",  ylab = "Energy sub metering", type = "l")
lines(strptime(plotData$TS, "%d/%m/%Y %H:%M:%S"), plotData$Sub_metering_2, col = "red", type = "l")
lines(strptime(plotData$TS, "%d/%m/%Y %H:%M:%S"), plotData$Sub_metering_3, col = "blue", type = "l")
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot 4-4
plot(strptime(plotData$TS, "%d/%m/%Y %H:%M:%S"), plotData$Global_reactive_power, type = "l",  
	 xlab = "datetime", ylab = names(plotData)[4])

dev.off()