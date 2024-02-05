library(readxl)
library(tidyverse)

# Read the data from the Excel file
tickets <- read_excel("C:/Users/lucas/Desktop/Team Experience Manager/Scripts/Roster Attendance by Region.xlsx")

# Filter columns and convert the data to a long format
tickets_long <- tickets %>%
  select(Region, `In Person`, Remote) %>%
  pivot_longer(cols = c(`In Person`, Remote), names_to = "Status", values_to = "Count") %>%
  mutate(Percent = Count / sum(Count) * 100)

# Define hjust values for specific regions
hjust_values <- tribble(
  ~Region,        ~Status,         ~Hjust,     ~Hjust_Total, ~Vjust_Total,
  "Africa",       "Remote",        0,         0.5,          0.5,
  "Africa",       "In Person",      -1,      0.5,          0.5,
  
  "Asia",         "Remote",        0.5,        0.5,          0.5,
  "Asia",         "In Person",      0,         0.5,          0.5,
  
  "Europe",       "Remote",        0.5,       0.5,          0.5,
  "Europe",       "In Person",      0.5,       0.5,          0.5,
  
  "Latin America", "Remote",        0.15,        0.5,          0.5,
  "Latin America", "In Person",     -0.6,      0.5,          0.5,
  
  "North America", "Remote",        0.5,       0.5,          0.5,
  "North America", "In Person",     0.4,       0.5,          0.5
)

# Add a new column for the hjust values of the total percentages
hjust_values <- hjust_values %>%
  mutate(Hjust_Total = c(-2.2, -2.2, -6.75, -6.75, -1.7, -1.7, -1.8, -1.8, -1.7, -1.7)) # Order: Africa, Asia, Europe, Latin America, North America

# Merge the hjust and vjust values with the main data
tickets_long <- tickets_long %>%
  left_join(hjust_values, by = c("Region", "Status"))

# Add two more columns for the percentages
tickets_long <- tickets_long %>%
  group_by(Region) %>%
  mutate(Percent_Status = Count / sum(Count) * 100,  # Percentage of each status in each region
         Percent_Total = sum(Count) / sum(tickets_long$Count) * 100)  # Percentage of each region in total

# Add a column for the midpoint of the total count for each region
tickets_long <- tickets_long %>%
  group_by(Region) %>%
  mutate(Midpoint = sum(Count) / 2)

# Create the horizontal stacked bar plot
space_tickets_stacked_horizontal <- ggplot(tickets_long, aes(y = reorder(Region, Count), x = Count, fill = Status)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7) + 
  geom_text(aes(label = sprintf("%.1f%%", Percent_Status),
                hjust = ifelse(!is.na(Hjust), Hjust, 0)),
            position = position_stack(vjust = 0.5), size = 5, color = "#959595") +
  geom_text(data = subset(tickets_long, Status == "In Person"), 
            aes(label = sprintf("%.1f%%", Percent_Total), x = Midpoint, hjust = Hjust_Total, vjust = Vjust_Total),  # Use the new Vjust_Total for the vjust
            size = 6.5, color = "black") +
  labs(title = "Attendance Type of 2023 Roster Members by Region",
       x = "Count",
       y = "") +
  theme_bw() +
  theme(axis.text.x = element_text(size = 12, angle = 45, hjust = 1, vjust = 1.2),  
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
  scale_fill_manual(values = c(`In Person` = "#00214E", Remote = "#FFE93F")) +
  scale_x_continuous(expand = c(0.0, 0), breaks = seq(0, 6000, by = 200), limits = c(0, 6200))

space_tickets_stacked_horizontal