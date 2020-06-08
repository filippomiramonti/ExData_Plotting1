## Downloading dataset .zip file and unzip to working directory if necessary
if(!file.exists("household_power_consumption.txt")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, "EPC.zip", method = "curl", mode = "wd")
    unzip(zipfile = "EPC.zip")
}

## Cleaning and selecting data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na = "?")
DT <- paste(data$Date, data$Time)
data$DateandTime <- strptime(DT, "%d/%m/%Y %H:%M:%S")
rm(DT)
data <- data[data$DateandTime > "2007-02-01" & data$DateandTime < "2007-02-03" & is.na(data$DateandTime) == FALSE, c(-1, -2)]

## Create plot
par(mfrow = c(2, 2))

## Plot "topleft"
with(data, plot(DateandTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

## Plot "topright"
with(data, plot(DateandTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

## Plot "bottomleft"
with (data, plot(DateandTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with (data, lines(DateandTime, Sub_metering_2, col = "red"))
with (data, lines(DateandTime, Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, adj = c(0, 0.5), cex = 0.8)

## Plot "bottomright"
with(data, plot(DateandTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

## Copy my plot to a .png file (if you read "gio", "ven" and "sab" in the .png file, it's because i've installed R in italian)
dev.copy(png, file = "plot4.png")
dev.off()