# read in the table
setwd("~/Downloads")

#read in the text file to create a data frame
data <- read.table(file ="household_power_consumption.txt", header = TRUE, quote = "", sep = ";", 
                   stringsAsFactors = FALSE)
#subset the data 
dataSub <- data[(data$Date == "2007-02-02" | data$Date == "2007-02-01"),]

#create the date & time combo that will be the X axis
dataSub <- within(dataSub, { timestamp=strptime(paste(dataSub$Date, dataSub$Time), "%Y-%m-%d %H:%M:%S") })

#convert to POSIXct to be able to use with dplyr MUTATE
dataSub$timestamp <-as.POSIXct(dataSub$timestamp)
dataSub$dow <-weekdays(dataSub$Date)
# mutate the character fields to numeric for plotting
library(dplyr)
dataSub <- dataSub %>%
  mutate(Global_active_power = as.numeric(Global_active_power),
         Global_reactive_power = as.numeric(Global_reactive_power),
         Voltage = as.numeric(Voltage),
         Global_intensity = as.numeric(Global_intensity),
         Sub_metering_1 = as.numeric(Sub_metering_1),
         Sub_metering_2 = as.numeric(Sub_metering_2),
         Sub_metering_3 = as.numeric(Sub_metering_3))

#set directory where I save the file to
setwd("~/Documents/Coursera_DS/Exploratory_Data/ExData_Plotting1/figure")

png(file="plot4.png",width=480,height=480)
par(mfrow = c(2,2))
#Make plot 1
plot(dataSub$timestamp,dataSub$Global_active_power, xlim = dataSub$dayOfWeek,
     type = "l", xlab = "" , ylab = "Global Active Power (kilowatts)")

#Make plot 2
plot(dataSub$timestamp,dataSub$Voltage, xlim = dataSub$dayOfWeek,
     type = "l", xlab = "" , ylab = "Voltage")

#Make plot 3
#library(ggplot2)
# create the plot with device driver
# png(file="plot3.png",width=480,height=480)
# ggplot(dataSub, aes(dataSub$timestamp)) + 
#   geom_line(aes(y = dataSub$Sub_metering_1, colour = "Sub Metering 1")) + 
#   geom_line(aes(y = dataSub$Sub_metering_2, colour = "Sub Metering 2")) +
#   geom_line(aes(y = dataSub$Sub_metering_3, colour = "Sub Metering 3")) +
#   xlab(dataSub$dow)+
#   ylab("Energy Sub Metering")
#   dev.off()
 
  #base version of needed 
matplot(dataSub$timestamp, dataSub[,7:9], type = "b", pch=1 ,col = c('black','red','blue'),
        xlab=dataSub$dow, ylab = "Energy Sub Metering")

#Make plot 4
plot(dataSub$timestamp,dataSub$Global_reactive_power, xlim = dataSub$dayOfWeek,
     type = "l", xlab = "" , ylab = "Global Reactive Power")

dev.off()
