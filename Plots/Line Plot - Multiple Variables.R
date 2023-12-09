library(tidyverse)
library(readxl)

# Read data from Excel
data <- read_excel("scan_times_unique - Nov 5.xlsx")

# Clean and transform the data
data <- data %>%
  select(scan_type, badge_type, time) %>%
  filter(scan_type == "entry") # %>%
  # mutate(time = as.POSIXct(strptime(time, "%I:%M:%S%p"), tz = "UTC"))

# Calculate the total number of scanned badges
total_badges <- nrow(data)

# Create the grouped line chart using ggplot2
p <- ggplot(data, aes(x = time, color = badge_type)) +
  geom_freqpoly(binwidth = 400, show.legend = TRUE, size = 1) +
  scale_x_datetime(labels = scales::time_format("%I:%M %p"), breaks = seq(min(data$time), max(data$time), by = "60 min")) +
  scale_y_continuous(breaks = seq(0, 1000, by = 10)) +  # Adjust the breaks for y-axis
  labs(title = paste("Scanned Badges - November 5"),
       x = "Time of Scan",
       y = "Number of Scanned Badges",
       color = "Badge Type") +
  guides(color = guide_legend(override.aes = list(size = 1.5))) +  # Increase legend line width
  theme_minimal() +
  theme(panel.grid.major.x = element_line(color = NA),
        panel.grid.minor.x = element_line(color = NA),
        panel.grid.major.y = element_line(color = "#f0f0f0"),  # Set color to black for major grid lines
        panel.grid.minor.y = element_blank(),
        axis.text.x = element_text(size = 8, vjust = 12),  # Adjust vjust to displace tick labels up
        plot.title = element_text(size = 20))  # Adjust title size
p
