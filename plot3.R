
# Course 4, Week 1, project. Script to create plot3.png

# load the dplyr package for easy dataframe manipulation
library(dplyr)

# load the lubridate package for easy conversion to date/time
library(lubridate)

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


# conversion to a date time object and add it as a new column
datetime <- paste(df$Date, df$Time)
datetime <- dmy_hms(datetime)
df$datetime <- datetime

# launch the png device
png(filename = "plot3.png", width = 480, height = 480)

# initialize the plot, 
plot(df$datetime, df$sub1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering")


# now plot the values
with(df, {
        lines( datetime, sub2, col = "red")
        lines( datetime, sub3, col = "blue")
})

# add the legend
legend(x = "topright", lty = 1, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"))

# close the file device
dev.off()

