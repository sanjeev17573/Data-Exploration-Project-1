hpower_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Converting to Type Date
hpower_data$Date <- as.Date(hpower_data$Date, "%d/%m/%Y")

## subsetting data 
hpower_data <- subset(hpower_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# combine date and time 
date_time <- paste(hpower_data$Date, hpower_data$Time)
date_time <- setNames(date_time, "DateTime")

## Remove Date and Time column
hpower_data <- hpower_data[ ,!(names(hpower_data) %in% c("Date","Time"))]

## Add DateTime column
hpower_data <- cbind(date_time, hpower_data)

## Format dateTime Column
hpower_data$date_time <- as.POSIXct(date_time)

## Create Plot 3
with(hpower_data, {
  plot(Sub_metering_1~date_time, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~date_time,col='Red')
  lines(Sub_metering_3~date_time,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save file and close device
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()