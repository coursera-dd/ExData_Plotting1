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
pwdata <- subset(pwdata, Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02"))

# first plot
png("plot1.png", width=480, height=480);
hist(pwdata$Global_active_power, 
     xlab = "Global Active Power (kilowatts)",
     col="red", main ="Global Active Power");
dev.off()
