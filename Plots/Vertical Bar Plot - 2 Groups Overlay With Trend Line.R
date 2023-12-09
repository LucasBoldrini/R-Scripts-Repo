library(readxl)
library(ggplot2)

# Load the data from the xlsx file
teams <- read_excel("C:/Users/lucas/Desktop/Team Experience Manager/Space Projects/iGEM Space Teams Database/Plots/Space Teams - Year.xlsx")

# Create the histogram of all teams
all_teams_hist <- ggplot(teams, aes(x = Year, y = Total_Teams)) +
  geom_histogram(stat = "identity", binwidth = 1, fill = "#248f8f", color = "black", size = 0.0, width = 1) +
  geom_smooth(method = "loess", color = "grey", size = 0.8, se = FALSE, aes(y = Total_Teams)) +  # Add a small constant to y aesthetic
  labs(title = "Number of iGEM Teams",
       x = "Year",
       y = "Team Count") +
  scale_x_continuous(breaks = seq(min(teams$Year), max(teams$Year), by = 1)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        axis.text.y = element_text(size = 9)) +
  scale_y_continuous(breaks = seq(0, 360, by = 20)) # Set y-axis tick frequency

# Create the histogram of space teams
space_teams_hist <- ggplot(teams, aes(x = Year, y = Space_Teams)) +
  geom_histogram(stat = "identity", binwidth = 1, fill = "#cc0000", color = "black", size = 0.0, width = 1) +
  geom_smooth(method = "loess", color = "blue", size = 0.8, se = FALSE, aes(y = Space_Teams)) +  # Add a small constant to y aesthetic
  labs(title = "Number of iGEM Space Teams",
       x = "Year",
       y = "Team Count") +
  scale_x_continuous(breaks = seq(min(teams$Year), max(teams$Year), by = 1)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        axis.text.y = element_text(size = 9)) +
  scale_y_continuous(breaks = seq(0, max(teams$Space_Teams), by = 1)) # Set y-axis tick frequency

space_teams_hist

# Overlay the histograms
overlay_hist <- all_teams_hist + 
  geom_histogram(data = teams, aes(y = Space_Teams), stat = "identity", binwidth = 1, fill = "#cc0000", color = "black", alpha = 0.6, size = 0.0, width = 1) +
  geom_text(data = subset(teams, Space_Teams > 0), aes(x = Year, y = Space_Teams, label = paste0(round(Space_Teams/Total_Teams*100, 1),"%")), hjust = 0.02, vjust = -1, size = 3.0, angle = 45)

# Display the plot
overlay_hist
