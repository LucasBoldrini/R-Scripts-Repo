library(readxl)
library(ggplot2)
library(viridis)

# Load the data from the xlsx file
avg_roster_data <- read_excel("C:/Users/lucas/Desktop/Team Experience Manager/Scripts/Average Bought Tickets by Country.xlsx")

# Reorder the levels of the country variable in reverse alphabetical order
avg_roster_data$country <- reorder(avg_roster_data$country, rev(order(avg_roster_data$country)))

# Create the horizontal bar plot of average roster members by country in reverse alphabetical order
avg_roster_plot <- ggplot(avg_roster_data, aes(x = Avg, y = country)) +
  geom_bar(stat = "identity", aes(fill = country), color = "black", size = 0) +
  geom_errorbarh(aes(xmax = Avg + Std, xmin = Avg - Std), height = 0.2, size = 0.3) +
  labs(title = "Average Number of Bought Tickets by Country",
       x = "Average Bought Tickets (In-Person Teams)",
       y = "") +
  theme_bw() +
  theme(axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        panel.grid.major.y = element_blank(),
        plot.title = element_text(size = 25),
        axis.title.x = element_text(size = 20)) +
  scale_x_continuous(breaks = seq(0, max(50), by = 5), expand = expansion(mult = c(0, .1))) +
  scale_fill_viridis_d() +
  guides(fill = FALSE)

avg_roster_plot
