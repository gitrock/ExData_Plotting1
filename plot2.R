
# Course 4, Week 1, project. Script to create plot2.png

# load the dplyr package for easy dataframe manipulation
library(dplyr)

# After seeing the dataset starts from 2016-12-16, 
# I figured 100,000 rows should be enough to contain 2007-02-01 to 2007-02-02
big_df <- read.csv("household_power_consumption.txt", nrow = 1e5, sep = ";", stringsAsFactors = FALSE, na.strings = "?")

# extract the rows with the dates we want to work with
df <- filter(big_df, Date == "1/2/2007" | Date == "2/2/2007")

# convert the column to numeric and save it to vector v
v <- as.numeric(df$Global_active_power)

# launch the png device
png(filename = "plot2.png", width = 480, height = 480)

# initialize the plot with no x-axis, and do not display anything yet
plot(v, xaxt = "n", type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")

# day changes from Thu to Fri in the middle 
axis(side = 1, at = c(1, length(v)/2 + 1, length(v) + 1), labels = c("Thu", "Fri", "Sat"))

# now we can plot v
lines(v)

# close the file device
dev.off()
