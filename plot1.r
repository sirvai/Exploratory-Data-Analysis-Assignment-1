# =====
# PLOT 1
# =====

# load libraries
library(data.table)

# ==========
# THE DATA
# load the data
power <- fread("~/household_power_consumption.txt", sep = ";",
               header = T, stringsAsFactors = F, dec = ".")

# subset the data for the wanted dates
power <- power[which(Date == "1/2/2007" | Date == "2/2/2007"),]

# put the Date variable in a date format
power$Date = as.Date(power$Date, '%d/%m/%Y')

# make it numeric
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
power$Voltage <- as.numeric(power$Voltage)
power$Global_intensity <- as.numeric(power$Global_intensity)
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)

# make the Time variable a real time
power$Time <- paste(power$Date, power$Time)
power$Time <- as.POSIXct(strptime(power$Time, '%Y-%m-%d %H:%M:%S'))

# calculate min time and max time, which will be used in the x axis
xlim_min = as.POSIXct(strftime("2007-02-01 00:00:00"))
xlim_max = as.POSIXct(strftime("2007-02-03 00:00:00"))

# ==========
#
# ==========
# THE PLOT
png("plot1.png", width = 480, height = 480)

hist(power$Global_active_power, breaks = 12, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

dev.off()