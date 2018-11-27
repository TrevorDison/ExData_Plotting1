################################################################################
# Johns Hopkins University
# Data Science Course
# 4. Exploratory Data Analysis
# Week 1 Project, November 26, 2018
################################################################################

# This script downloads and unzips a file of electric power consumption and 
#   generates a lattice of 4 plots (Plot 4) energy data.
#   It then outputs the chart to a png file into the working directory.

# If the data is already loaded, skip to # Create Plot 4

################################################################################

# Download file from website and unzip
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
energy <- read.table(unz(temp, "household_power_consumption.txt"),
                     sep = ";", header = T, na.strings = "?")
unlink(temp)

# Convert Date and Time from factor to dates and times and combine into one field
energy$datetime <- strptime(paste(energy$Date, energy$Time), 
                            format = "%d/%m/%Y %H:%M:%S")

# Filter data on dates we are examining
energy <- subset(energy, datetime > "2007-02-01" & datetime < "2007-02-03")

################################################################################

# Create Plot 4
par(mfrow = c(2,2))

# top left chart (same as Plot 2)
with(energy, plot(datetime, Global_active_power, 
                  type = "l",
                  xlab = "",
                  ylab = "Global Active Power"))

# top left chart (new chart)
with(energy, plot(datetime, Voltage, 
                  type = "l"))

# bottom left chart (same as Plot 3)
with(energy, plot(datetime, Sub_metering_1, 
                  type = "l",
                  col = "black",
                  xlab = "",
                  ylab = "Energy sub metering"))
lines(energy$datetime, energy$Sub_metering_2, 
      type = "l",
      col = "red")
lines(energy$datetime, energy$Sub_metering_3, 
      type = "l",
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd = c(1,1,1), 
       cex = .5,
       col = c("black","red","blue"))

# bottom right chart (new chart)
with(energy, plot(datetime, Global_reactive_power, 
                  type = "l"))

# Save as png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

################################################################################