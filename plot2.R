
# Course 4, Week 1, project. Script to create plot2.png

# load the dplyr package for easy dataframe manipulation
library(dplyr)

# load the lubridate package for easy conversion to date/time
library(lubridate)

# After seeing the dataset starts from 2016-12-16, 
# I figured 100,000 rows should be enough to contain 2007-02-01 to 2007-02-02
big_df <- read.csv("household_power_consumption.txt", nrow = 1e5, sep = ";", stringsAsFactors = FALSE, na.strings = "?")

# extract the rows with the dates we want to work with
df <- filter(big_df, Date == "1/2/2007" | Date == "2/2/2007")

# convert the column to numeric and save it to vector v
v <- as.numeric(df$Global_active_power)

# conversion to a date time object
datetime <- paste(df$Date, df$Time)
datetime <- dmy_hms(datetime)

# launch the png device
png(filename = "plot2.png", width = 480, height = 480)

# plot
plot(datetime, v,  type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")


# close the file device
dev.off()
