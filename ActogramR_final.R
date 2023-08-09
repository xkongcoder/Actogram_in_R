
## loading packages

library(ggplot2)
library(readxl)
library(tidyr)

## loading data

mydt <- read_excel("data/exampleActo.xlsx", 
                   sheet = "shamControl72", na = "", col_names = TRUE)


# data transformation:column to rows, put the different days underneath each other

mydt <- gather(mydt, days, activity, '1':'12') 


# Search for NA's in the dataframe and replace the found NA into a 0

mydt[is.na(mydt)] <- 0

# Change the days from factor to numeric data

mydt$days <- as.numeric(mydt$days)


# Change the dataframe order by first day on top

library(dplyr)

mydt <- arrange(mydt, desc(days))


# Change the days back to a factor

mydt$days <-as.factor(mydt$days)


## actogram plot,size 1000:500

ggplot(mydt, aes(x = ZT_h, y = activity)) +
  # Y-AXIS: Explicit show the breaks (ticks on the axis) and limit of the graph
  scale_y_continuous(breaks = seq(from = 0, to = 300, by = 50),
                     limits = c(0,300)) +
  
  # X-AXIS: Explicit show the breaks (ticks on the axis) and limit of the graph
  scale_x_continuous(breaks = seq(from = 0, to = 48, by = 12)) + 
  
  # Change title and axis titles
  labs(title = "\t       Double Plot Actogram_shamControl_ch72", 
       x = "ZT",
       y = "Day") + 
  
  # Background shadows light on/light off - double plot LEFT side
  geom_rect(aes(xmin =  0, xmax =  12, ymin = 0, ymax = Inf), fill = "khaki1", alpha = 0.10) +
  geom_rect(aes(xmin =  12, xmax = 24, ymin = 0, ymax = Inf), fill = "grey", alpha = 0.10) +
  
  
  # Background shadows light on/light off - double plot RIGHT side
  geom_rect(aes(xmin = 24, xmax = 36, ymin = 0, ymax = Inf), fill = "khaki1", alpha = 0.10) +
  geom_rect(aes(xmin = 36, xmax = 48, ymin = 0, ymax = Inf), fill = "grey", alpha = 0.10) +

  
  # Draw the individual bars of activity + colour
  geom_bar(stat = 'identity', fill = "black") + 
  
  # Using facet_wrap to put multiple day underneath each other
  facet_wrap(~days,  ncol = 1, strip.position = "left", scales = "free_y") + 
  
  # Change the theme of the graph to remove lots of extra aesthetics
  theme(#axis.text.x = element_blank(),          # Removes x-axis labels
    #axis.ticks.x = element_blank(),         # Removes ticks from x-axis
    axis.text.y = element_blank(),          # Removes y-axis labels
    axis.ticks.y = element_blank(),         # Removes ticks from y-axis
    #axis.title.x = element_blank(),         # Removes x-axis title
    #axis.title.y = element_blank(),         # Removes y-axis title
    panel.background = element_blank(),     # Removes background from plotting area
    strip.background = element_blank(), # Deletes border around 'days'
    panel.spacing = unit(-0.15, "lines"))   # Removes the spacing between the different graphs
