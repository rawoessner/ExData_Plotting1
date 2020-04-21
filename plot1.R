#Download zipped file and extrat data into a table
library(lubridate)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = temp)
data_file <- read.csv(unz(temp, 'household_power_consumption.txt'), sep = ";", header = TRUE, na.strings = "?")
unlink(temp)

#Convert date and time to date time class and remaining columns to numeric
data_file$Date <- as.Date(data_file$Date, format = '%d/%m/%Y') 
#data_file$Time <- hms(data_file$Time)

#Subset on Feb 1 and Deb 2, 2007
data_subset <- data_file[data_file$Date >= as.Date("2007-02-01") & data_file$Date <= as.Date("2007-02-02"),]

#Create Histogram
png(file = 'plot1.png', width = 480, height = 480)
hist(data_subset$Global_active_power, main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', col = 'red', ylim = c(0,1200))
dev.off()
