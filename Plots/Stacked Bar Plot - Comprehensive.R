library(readxl)
library(tidyverse)

# Read the data from the Excel file
tickets <- read_excel("C:/Users/lucas/Desktop/Team Experience Manager/Scripts/2023 Tickets by Type and Status.xlsx")

# Filter columns and convert the data to a long format
tickets_long <- tickets %>%
  select(Type, `Checked In`, Pending, Canceled) %>%
  pivot_longer(cols = c(`Checked In`, Pending, Canceled), names_to = "Status", values_to = "Count") %>%
  mutate(Percent = Count / sum(Count) * 100)

# Define hjust values for specific types
hjust_values <- tribble(
  ~Type,         ~Status,         ~Hjust,
  "Exhibitor",   "Canceled",        -1.5,
  "Exhibitor",   "Checked In",    -0.7,
  "Exhibitor",   "Pending",         0,
  
  "General",     "Canceled",        -0.5,
  "General",     "Checked In",    0,
  "General",     "Pending",         0.2,
  
  "Guest",       "Canceled",        -1.5,
  "Guest",       "Checked In",    -0.7,
  "Guest",       "Pending",         0,
  
  "Judge",       "Canceled",        0.5,
  "Judge",       "Checked In",    0,
  "Judge",       "Pending",         0,
  
  "Sponsor",     "Canceled",        -1.5,
  "Sponsor",     "Checked In",    -0.7,
  "Sponsor",     "Pending",         0,
  
  "Staff",       "Canceled",        -1.5,
  "Staff",       "Checked In",    -0.7,
  "Staff",       "Pending",         0,
  
  "Team Member", "Canceled",       0.5,
  "Team Member", "Checked In",     1.5,
  "Team Member", "Pending",         0.4,
  
  "Volunteer",   "Canceled",        -0.5,
  "Volunteer",   "Checked In",    0.4,
  "Volunteer",   "Pending",         5
)

# Merge the hjust values with the main data
tickets_long <- tickets_long %>%
  left_join(hjust_values, by = c("Type", "Status"))

# Create the horizontal stacked bar plot
space_tickets_stacked_horizontal <- ggplot(tickets_long, aes(y = reorder(Type, Count), x = Count, fill = Status)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7) + 
  geom_text(aes(label = sprintf("%.1f%%", Percent)),
            position = position_stack(vjust = 0.5), size = 2,
            hjust = ifelse(!is.na(tickets_long$Hjust), tickets_long$Hjust, 0)) +
  labs(title = "Number of 2023 Tickets by Type and Status - Attendance",
       x = "Count",
       y = "") +
  theme_bw() +
  theme(axis.text.x = element_text(size = 10, angle = 45, hjust = 1),  
        axis.text.y = element_text(size = 14),
        panel.grid.major.y = element_blank(),  
        panel.grid.minor = element_blank(),    
        plot.title = element_text(size = 25),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 20),
        axis.ticks.x = element_blank(),  
        axis.line.x = element_line(color = "black"),  
        axis.line.y = element_line(color = "black"),  
        panel.border = element_rect(color = "black", fill = NA),  
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 14)) +
  scale_fill_manual(values = c(`Checked In` = "#25ad5f", Pending = "#e58213", Canceled = "#ce1d40")) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, max(3100), by = 100)) 

space_tickets_stacked_horizontal
