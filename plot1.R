plot1 <- function(){
        # read data
        library(data.table)
        data <- fread("household_power_consumption.txt", na.strings = "?",
                      skip = 66637, nrows = 2879)
        
        # when skipping rows, header is not available, get it from first row
        dataNames <- names(fread("household_power_consumption.txt", nrow = 1))
        setnames(data, dataNames)
        
        # make additional column with DateTime value
        data[,DateTime := as.POSIXct(paste(Date, Time), 
                                     format = "%d/%m/%Y %H:%M:%S")]
        
        # plot is going to png directly
        png(file = "plot1.png")
        
        # convert needed data to numeric and plot it
        data$Global_active_power <- as.numeric(data$Global_active_power)
        hist(data$Global_active_power, 
             xlab = "Global Active Power (kilowatts)", 
             main = "Global Active Power",
             col = "red")
        
        dev.off()
}