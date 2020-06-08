## Downloading dataset .zip file and unzip to working directory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "EPC.zip", method = "curl", mode = "wd")
unzip(zipfile = "EPC.zip")

## Cleaning and selecting data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na = "?")
DT <- paste(data$Date, data$Time)
data$DateandTime <- strptime(DT, "%d/%m/%Y %H:%M:%S")
data <- data[data$DateandTime > "2007-02-01" & data$DateandTime < "2007-02-03" & is.na(data$DateandTime) == FALSE, c(-1, -2)]

## Create histogram
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Copy my plot to a .png file
dev.copy(png, file = "plot1.png")
dev.off()