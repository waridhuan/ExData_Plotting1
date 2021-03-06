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



#Plot2.R---------------------------

#open device
png(filename = './Plots/plot2.png', width = 480, height = 480, units='px')

#plot line chart

?plot
plot(house$DateTime, house$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()

