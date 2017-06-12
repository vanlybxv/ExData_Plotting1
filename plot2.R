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

# create the plot with device driver
png(file="plot2.png",width=480,height=480)
plot(dataSub$timestamp,dataSub$Global_active_power, xlim = dataSub$dayOfWeek,
     type = "l", xlab = "" , ylab = "Global Active Power (kilowatts)")
dev.off()





