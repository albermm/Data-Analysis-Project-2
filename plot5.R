## Read data from files        
        emissions <- readRDS("./summarySCC_PM25.rds")
        classification <- readRDS("./Source_Classification_Code.rds")


## Subset the required information
        library(plyr)
        BaltimoreRoad <- emissions[which(emissions$fips == "24510" & emissions$type == "ON-ROAD"), ]
        mergedRoad <- merge(BaltimoreRoad, classification, by="SCC")
        total <- ddply(mergedRoad, c("year", "type"), summarise, 
                           Emissions = sum(Emissions))

## Plot the results
        library(ggplot2)

        # First graph will be the emissions by year        
        png("plot5.png")
        g <- ggplot(mergedRoad, aes(year, Emissions))
        g + geom_jitter(aes(color=year), size=2, alpha=0.8) + geom_smooth(method = "lm", colour = "orange", size=1.1) + 
                coord_cartesian(ylim = c(0, 20)) +
                labs(x="Year") +
                labs(y = expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) +
                labs(title = expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) 
        dev.off()
        
        #Let's see how it goes when we add up all the emissions per year
        png("plot5total.png")
        g <- ggplot(total, aes(year, Emissions))
                g + geom_line(aes(color=type)) +
                labs(x="Year") +
                labs(y = expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) +
                labs(title = expression("Baltimore City" ~ PM[2.5] ~ "TOTAL Motor Vehicle Emissions by Year"))     
        dev.off()
        
        