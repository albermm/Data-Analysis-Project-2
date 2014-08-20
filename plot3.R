## Read data from files        
        emissions <- readRDS("./summarySCC_PM25.rds")
        classification <- readRDS("./Source_Classification_Code.rds")

        
## Subset the required information
        library(plyr)
        Baltimore <- emissions[ which(emissions$fips == "24510"), ]
        plotData <- ddply(Baltimore, c("type", "year"), summarise, 
                               total = sum(Emissions))
        
## Plot data
        library(ggplot2)
        png("plot3.png")
                g <- ggplot(plotData, aes(year, total))
                g + geom_line(aes(color=type)) +
                facet_grid(.~ type) +
                labs(x="Year") +
                labs(y = expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) +
                labs(title = expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year"))        
        dev.off()
        