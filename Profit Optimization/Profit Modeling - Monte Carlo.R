library(ggplot2)
library(dplyr)
library(purrr)
library(patchwork)

# Set the fixed and variable costs
fixed_costs <- 7e6 # Total costs for full program are around 7M USD

# Set the range of possible registration prices
registration_prices <- seq(0, 25000, length.out = 1000)

# Define the demand function
demand <- function(price) {
  # Set the parameters of the demand curve
  intercept <- 1865 # Maximum number of teams that would participate if the competition were free (different for full program) - Realistic number is 1865
  slope <- -0.10 # How the expected number of teams changes with the registration price - Realistic number is -0.10
  
  # Calculate the expected number of teams
  expected_teams <- intercept + slope * price
  
  # Return the expected number of teams
  return(expected_teams)
}

# Define the number of simulations
num_simulations <- 1000000

# Create a function to perform a single simulation
perform_simulation <- function(iteration) {
  # Simulate demand and costs
  simulated_demand <- rnorm(length(registration_prices), mean = demand(registration_prices), sd = 50)
  simulated_costs <- rnorm(length(registration_prices), mean = fixed_costs, sd = 50)
  
  # Calculate the expected revenues for each registration price
  expected_revenues <- registration_prices * simulated_demand
  
  # Calculate the total costs for each registration price
  total_costs <- simulated_costs
  
  # Calculate the profit for each registration price
  profit <- expected_revenues - total_costs
  
  # Find the average program price that maximizes the profit
  optimal_price_index <- which.max(profit)
  optimal_price <- registration_prices[optimal_price_index]
  optimal_profit <- profit[optimal_price_index]
  
  # Print the current iteration
  cat("Simulation iteration:", iteration, "\n")
  
  # Return the optimal price and profit
  return(list(optimal_price = optimal_price, optimal_profit = optimal_profit))
}

# Perform the Monte Carlo simulation
simulation_results <- map(1:num_simulations, ~perform_simulation(.))

# Extract the optimal prices and profits from the simulation results
optimal_prices <- sapply(simulation_results, function(x) x$optimal_price)
optimal_profits <- sapply(simulation_results, function(x) x$optimal_profit)

# Create a data frame with the optimal prices and profits
data <- data.frame(optimal_prices, optimal_profits)

# Create a histogram of the optimal prices
histogram <- ggplot(data, aes(x = optimal_prices)) +
  geom_histogram(binwidth = 100, fill = "blue", color = "white") +
  labs(title = "Distribution of Optimal Prices",
       x = "Optimal Price (USD)",
       y = "Frequency") +
  theme_minimal()

# Create a histogram of the optimal profits
histogram_profit <- ggplot(data, aes(x = optimal_profits)) +
  geom_histogram(binwidth = 50000, fill = "green", color = "white") +
  labs(title = "Distribution of Optimal Profits",
       x = "Optimal Profit (USD)",
       y = "Frequency") +
  theme_minimal()

# Display the histograms side by side
histogram + histogram_profit + plot_layout(ncol = 2)
