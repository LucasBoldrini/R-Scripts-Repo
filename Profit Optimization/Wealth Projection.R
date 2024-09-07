library(ggplot2)
library(scales)
library(RColorBrewer)

# Function to project cumulative wealth over time
project_wealth <- function(starting_salary, annual_salary_growth, savings_rate, investment_return_rate, years, initial_savings = 0) {
  
  # Initialize variables
  salary <- starting_salary
  total_savings <- initial_savings
  cumulative_wealth <- numeric(years)  # Vector to store wealth for each year
  
  for (year in 1:years) {
    # Record cumulative wealth before savings and returns for the current year
    cumulative_wealth[year] <- total_savings
    
    # Calculate annual savings
    annual_savings <- salary * savings_rate
    
    # Add investment returns on previous savings
    total_savings <- total_savings * (1 + investment_return_rate)
    
    # Add new savings to total
    total_savings <- total_savings + annual_savings
    
    # Increase salary based on annual salary growth
    salary <- salary * (1 + annual_salary_growth)
  }
  
  # Return the wealth projection over the years
  return(cumulative_wealth)
}

# Example usage for projected curve
starting_salary <- 100000            # Starting net salary in euros
annual_salary_growth <- 0.05         # X% annual salary increase
savings_rate <- 0.20                 # Save X% of salary each year
investment_return_rate <- 0.05       # X% return on investments
years <- 10                          # Number of years to project
initial_savings <- 20000             # Initial savings at the start in euros

# Project cumulative wealth over 10 years
wealth_projection <- project_wealth(starting_salary, annual_salary_growth, savings_rate, investment_return_rate, years, initial_savings)

# Create a data frame for projected wealth
years_vector <- 1:years
projected_data <- data.frame(Year = years_vector, Cumulative_Wealth = wealth_projection, Type = "Projected")

# Real-life data
real_life_wealth <- c(20000, 50000, 80000) # In euros
real_life_years <- c(1, 2, 3)  # Real data corresponding years
real_life_data <- data.frame(Year = real_life_years, Cumulative_Wealth = real_life_wealth, Type = "Real")

# Combine the projected and real data into one data frame
combined_data <- rbind(projected_data, real_life_data)

# Custom function for euro formatting
euro_format <- function(x) {
  paste0("\u20AC", format(x, big.mark = ",", scientific = FALSE))
}

# Plot data
ggplot(combined_data, aes(x = Year, y = Cumulative_Wealth, color = Type)) +
  geom_line(size = 1.5, linetype = "solid") +
  geom_point(size = 3, shape = 21, fill = "white") +
  labs(title = "Cumulative Wealth Projection vs Real Life Data",
       subtitle = "Comparing projected and real-life cumulative wealth over time",
       x = "Year",
       y = "Cumulative Wealth") +  # Use euro symbol
  scale_color_brewer(palette = "Dark2") +
  scale_y_continuous(labels = euro_format, 
                     breaks = pretty_breaks(n = 10)) +
  scale_x_continuous(breaks = pretty_breaks(n = 10)) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5, size = 14, face = "italic", color = "grey40"),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(size = 12),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "grey80", linetype = "dotted")
  )
