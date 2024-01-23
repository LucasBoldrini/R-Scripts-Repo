library(tidyverse)
library(readxl)
library(RColorBrewer)

# Read data from Excel
data <- read_excel("scan_times_unique - Nov 5 - Sum_Badge.xlsx")

# Check the structure of the time column
str(data$time)

# Convert time to Paris time (CET)
data$time <- as.POSIXct(data$time, format = "%I:%M:%S%p", tz = "Europe/Paris")

# Filter out rows with missing or invalid time values
data <- data[complete.cases(data$time), ]

# Create the grouped line chart using ggplot2
p <- ggplot(data, aes(x = time)) +
  geom_line(aes(y = exhibitor, color = "Exhibitor"), size = 1) +
  geom_line(aes(y = general, color = "General"), size = 1) +
  geom_line(aes(y = guest, color = "Guest"), size = 1) +
  geom_line(aes(y = judge, color = "Judge"), size = 1) +
  geom_line(aes(y = sponsor, color = "Sponsor"), size = 1) +
  geom_line(aes(y = team_member, color = "Team Member"), size = 1) +
  geom_line(aes(y = volunteer, color = "Volunteer"), size = 1) +
  geom_line(aes(y = staff, color = "Staff"), size = 1) +  # Add staff line
  scale_x_datetime(labels = scales::time_format("%I:%M %p", tz = "Europe/Paris"), 
                   breaks = seq(min(data$time, na.rm = TRUE), max(data$time, na.rm = TRUE), by = "30 min"),
                   timezone = "Europe/Paris") +
  scale_y_continuous(breaks = seq(0, max(3500, na.rm = TRUE), by = 50)) +
  labs(title = paste("Cumulative Scanned Badges - November 5"),
       x = "Time of Scan",
       y = "Cumulative Count",
       color = "Expo Group") +
  guides(color = guide_legend(override.aes = list(size = 1.5))) +
  theme_minimal() +
  theme(panel.grid.major.x = element_line(color = NA),
        panel.grid.minor.x = element_line(color = NA),
        panel.grid.major.y = element_line(color = "#f0f0f0"),
        panel.grid.minor.y = element_blank(),
        axis.text.x = element_text(size = 10, vjust = 1, angle = 30),
        plot.title = element_text(size = 20)) +
  geom_vline(xintercept = as.numeric(seq(min(data$time), max(data$time), by = "30 min")),
             linetype = "dashed", color = "gray", alpha = 0.5) # +
  # Define a color palette for all variables
  # scale_color_manual(breaks = c(
  #   "Exhibitor", "General", "Guest", "Judge", "Sponsor", "Team Member", "Volunteer", "Staff"
  # ),
  # values = c(
  #   Exhibitor = "red",
  #   General = "blue",
  #   Guest = "green",
  #   Judge = "purple",
  #   Sponsor = "orange",
  #   `Team Member` = "yellow",
  #   Volunteer = "brown",
  #   Staff = "cyan"
  # ))

p
