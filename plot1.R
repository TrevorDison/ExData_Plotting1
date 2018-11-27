################################################################################
# Johns Hopkins University
# Data Science Course
# 4. Exploratory Data Analysis
# Week 1 Project, November 26, 2018
################################################################################

# This script downloads and unzips a file of electric power consumption and 
#   generates a histogram (Plot 1) of the Global Active Power in kilowatts.
#   It then outputs the chart to a png file into the working directory.

# If the data is already loaded, skip to # Create Plot 1

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

# Create Plot 1
hist(energy$Global_active_power, 
     col= "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

# Save as png file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

################################################################################