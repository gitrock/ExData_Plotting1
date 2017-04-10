
# Course 4, Week 1, project. Script to create plot4.png

# load the dplyr package for easy dataframe manipulation
library(dplyr)

# After seeing the dataset starts from 2016-12-16, 
# I figured 100,000 rows should be enough to contain 2007-02-01 to 2007-02-02
# this time I specify the colClasses right away 
big_df <- read.csv("household_power_consumption.txt", nrow = 1e5, 
                   sep = ";", na.strings = "?",
                   colClasses = c("character", "character", rep("numeric", 7)))

# extract the rows with the dates we want to work with
df <- filter(big_df, Date == "1/2/2007" | Date == "2/2/2007")

# launch the png device
png(filename = "plot4.png", width = 480, height = 480)

# set a 2x2 panel for the four graphs
par(mfrow = c(2, 2)) 
with(df, {
        # first graph
        plot(Global_active_power,  ylab = "Global Active Power", 
             xaxt = "n", type = "n", xlab = "")
        lines(Global_active_power)
        axis(side = 1, at = c(1, nrow(df)/2 + 1, nrow(df) + 1), 
             labels = c("Thu", "Fri", "Sat"))
        
        # second graph
        plot(Voltage,  ylab = "Voltage", xaxt = "n", type = "n", xlab = "datetime")
        lines(Voltage)
        axis(side = 1, at = c(1, nrow(df)/2 + 1, nrow(df) + 1), 
             labels = c("Thu", "Fri", "Sat"))
        
        # third graph
        plot(Sub_metering_1,  ylab = "Energy sub metering", xaxt = "n", 
             type = "n", xlab = "")
        
        lines(Sub_metering_1, col = "black")
        lines(Sub_metering_2, col = "red")
        lines(Sub_metering_3, col = "blue")
        legend(x = "topright", lty = 1, 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               col = c("black", "red", "blue"), bty = "n")
        axis(side = 1, at = c(1, nrow(df)/2 + 1, nrow(df) + 1), 
             labels = c("Thu", "Fri", "Sat"))
        
        # fourth graph
        plot(Global_reactive_power, 
             xaxt = "n", type = "n", xlab = "datetime")
        lines(Global_reactive_power)
        axis(side = 1, at = c(1, nrow(df)/2 + 1, nrow(df) + 1), 
             labels = c("Thu", "Fri", "Sat"))
        
})

# close the file device
dev.off()

