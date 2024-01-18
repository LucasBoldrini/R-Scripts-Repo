library(readxl)
library(tidyverse)

# Read the data from the Excel file
tickets <- read_excel("C:/Users/lucas/Desktop/Team Experience Manager/Scripts/2023 Tickets by Type and Status.xlsx")

# Filter columns and convert the data to a long format
tickets_long <- tickets %>%
  select(Type, Free, Bought) %>%
  gather(key = "Status", value = "Count", -Type) %>%
  mutate(Percent = Count / sum(Count) * 100)

# Create the horizontal stacked bar plot
space_tickets_stacked_horizontal <- ggplot(tickets_long, aes(y = reorder(Type, Count), x = Count, fill = Status)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7) + 
  geom_text(aes(label = sprintf("%.1f%%", Percent),
                hjust = ifelse(Status == "Bought", -0.5, ifelse(Status == "Free", 0.3, 0))),
            position = position_stack(vjust = 0.5), size = 3) +  # Adjust the size parameter
  labs(title = "Number of 2023 Tickets by Type and Status",
       x = "Count",
       y = "") +
  theme_bw() +
  theme(axis.text.x = element_text(size = 10, angle = 45, hjust = 1),  # Adjust angle and hjust
        axis.text.y = element_text(size = 14),
        panel.grid.major.y = element_blank(),  # Remove horizontal grid lines
        panel.grid.minor = element_blank(),    # Remove minor grid lines
        plot.title = element_text(size = 25),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 20),
        axis.ticks.x = element_blank(),  # Remove x-axis ticks
        axis.line.x = element_line(color = "black"),  # Add x-axis line
        axis.line.y = element_line(color = "black"),  # Add y-axis line
        panel.border = element_rect(color = "black", fill = NA),  # Add border around the plot
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.text = element_text(size = 12),  # Adjust legend text size
        legend.title = element_text(size = 14)) +  # Adjust legend title size
  
  scale_fill_manual(values = c(Free = "#df1668", Bought = "#16dfc4")) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, max(3100), by = 100))  # Adjust the breaks for x-axis

space_tickets_stacked_horizontal
