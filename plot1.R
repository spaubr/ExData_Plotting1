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

# Plot #1
png(filename = "~/EDA1/plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()