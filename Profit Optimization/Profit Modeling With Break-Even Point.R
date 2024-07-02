library(ggplot2)

# Set the fixed and variable costs
fixed_costs <- 100e6 # All Real Number Here

# Set the range of possible registration prices
registration_prices <- seq(0, 25000, length.out = 1000)

# Define the demand function
demand <- function(price) {
  # Set the parameters of the demand curve
  intercept <- 1865 # Maximum number of teams that would participate if the competition were free (different for full program)
  slope <- -0.10 # How the expected number of teams changes with the registration price
  
  # Calculate the expected number of teams
  expected_teams <- intercept + slope * price
  
  # Return the expected number of teams
  return(expected_teams)
}

# Calculate the expected number of teams for each registration price
expected_teams <- demand(registration_prices)

# Calculate the expected revenues for each registration price
expected_revenues <- registration_prices * expected_teams

# Calculate the total costs for each registration price
total_costs <- fixed_costs

# Calculate the profit for each registration price
profit <- expected_revenues - total_costs

# Find the average program price that maximizes the profit
optimal_price_index <- which.max(profit)
optimal_price <- registration_prices[optimal_price_index]
optimal_profit <- profit[optimal_price_index]

# Find the break-even price where profit < 0
break_even_index_end <- max(which(profit >= 0))
break_even_price_end <- registration_prices[break_even_index_end]

# Create a data frame with the registration prices and profit
data <- data.frame(registration_prices, profit)

# Create a ggplot object with the data frame and specify the x and y variables
p <- ggplot(data, aes(x = registration_prices, y = profit))

# Add a line to show the profit as a function of the registration price
p <- p + geom_line(color = "black", size = 1)

# Calculate the y-value for the point at x = 5500 by interpolating the nearby values
point_x <- 14000
point_y <- approx(registration_prices, profit, xout = point_x)$y

# Add a point to show the current registration price
p <- p + geom_point(aes(x = point_x, y = point_y), color = "red", size = 4)

# Add a point to show the optimal registration price
p <- p + geom_point(aes(x = optimal_price, y = optimal_profit), color = "red", size = 4)

# Add a label for the current average program price
p <- p + annotate("text", x = point_x, y = point_y,
                  label = paste0("Current Price: ", round(14000)), hjust = -0.1, vjust = 0)

# Add a label to show the value of the optimal registration price
p <- p + annotate("text", x = optimal_price, y = optimal_profit,
                  label = paste0("Optimal Price: ", round(optimal_price)), hjust = -0.05, vjust = -0.5)

# Add a line to indicate the break-even price where profit < 0
p <- p + geom_vline(xintercept = break_even_price_end, linetype = "dashed", color = "blue")

# Add a label to show the break-even price where profit < 0
p <- p + annotate("text", x = break_even_price_end, y = max(profit),
                  label = paste0("Break-even Price (Profit < 0): ", round(break_even_price_end)), hjust = -0.02, vjust = -1.5)

# Add axis labels and a title
p <- p + xlab("Registration Price (USD)") + ylab("Profit (USD)") + ggtitle("Profit vs Registration Price")

# Customize plot appearance using theme functions
p <- p + theme_bw() +
  theme(axis.text.x = element_text(size = 15, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 15),
        panel.grid.major.y = element_blank(),
        plot.title = element_text(size = 20),
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15))

# Change y-axis tick notation to display values in millions with 1 decimal place and reduce the number of decimals to 1
p <- p + scale_y_continuous(labels = function(x) paste0(format(round(x / 1e6, 1), nsmall = 1), "M"), breaks = seq(min(profit), max(profit), length.out = 25))

# Change x-axis tick notation to display values in thousands with 1 decimal place and reduce the number of decimals to 1
p <- p + scale_x_continuous(labels = function(x) paste0(format(round(x / 1e3, 1), nsmall = 1), "K"), breaks = seq(min(registration_prices), max(registration_prices), length.out = 10))

# Display the plot
print(p)
