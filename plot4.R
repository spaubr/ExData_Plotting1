setwd("~/")
# If loop: Check for "data" directory.  Create one if needed.
if (!file.exists("data")) {
        dir.create("data")
}

# Download data
if (!file.exists("./data/EDA_Proj1.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./data/EDA_Proj1.zip")
}

# Extract .zip files into "data" directory
if (!file.exists("~/data/household_power_consumption.txt")) {
        unzip("./data/EDA_Proj1.zip", exdir = "./data")        
}

# Read the data into R
data <- read.table("~/data/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")

# Subset data to the relevant dates
data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

# Create a single datetime variable in the correct format
data$datetime <- paste0(data$Date, " ", data$Time)
data$datetime <- as.POSIXct(data$datetime, format = "%d/%m/%Y %H:%M:%S")

# Plot 4
png(filename = "~/EDA1/plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(data, {
        hist(data$Global_active_power, col = "red", xlab = "Global Active Power", main = "")
        
        plot(data$datetime, data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
        
        plot(data$datetime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
        lines(data$datetime, data$Sub_metering_2, col = "red")
        lines(data$datetime, data$Sub_metering_3, col = "blue")
        legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
        
        plot(data$datetime, data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})
dev.off()
