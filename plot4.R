## download Data from the source

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "./Power_Consumption.zip", method = "curl")

unzip("Power_Consumption.zip")
powerConsumption<- read.table("household_power_consumption.txt", sep = ";",
                              header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

## subset only from date "1/2/2007" to "2/2/2007"
mysubset<- powerConsumption[c(powerConsumption$Date %in% c("1/2/2007", "2/2/2007")),]

# convert the Date and Time variables to Date/Time classes
mysubset$Date<- as.Date(mysubset$Date,"%d/%m/%Y")
mysubset$Time<- paste(mysubset$Date, mysubset$Time)
mysubset$Time<- strptime(mysubset$Time, format ="%Y-%m-%d %H:%M:%S" )

## Plot 4

## open PNG device

png(filename = "plot4.png", height = 480, width = 480, units = "px")
## create a plot with annotations

par(mfrow = c(2,2))

with(mysubset, plot(as.POSIXct(round(Time, "mins")) ,Global_active_power,
                    type = "l",ylab = "Global Active Power",
                    xlab = ""))

with(mysubset, plot(as.POSIXct(round(Time, "mins")) ,Voltage,
                    type = "l",ylab = "Voltage",
                    xlab = "datetime"))

with(mysubset, plot(as.POSIXct(round(Time, "mins")), Sub_metering_1, type = "n",
                    xlab = "", ylab = "Energy sub metering"))
points(as.POSIXct(round(mysubset$Time, "mins")), mysubset$Sub_metering_1, 
       col = "black", type = "l")
points(as.POSIXct(round(mysubset$Time, "mins")), mysubset$Sub_metering_2, 
       col = "red", type = "l")
points(as.POSIXct(round(mysubset$Time, "mins")), mysubset$Sub_metering_3, 
       col = "blue", type = "l")
legend("topright", lty = 1, lwd = 2, col = c("black", "red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


with(mysubset, plot(as.POSIXct(round(Time, "mins")) ,Global_reactive_power,
                    type = "l",ylab = "Global_reactive_power",
                    xlab = "datetime"))

## close the PNG device
dev.off()