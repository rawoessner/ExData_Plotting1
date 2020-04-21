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

#Create Line plot
png(file = 'plot2.png', width = 480, height = 480)
plot(data_subset$DateTime, data_subset$Global_active_power, type = 'l', lty =1, xlab = "", ylab = 'Global Active Power (kilowatts)')
dev.off()