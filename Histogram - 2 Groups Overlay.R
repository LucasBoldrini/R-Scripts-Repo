library(tidyverse)
library(hrbrthemes)
library(gridExtra)
library(readxl)

data_excel <- read_excel("roster members.xlsx")

# Create the plot
plot <- data_excel %>%
  ggplot() +
  ggtitle("Bought Tickets vs. Roster Members") +
  xlab("Individual Count") +
  ylab('Team Count') +
  theme_bw() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  ) +
  geom_histogram(aes(x = roster_members, fill = "Roster Members"), binwidth = 1, alpha = 1, position = "identity") +
  geom_histogram(aes(x = bought_tickets, fill = "Bought Tickets"), binwidth = 1, alpha = 0.9, position = "identity") +
  scale_fill_manual(values = c("Roster Members" = "#08a488", "Bought Tickets" = "#ce3f3d")) +
  guides(fill = guide_legend(title = "Category")) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 100, by = 2)) +
  scale_x_continuous(expand = c(0,0), breaks = seq(0, 100, by = 5))

plot
