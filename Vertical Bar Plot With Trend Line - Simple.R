library(readxl)
library(ggplot2)

# Load the data from the xlsx file
teams <- read_excel("C:/Users/lucas/Desktop/Team Experience Manager/Space Projects/iGEM Space Teams Database/Plots/European Teams Analysis/ESA Members Teams by Year.xlsx")

# Create the histogram of space teams
space_teams_hist <- ggplot(teams, aes(x = Year, y = Count)) +
  geom_histogram(stat = "identity", binwidth = 1, fill = "#cc0000", color = "black", size = 0.0, width = 1) +
  geom_smooth(method = "loess", color = "blue", size = 0.8, se = FALSE, aes(y = Count)) +  # Add a small constant to y aesthetic
  labs(title = "Number of iGEM Space Teams - ESA Member States",
       x = "Year",
       y = "Team Count") +
  scale_x_continuous(breaks = seq(min(teams$Year), max(teams$Year), by = 1)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        axis.text.y = element_text(size = 9)) +
  scale_y_continuous(breaks = seq(0, max(teams$Count), by = 1)) # Set y-axis tick frequency

space_teams_hist
