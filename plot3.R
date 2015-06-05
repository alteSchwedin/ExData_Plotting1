plot3 <- function(){
        # read data
        library(data.table)
        data <- fread("household_power_consumption.txt", na.strings = "?",
                      skip = 66637, nrows = 2879, header = TRUE)
        
        # when skipping rows, header is not available, get it from first row
        dataNames <- names(fread("household_power_consumption.txt", nrow = 1))
        setnames(data, dataNames)
        
        # make additional column with DateTime value
        data[,DateTime := as.POSIXct(paste(Date, Time), 
                                     format = "%d/%m/%Y %H:%M:%S")]
        
        # plot is going to png directly
        png(file = "plot3.png")
        
        # convert needed data to numeric and plot it
        data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
        data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
        data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
        
        plot(data$DateTime, data$Sub_metering_1,
             xlab = NA, sub = NA,
             ylab = "Global Active Power (kilowatts)",
             type = "l", cex = 0.1)
        lines(data$DateTime, data$Sub_metering_2, col = "red")
        lines(data$DateTime, data$Sub_metering_3, col = "blue")
        
        legend("topright", legend = c("Sub_metering_1",
                "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"),
               lty = 1)

        dev.off()
}