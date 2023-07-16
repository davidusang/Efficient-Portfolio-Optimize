# Load required libraries
library(quantmod)  # For retrieving historical stock data
library(quadprog)  # For solving quadratic programming problems

# Step 1: Define the symbols and retrieve historical data
symbols <- c("AAPL", "GOOGL", "MSFT", "AMZN")  # Replace with your desired symbols
getSymbols(symbols, src = "yahoo")  # Retrieve historical stock data
data <- do.call(merge, lapply(symbols, function(sym) Ad(get(sym))))  # Merge the data

# Step 2: Calculate returns from the historical data
returns <- na.omit(ROC(data))  # Calculate the rate of change (returns)
mean_returns <- colMeans(returns)  # Calculate mean returns
cov_matrix <- cov(returns)  # Calculate covariance matrix

# Step 3: Define the objective function
objective <- function(weights, mean_returns, cov_matrix) {
  # Calculate portfolio return and volatility
  portfolio_return <- sum(mean_returns * weights) * 252  # Assuming 252 trading days in a year
  portfolio_volatility <- sqrt(t(weights) %*% cov_matrix %*% weights) * sqrt(252)
  return(portfolio_volatility)
}

# Step 4: Set optimization parameters
num_assets <- ncol(data)  # Number of assets
num_portfolios <- 10000  # Number of portfolios to generate
risk_free_rate <- 0.02  # Risk-free rate

# Step 5: Generate random portfolios
set.seed(123)  # Set random seed for reproducibility
portfolios <- matrix(nrow = num_portfolios, ncol = num_assets)  # Matrix to store portfolios
portfolio_returns <- numeric(num_portfolios)  # Vector to store portfolio returns
portfolio_volatilities <- numeric(num_portfolios)  # Vector to store portfolio volatilities

for (i in 1:num_portfolios) {
  # Generate random weights and normalize them
  weights <- runif(num_assets)
  weights <- weights / sum(weights)
  
  # Store the weights, return, and volatility for each portfolio
  portfolios[i, ] <- weights
  portfolio_returns[i] <- sum(mean_returns * weights) * 252
  portfolio_volatilities[i] <- sqrt(t(weights) %*% cov_matrix %*% weights) * sqrt(252)
}

# Step 6: Calculate the optimal portfolio
dvec <- rep(0, num_assets)  # Coefficients for the linear term in the objective function
Amat <- t(rbind(rep(1, num_assets), diag(num_assets)))  # Coefficients for the linear inequality constraints
bvec <- c(1, rep(0, num_assets))  # Right-hand side of the linear inequality constraints
result <- solve.QP(cov_matrix * 252, dvec, Amat, bvec, meq = 1, factorized = FALSE)  # Solve quadratic programming problem
optimized_weights <- result$solution  # Optimal portfolio weights
optimized_return <- sum(mean_returns * optimized_weights) * 252  # Optimal portfolio return
optimized_volatility <- sqrt(t(optimized_weights) %*% cov_matrix %*% optimized_weights) * sqrt(252)  # Optimal portfolio volatility

# Step 7: Print the results
cat("Optimized Portfolio Weights:\n")
for (i in 1:num_assets) {
  cat(symbols[i], ": ", optimized_weights[i], "\n")
}
cat("\nOptimized Portfolio Return: ", optimized_return, "\n")
cat("Optimized Portfolio Volatility: ", optimized_volatility, "\n")

# Step 8: Plot the efficient frontier
plot(portfolio_volatilities, portfolio_returns, pch = 20, col = "gray",
     xlab = "Volatility", ylab = "Return", main = "Efficient Frontier")
points(optimized_volatility, optimized_return, pch = 19, col = "red")
