

##Download and unzip Files
        data <- download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "Data Analysis Project 2.zip")
        datos <- unzip("Data Analysis Project 2.zip")

## Read data from files        
        emissions <- readRDS("./summarySCC_PM25.rds")
        classification <- readRDS("./Source_Classification_Code.rds")

## Add total emissions per year
        totalEmissions <- tapply(emissions$Emissions, emissions$year, sum)
        
## Plot the results
        png("plot1.png")
        plot(names(totalEmissions), totalEmissions, type="l",
        xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
        main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
        dev.off()