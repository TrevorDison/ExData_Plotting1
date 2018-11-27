################################################################################
# Johns Hopkins University
# Data Science Course
# 4. Exploratory Data Analysis
# Week 1 Project, November 26, 2018
################################################################################

# This script downloads and unzips a file of electric power consuption and 
#   generates a line chart (Plot 3) of three variables.
#   It then outputs the chart to a png file into the working directory.

# If the data is already loaded, skip to # Create Plot 3

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

# Create Plot 3
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
       col = c("black","red","blue"))

# Save as png file
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

################################################################################