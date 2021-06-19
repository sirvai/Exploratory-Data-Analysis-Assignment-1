# =====
# PLOT 4
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
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2)) # adjust the area

# first plot
plot(power$Time,
     power$Global_active_power,
     xlim = c(xlim_min, xlim_max),
     xaxt = "n",
     type = "l",
     xlab = "",
     ylab = "Global Active Power"
)
axis.POSIXct(1,
             at = seq(xlim_min, xlim_max, by = "day"),
             format = "%a")

# second plot
plot(power$Time,
     power$Voltage,
     xlim = c(xlim_min, xlim_max),
     xaxt = "n",
     type = "l",
     xlab = "datetime",
     ylab = "Voltage"
)
axis.POSIXct(1,
             at = seq(xlim_min, xlim_max, by = "day"),
             format = "%a")

# third plot
plot(power$Time,
     power$Sub_metering_1,
     xlim = c(xlim_min, xlim_max),
     xaxt = "n",
     type = "l",
     xlab = "",
     ylab = "Energy sub metering"
)

# add the other series
lines(power$Time, power$Sub_metering_2, col = "red")
lines(power$Time, power$Sub_metering_3, col = "blue")

axis.POSIXct(1,
             at = seq(xlim_min, xlim_max, by = "day"),
             format = "%a")

legend("topright",
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'),
       lty = c(1, 1, 1))

# fourth plot
plot(power$Time,
     power$Global_reactive_power,
     xlim = c(xlim_min, xlim_max),
     xaxt = "n",
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power"
)
axis.POSIXct(1,
             at = seq(xlim_min, xlim_max, by = "day"),
             format = "%a")

dev.off()