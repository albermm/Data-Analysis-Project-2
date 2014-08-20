
## Read data from files        
        emissions <- readRDS("./summarySCC_PM25.rds")
        classification <- readRDS("./Source_Classification_Code.rds")

## Search for coal combustion processes
        coal <- classification[grep("coal", classification$Short.Name, ignore.case=TRUE),] 
        coalComb <- coal[grep("combustion", coal$SCC.Level.One, ignore.case=TRUE), ]

##Add emissions and add them up by year
        library(plyr)
        data <- merge(coalComb, emissions, by="SCC")
        plotData <- ddply(data, c("year", "type"), summarise, 
                          total = sum(Emissions))
        colnames(plotData)[3] <- "Emissions"

##Plot the emissions from coal combustion related sources
        library(ggplot2)
        png("plot4.png")
        g <- ggplot(plotData, aes(year,Emissions))
                g + geom_line(aes(color=type)) +
               # facet_wrap(~type) +
                stat_summary(aes(shape="Total", colour="Total"), fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum",
                             geom="line", size = 1) +
                labs(x="Year") +
                labs(y = expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) +
                labs(title = expression("Coal Combustion" ~ PM[2.5] ~ 
                                                "Emissions by Source Type and Year"))     
        dev.off()
