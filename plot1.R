
# Course 4, Week 1, project. Script to create plot1.png

# load the dplyr package for easy dataframe manipulation
library(dplyr)

# load the lubridate package for easy conversion to date
library(lubridate)

# After seeing the dataset starts from 2016-12-16, 
# I figured 100,000 rows should be enough to contain 2007-02-01 to 2007-02-02
big_df <- read.csv("household_power_consumption.txt", nrow = 1e5, sep = ";", stringsAsFactors = FALSE, na.strings = "?")

# extract the rows with the dates we want to work with
df <- filter(big_df, Date == "1/2/2007" | Date == "2/2/2007")

# convert the column to numeric and save it to vector v
v <- as.numeric(df$Global_active_power)

# convert the Date column to date
dates <- dmy(df$Date)

# Confirm that the two days we extracted are Thursday and Friday
print(table(wday(dates, label = TRUE)))

# launch the png device
png(filename = "plot1.png", width = 480, height = 480)

# plot the histogram
hist(as.numeric(df$Global_active_power), col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# close the file device
dev.off()

# Note: from the histogram it may look as though there are no values above 5.5, but
# in fact 4 of the 2880 values are above 5.5.
