plot3 <- function() {
    #
    # data dictonary
    #
    # Date: Date in format dd/mm/yyyy
    # Time: time in format hh:mm:ss
    # Global_active_power: household global minute-averaged active power (in kilowatt)
    # Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
    # Voltage: minute-averaged voltage (in volt)
    # Global_intensity: household global minute-averaged current intensity (in ampere)
    # Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
    # Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
    # Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
    #
    # download file
    
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, "power.zip")
    
    # load data, separator = ";", NA = "?"
    
    edata <- read.table(unz("power.zip", "household_power_consumption.txt") ,header = TRUE, sep=";",na.strings="?")
    
    # load libraries
    
    library(plyr)
    library(dplyr)
    
    # filter on dates 2007-02-01 and 2007-02-02
    
    edata <- filter(edata, Date == "1/2/2007" | Date == "2/2/2007")
    
    # combine date and time and convert to date-time object
    
    edata$DateTime <- paste(edata$Date,edata$Time)
    edata$DateTime <-strptime(edata$DateTime, "%d/%m/%Y %H:%M:%S")
    
    # create plot3.png i.e. open png device, plot line graph, close device
    
    png(file = "plot3.png")
    with(edata, plot(DateTime,                                   # x-axis
                     Sub_metering_1,                             # y-axis
                     type ="l",                                  # type is line graph
                     xlab = "",                                  # no x-axis label
                     ylab = "Energy sub metering"))              # y-axis label
    with(edata, lines(DateTime, Sub_metering_2, col = "red"))    # add sub_metering_2 in red
    with(edata, lines(DateTime, Sub_metering_3, col = "blue"))   # add sub_metering_3 in blue 
    
    # add legend
    
    legend("topright", 
           lty = 1, 
           col = c("black", "red", 'blue'), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    dev.off()    
}