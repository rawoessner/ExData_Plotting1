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

#Create a 3 Line plot
png(file = 'plot3.png', width = 480, height = 480)
plot(data_subset$DateTime, data_subset$Sub_metering_1, type = 'l', lty =1, xlab = "", ylab = 'Energy sub metering', col = 'black')
lines(data_subset$DateTime, data_subset$Sub_metering_2, type = 'l', col = 'red')
lines(data_subset$DateTime, data_subset$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = 1)
dev.off()