# read in the table
setwd("~/Downloads")

#read in the text file to create a data frame
data <- read.table(file ="household_power_consumption.txt", header = TRUE, quote = "", sep = ";", 
                   stringsAsFactors = FALSE)

data$Date <- as.Date(data$Date, "%d/%m/%Y")
#subset the data for the dates we are interested in
dataSub <- data[(data$Date == "2007-02-02" | data$Date == "2007-02-01"),]


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
png(file="plot1.png",width=480,height=480)
hist(dataSub$Global_active_power,
     include.lowest = TRUE, right = TRUE,
     col = 'red',
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")
dev.off()


