library(tidyverse)
library(viridis)
library(readxl)

roster_data <- read_excel("jamboree-team-fees_in_person.xlsx")

roster_data_filtered <- roster_data %>%
  filter(kind %in% c("collegiate", "commercial", "high_school"))

region_colors <- viridis::viridis(3)

summary_data <- roster_data_filtered %>%
  group_by(kind) %>%
  summarize(mean_bought_tickets = mean(bought_tickets),
            sd_bought_tickets = sd(bought_tickets))

dot_colors <- c("collegiate" = "#55C667FF",
                "commercial" = "#95D840FF",
                "high_school" = "#404788FF")

p <- ggplot(summary_data, aes(x = kind, y = mean_bought_tickets, fill = kind)) +
  
  geom_bar(stat = "identity", width = 0.5, color = "black", size = 1) +
  
  geom_errorbar(aes(ymin = mean_bought_tickets - sd_bought_tickets, 
                    ymax = mean_bought_tickets + sd_bought_tickets),
                width = 0.1, size = 1.5, color = "black", position = position_dodge(0.5)) +
  
  geom_point(data = roster_data_filtered,  
             aes(x = kind, y = bought_tickets, color = kind),
             fill = dot_colors[roster_data_filtered$kind],
             position = position_jitterdodge(jitter.width = 0.4, dodge.width = 0.5),
             size = 1.5, shape = 21) +
  
  scale_color_manual(values = dot_colors) +
  
  scale_fill_manual(values = region_colors) +
  
  labs(title = "Bought Tickets by Kind (In-Person)",  
       x = "",
       y = "Bought Tickets (In-Person)") +
  
  theme_minimal() +
  
  theme(
    axis.text = element_text(size = 15),  # Change to axis.text
    axis.title.y = element_text(size = 18),
    plot.title = element_text(size = 25),
    panel.grid.major.x = element_blank(),
    legend.position = "none",  # Remove the legend
    axis.text.x = element_text(angle = 0, hjust = 0.5)) +
  
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)), breaks = seq(0, 55, by = 5))  # Specify the desired y-axis tick positions

p
