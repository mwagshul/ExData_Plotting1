# install package needed for reading in data
install.packages("sqldf")
library(sqldf)

# read in data, only from 2/1 - 2/2/2007 (note dates are British format dd/mm/year)
elecData <- read.csv.sql("household_power_consumption.txt","select * from file where Date = '1/2/2007' or Date = '2/2/2007' ",sep=";")

# Convert dates 
elecData$Date <- strptime(elecData$Date,"%d/%m/%Y")
# combine date and time into single object, needed for plotting
dateTime <- as.POSIXct(paste(elecData$Date,elecData$Time))

# Plot 4 subplots
png(filename = "plot4.png")
par(mfrow=c(2,2))
par(mar=c(3,3,1,0.5))
plot(dateTime,elecData$Global_active_power,type = 'l',main = "", ylab = "", xlab = "",cex.main=1.0,cex.axis=1.0)
title(ylab = "Global active power", line = 2,cex.lab = 1.0,cex.main=1.0)
plot(dateTime,elecData$Voltage,type = 'l',main = "", xlab = "",ylab = "",cex.main=1.0,cex.lab=1.0,cex.axis=1.0)
title(xlab = "datetime", ylab = "Voltage", line = 2,cex.lab = 1.0,cex.main=1.0)
plot(dateTime,input$Sub_metering_1,type = 'l',main = "", xlab = "",ylab = "", ylim=c(0,38),cex.axis=1.0,cex.main=1.0)
par(new=TRUE)
plot(dateTime,input$Sub_metering_2,type = 'l',main = "", xlab = "",ylab = "", col="red",ylim=c(0,38),cex.axis=1.0,cex.lab=1.0,cex.main=1.0)
par(new=TRUE)
plot(dateTime,input$Sub_metering_3,type = 'l',main = "", xlab = "", ylab = "", col="blue",ylim=c(0,38),cex.axis=1.0,cex.lab=1.0,cex.main=.5)
title(ylab = "Energy sub metering", line = 2,cex.lab = 1.0,cex.main=.5)
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1,cex=1.0,bty = "n")

plot(dateTime,elecData$Global_reactive_power,type = 'l',main = "", xlab = "", ylab = "", cex.main=1.0,cex.axis=1.0,cex.lab=1.0,cex.main=.5)
title(xlab = "datetime",ylab = "Global reactive power", line = 2,cex.lab = 1.0,cex.main=.5)
dev.off()