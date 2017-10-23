# install package needed for reading in data
install.packages("sqldf")
library(sqldf)

# read in data, only from 2/1 - 2/2/2007 (note dates are British format dd/mm/year)
elecData <- read.csv.sql("household_power_consumption.txt","select * from file where Date = '1/2/2007' or Date = '2/2/2007' ",sep=";")

# Convert dates 
elecData$Date <- strptime(elecData$Date,"%d/%m/%Y")
# combine date and time into single object, needed for plotting
dateTime <- as.POSIXct(paste(elecData$Date,elecData$Time))

# Plot Global active power vs. time
png(filename = "plot2.png")
plot(dateTime,elecData$Global_active_power,type = 'l',main = "", ylab = "Global active power (kilowatts)", xlab = "",cex.lab=1.0,cex.axis=1.0)
dev.off()