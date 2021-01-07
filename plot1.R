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

### Plot 1
## open PNG device
png(filename = "plot1.png", height = 480, width = 480, units = "px")
## create a plot with annotations
hist(mysubset$Global_active_power, xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red")
## close the PNG device
dev.off()