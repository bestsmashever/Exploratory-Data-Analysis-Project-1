# Download the Data

## Get the working directory
wd <- getwd()
## Define the destfile
DestFile <- paste(wd, "household_power_consumption.zip", sep ="")
## Download the file and process it
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", DestFile)
MyData <- unzip(DestFile)
unlink(DestFile)

# Make the plot

## Read Data
power <- read.table(file=MyData, sep = ";", skip = 1)
names(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power","Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2","Sub_metering_3")
## Get the data from 1/2/2007 to 2/2/2007
epower <- power[power$Date=="1/2/2007" | power$Date=="2/2/2007", ]
## Set the graph to be composite
par(mfrow = c(2, 2))
## Format the date
DateTime <- strptime(paste(epower$Date, epower$Time), format = "%d/%m/%Y %H:%M:%S")
submetering1 <- as.numeric(as.factor(epower$Sub_metering_1))
submetering2 <- as.numeric(as.factor(epower$Sub_metering_2))
submetering3 <- as.numeric(as.factor(epower$Sub_metering_3))
## Plot 1
hist(as.numeric(as.character(epower$Global_active_power)), col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
## Plot 2
plot(DateTime, as.numeric(as.character(epower$Voltage)),type = "l", xlab = "datetime", ylab = "Voltage")
## Plot 3
plot(DateTime, submetering1, type ="l", xlab = "", 
     ylab = "Energy sub metering")
lines(DateTime, submetering2, type = "l", col = "red")
lines(DateTime, submetering3, type = "l", col = "blue")
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2",
                                  "Sub_metering_3"), col = c("black", "red", "blue"), 
       lty = 1, cex = 0.5)
## Plot 4
plot(DateTime, as.numeric(as.factor(epower$Global_reactive_power)), 
     type ="l", xlab = "datetime", ylab = "Global_reactive_power")
## Save to png
dev.copy(png, "plot4.png", width = 480, height = 480)
## Close the png device
dev.off()
