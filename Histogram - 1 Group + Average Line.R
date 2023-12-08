library(tidyverse)
library(hrbrthemes)
library(gridExtra)
library(readxl)

data_excel <- read_excel("jamboree-team-fees - In-Person.xlsx", col_types = c("numeric"))

# Calculate the average of the "roster_presence" column
average_roster_presence <- mean(data_excel$roster_presence)

# Create the plot
plot <- data_excel %>%
  ggplot() +
  ggtitle("Roster Presence") +
  xlab("In-Person Roster Presence") +
  ylab('Team Count') +
  theme_bw() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  ) +
  geom_histogram(aes(x = roster_presence, fill = "Roster Presence"), binwidth = 0.045, alpha = 1, position = "identity") +
  scale_fill_manual(values = c("Roster Presence" = "#08a488")) +
  guides(fill = guide_legend(title = "Category")) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 100, by = 2)) +
  scale_x_continuous(expand = c(0,0), breaks = seq(0, 1, by = 0.1)) +
  geom_vline(xintercept = average_roster_presence, linetype = "dashed", color = "red") +
  annotate("text", x = average_roster_presence + 0.05, y = 30, label = "Average: 0.39", color = "red")

plot
