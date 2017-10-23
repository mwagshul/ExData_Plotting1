# install package needed for reading in data
install.packages("sqldf")
library(sqldf)

# read in data, only from 2/1 - 2/2/2007 (note dates are British format dd/mm/year)
elecData <- read.csv.sql("household_power_consumption.txt","select * from file where Date = '1/2/2007' or Date = '2/2/2007' ",sep=";")

# Convert dates 
elecData$Date <- strptime(elecData$Date,"%d/%m/%Y")
# combine date and time into single object, needed for plotting
dateTime <- as.POSIXct(paste(elecData$Date,elecData$Time))

# Plot sub metering data, three sub measurement on single plot
png(filename = "plot3.png")
plot(dateTime,input$Sub_metering_1,type = 'l',main = "", ylab = "Energy sub metering", xlab = "",ylim=c(0,38),cex.lab=1.0,cex.axis=1.0)
par(new=TRUE)
plot(dateTime,input$Sub_metering_2,type = 'l',main = "", ylab = "Energy sub metering", xlab = "",col="red",ylim=c(0,38),cex.lab=1.0,cex.axis=1.0)
par(new=TRUE)
plot(dateTime,input$Sub_metering_3,type = 'l',main = "", ylab = "Energy sub metering", xlab = "",col="blue",ylim=c(0,38),cex.lab=1.0,cex.axis=1.0)
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1,cex=1.0)
dev.off()