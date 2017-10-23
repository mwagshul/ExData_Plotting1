# install package needed for reading in data
install.packages("sqldf")
library(sqldf)

# read in data, only from 2/1 - 2/2/2007 (note dates are British format dd/mm/year)
elecData <- read.csv.sql("household_power_consumption.txt","select * from file where Date = '1/2/2007' or Date = '2/2/2007' ",sep=";")

# Convert dates 
elecData$Date <- strptime(elecData$Date,"%d/%m/%Y")
# combine date and time into single object, needed for plotting
dateTime <- as.POSIXct(paste(elecData$Date,elecData$Time))

# Plot histogram of global active power
png(filename = "plot1.png")
hist(elecData$Global_active_power,col = "red",xlab = "Global active power (kilowatts)",main = "Global active power",cex.main=.75,cex.lab=.75,cex.axis=.75)
dev.off()