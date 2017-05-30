# source("downloadData.R");
if (!file.exists("coursera-dd-downloaded-data.zip") 
    && !file.exists("household_power_consumption.txt")) {
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                destfile="coursera-dd-downloaded-data.zip");
  unzip("coursera-dd-downloaded-data.zip");
}

# read the data. Reads entire file - not very efficient

pwdata <- read.table("household_power_consumption.txt", header = TRUE, 
                     sep=";", stringsAsFactors = FALSE, dec = ".", na.strings="?",
                     colClasses = c("character", "character", "double",
                                    "double", "double", "double", "double",
                                    "double", "double"));

pwdata$Date <- as.Date(pwdata$Date, format="%d/%m/%Y");
pwdata <- subset(pwdata, Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02"));

timevals <- strptime(paste(pwdata$Date, pwdata$Time, sep = ' '), format= '%Y-%m-%d %H:%M:%S');

# first plot
png("plot4.png", width=480, height=480);
par(mfrow = c(2, 2));
plot(timevals, pwdata$Global_active_power, 
     ylab = "Global Active Power",
     xlab='', type='l');

plot(timevals, pwdata$Voltage, 
     ylab = "Voltage",
     xlab='datetime', type='l');


plot(timevals, pwdata$Sub_metering_1, 
     ylab = "Energy sub metering",
     xlab='', type='l', col="black");
lines(timevals, pwdata$Sub_metering_2, col="red");
lines(timevals, pwdata$Sub_metering_3, col="blue");
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1);

plot(timevals, pwdata$Global_reactive_power, 
     ylab = "Global_reactive_power",
     xlab='datetime', type='l');

dev.off()
