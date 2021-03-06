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
names(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                  "Voltage", "Global_intensity", "Sub_metering_1", 
                  "Sub_metering_2", "Sub_metering_3")
## Get the data from 1/2/2007 to 2/2/2007
epower <- power[power$Date=="1/2/2007" | power$Date=="2/2/2007", ]
## Format the date
DateTime <- strptime(paste(epower$Date, epower$Time), format = "%d/%m/%Y %H:%M:%S")
## Plot
plot(DateTime, as.numeric(as.character(epower$Global_active_power)), 
     type = "l", xlab = " ", ylab = "Global Active Power (kilowatts)")
## Save to png
dev.copy(png, "plot2.png", width = 480, height = 480)
## Close the png device
dev.off()
