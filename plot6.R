
## Read data from files        
        emissions <- readRDS("./summarySCC_PM25.rds")
        classification <- readRDS("./Source_Classification_Code.rds")


## Subset the required information
        library(plyr)
        countiesRoad <- emissions[which((emissions$fips == "24510" | emissions$fips ==  "06037") & emissions$type == "ON-ROAD"), ]
        mergedRoad <- merge(countiesRoad, classification, by="SCC")
        total <- ddply(mergedRoad, c("year", "type", "fips"), summarise, 
                       Emissions = sum(Emissions))

## Plot graphics from data
        # First graph will be the emissions by type and County per year
        png("plot6.png")
        g <- ggplot(mergedRoad, aes(year, Emissions))
                g + geom_jitter(aes(color=year), size=2, alpha=0.8) + facet_wrap(type ~ fips) + geom_smooth(method = "lm", colour = "orange", size = 1.1) + 
                coord_cartesian(ylim = c(0, 75)) +
                labs(x="Year") +
                labs(y = expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) +
                labs(title = expression("Baltimore & Los Angeles" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year"))  + theme_bw() 
        dev.off()
                
        #Let's see how it goes when we add up all the emissions per year
        png("plot6total.png")
        g <- ggplot(total, aes(year, Emissions))
                g + geom_line() + facet_grid(. ~ fips) +
                labs(x="Year") +
                labs(y = expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) +
                labs(title = expression("Baltimore & Los Angeles" ~ PM[2.5] ~ "TOTAL Motor Vehicle Emissions by Year")) 
        dev.off()