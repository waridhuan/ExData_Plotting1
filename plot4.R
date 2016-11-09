#download data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"./Electric_Power_Consumption.zip")

#unzip data
?unzip
unzip("./Electric_Power_Consumption.zip")

#read data
?read.table
housedata<-read.table("household_power_consumption.txt", sep = ";", header=TRUE, na.strings = "?")

dim(housedata)

names(housedata)
class(housedata$Date)
head(housedata)
tail(housedata)

#subsetting to pick data with date 1/2/2007 - 2/2/2007 only
?subset
house<-subset(housedata, Date == "1/2/2007" | Date == "2/2/2007")

#re-class Date
?strptime
?as.Date

house$Date<-as.Date(house$Date, format = "%d/%m/%Y")
class(house$Date)

#Create new variable combining Date and Time

house$DateTime<-as.POSIXct(paste(house$Date,house$Time))
class(house$DateTime)

#plot4.R-----------------------

#open device
png(filename = './Plots/plot4.png', width = 480, height = 480, units='px')

#plot all 4 line chart
par(mfrow=c(2,2), mar=c(4,4,2,1))

plot(house$DateTime, house$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(house$DateTime, house$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(house$DateTime, house$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(house$DateTime, house$Sub_metering_2, col="red")
lines(house$DateTime, house$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black","red","blue"))

plot(house$DateTime, house$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()