library(readxl)
library(ggplot2)

# Load the data from the xlsx file
teams <- read_excel("Space Teams - Year.xlsx")

# Create the histogram of all teams
all_teams_hist <- ggplot(teams, aes(x = Year, y = Total_Teams)) +
  geom_col(fill = "#248f8f", color = "black", size = 0.0, position = "identity", width = 1) +
  geom_smooth(method = "loess", color = "grey", size = 0.8, se = FALSE, aes(y = Total_Teams)) +
  labs(title = "Number of iGEM Teams",
       x = "Year",
       y = "Team Count") +
  scale_x_continuous(breaks = seq(min(teams$Year), max(teams$Year), by = 1), expand = c(0, 0)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        axis.text.y = element_text(size = 9),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  scale_y_continuous(breaks = seq(0, 400, by = 20))

# Create the histogram of all teams
all_teams_hist <- ggplot(teams, aes(x = Year, y = Total_Teams)) +
  geom_col(fill = "#248f8f", color = "black", size = 0.0, position = "identity", width = 1) +
  geom_smooth(method = "loess", color = "grey", size = 0.8, se = FALSE, aes(y = Total_Teams)) +
  labs(title = "Number of iGEM Teams",
       x = "",
       y = "Team Count") +
  scale_x_continuous(breaks = seq(min(teams$Year), max(teams$Year), by = 1), expand = expansion(mult = c(0, 0))) +
  scale_y_continuous(breaks = seq(0, 400, by = 20), expand = expansion(mult = c(0, 0))) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.y = element_text(size = 14),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())

# Create the histogram of space teams
space_teams_hist <- ggplot(teams, aes(x = Year, y = Space_Teams)) +
  geom_col(fill = "#cc0000", color = "black", size = 0.0, position = "identity", width = 1) +
  geom_smooth(method = "loess", color = "blue", size = 0.8, se = FALSE, aes(y = Space_Teams)) +
  labs(title = "Number of iGEM Space Teams",
       x = "",
       y = "Team Count") +
  scale_x_continuous(breaks = seq(min(teams$Year), max(teams$Year), by = 1), expand = expansion(mult = c(0, 0))) +
  scale_y_continuous(breaks = seq(0, 400, by = 2), expand = expansion(mult = c(0, 0))) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        axis.text.y = element_text(size = 9),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())

# Overlay the histograms
overlay_hist <- ggplot(teams, aes(x = Year)) + 
  geom_col(aes(y = Total_Teams, fill = "All Teams"), color = "black", size = 0.0, position = "identity", width = 1) +
  geom_smooth(aes(y = Total_Teams), method = "loess", color = "grey", size = 0.8, se = FALSE) +
  geom_col(aes(y = Space_Teams, fill = "Space Teams"), color = "black", size = 0.0, position = "identity", width = 1) +
  # geom_smooth(aes(y = Space_Teams), method = "loess", color = "blue", size = 0.8, se = FALSE) +
  geom_text(data = subset(teams, Space_Teams > 0), aes(x = Year, y = Space_Teams, label = paste0(round(Space_Teams/Total_Teams*100, 1),"%")), hjust = 0.02, vjust = -1, size = 3.0, angle = 45) +
  scale_fill_manual(values = c("All Teams" = "#248f8f", "Space Teams" = "#cc0000"), name = "Team Type") +
  labs(title = "Number of iGEM Teams by Year - Overlay",
       x = "",
       y = "Team Count") +
  scale_x_continuous(breaks = seq(min(teams$Year), max(teams$Year), by = 1), expand = expansion(mult = c(0, 0))) +
  scale_y_continuous(breaks = seq(0, 400, by = 20), expand = expansion(mult = c(0, 0.018))) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.y = element_text(size = 14),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())

overlay_hist
