#Download zipped file and extrat data into a table
library(lubridate)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = temp)
data_file <- read.csv(unz(temp, 'household_power_consumption.txt'), sep = ";", header = TRUE, na.strings = "?")
unlink(temp)

#Convert date and time to date/time class
data_file$DateTime <- strptime(paste(data_file$Date, data_file$Time), '%d/%m/%Y  %H:%M:%S')

#Subset on Feb 1 and Deb 2, 2007
data_subset <- subset(data_file, data_file$DateTime >= as.POSIXlt('2007-02-01 00:00:00') & data_file$DateTime <= as.POSIXlt('2007-02-02 23:59:00'))

#Create multiple Line plot
png(file = 'plot4.png', width = 480, height = 480)
par(mfrow= c(2,2))
with(data_subset, {
  #Plot (1,1)
  plot(DateTime, Global_active_power, type = 'l', lty =1, xlab = "", ylab = 'Global Active Power')
  #Plot (1,2)
  plot(DateTime, Voltage, type = 'l', lty = 1, xlab = 'datetime', ylab = 'Voltage')
  #Plot (2,1)
  plot(DateTime, Sub_metering_1, type = 'l', lty =1, xlab = "", ylab = 'Energy sub metering', col = 'black')
  lines(DateTime, Sub_metering_2, type = 'l', col = 'red')
  lines(DateTime, Sub_metering_3, type = 'l', col = 'blue')
  legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = 1, bty = 'n')
  #Plot (2,2)
  plot(DateTime, Global_reactive_power, type = 'l', lty = 1, xlab = 'datetime', ylab = 'Global_reactive_power')
  
})
dev.off()