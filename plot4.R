
# Course 4, Week 1, project. Script to create plot4.png

# load the dplyr package for easy dataframe manipulation
library(dplyr)


# load the lubridate package for easy conversion to date/time
library(lubridate)

# After seeing the dataset starts from 2016-12-16, 
# I figured 100,000 rows should be enough to contain 2007-02-01 to 2007-02-02
# this time I specify the colClasses right away 
big_df <- read.csv("household_power_consumption.txt", nrow = 1e5, 
                   sep = ";", na.strings = "?",
                   colClasses = c("character", "character", rep("numeric", 7)))

# extract the rows with the dates we want to work with
df <- filter(big_df, Date == "1/2/2007" | Date == "2/2/2007")


# conversion to a date time object and add it as a new column
datetime <- paste(df$Date, df$Time)
datetime <- dmy_hms(datetime)
df$datetime <- datetime


# launch the png device
png(filename = "plot4.png", width = 480, height = 480)

# set a 2x2 panel for the four graphs
par(mfrow = c(2, 2)) 
with(df, {
        # first graph
        plot(datetime, Global_active_power,  ylab = "Global Active Power", 
              type = "l", xlab = "")

        
        # second graph
        plot(datetime, Voltage,  ylab = "Voltage", type = "l", xlab = "datetime")

        
        # third graph
        plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
        
        lines(datetime, Sub_metering_2, col = "red")
        lines(datetime, Sub_metering_3, col = "blue")
        legend(x = "topright", lty = 1, 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               col = c("black", "red", "blue"), bty = "n")

        
        # fourth graph
        plot(datetime, Global_reactive_power, 
             type = "l", xlab = "datetime")

        
})

# close the file device
dev.off()

