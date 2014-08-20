
## Read data from files        
        emissions <- readRDS("./summarySCC_PM25.rds")
        classification <- readRDS("./Source_Classification_Code.rds")

## Subset the required information
        Baltimore <- emissions[ which(emissions$fips == "24510"), ]
        totalBaltimore <- tapply(emissions$Emissions, emissions$year, sum)
        
## Plot data
        png("plot2.png")
        plot(names(totalBaltimore), totalBaltimore, type="l", 
             xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
             main=expression("Total Baltimore City, Maryland" ~ PM[2.5] ~ "Emissions by Year"))
        dev.off()