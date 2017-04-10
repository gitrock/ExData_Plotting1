
# Course 4, Week 1, project. Script to create plot3.png

# load the dplyr package for easy dataframe manipulation
library(dplyr)

# After seeing the dataset starts from 2016-12-16, 
# I figured 100,000 rows should be enough to contain 2007-02-01 to 2007-02-02
big_df <- read.csv("household_power_consumption.txt", nrow = 1e5, 
                   sep = ";", stringsAsFactors = FALSE, na.strings = "?")

# extract the rows with the dates we want to work with
df <- filter(big_df, Date == "1/2/2007" | Date == "2/2/2007")

# convert the columns I'll work with to numeric and save them as new columns
df <- mutate(df, sub1 =  as.numeric(Sub_metering_1), 
             sub2 = as.numeric(Sub_metering_2),
             sub3 = as.numeric(Sub_metering_3))

# launch the png device
png(filename = "plot3.png", width = 480, height = 480)

# initialize the plot with no x-axis, and do not display anything yet
plot(df$sub1, xaxt = "n", type = "n", xlab = "", ylab = "Energy sub metering")

# add the x-axis. day changes from Thu to Fri in the middle 
axis(side = 1, at = c(1, nrow(df)/2 + 1, nrow(df) + 1), labels = c("Thu", "Fri", "Sat"))

# now plot the values
with(df, {
        lines(sub1, col = "black")
        lines(sub2, col = "red")
        lines(sub3, col = "blue")
})

# add the legend
legend(x = "topright", lty = 1, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"))

# close the file device
dev.off()

