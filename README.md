# Efficient Portfolio Optimization using Modern Portfolio Theory (MPT)

This repository contains an R script that demonstrates how to construct an efficient portfolio using Modern Portfolio Theory (MPT). The script retrieves historical stock data, calculates mean returns and covariance matrix, generates random portfolios, and optimizes the portfolio allocation to maximize the Sharpe ratio. The efficient frontier, representing the set of optimal portfolios, is visualized to help investors make informed decisions.

## Table of Contents

- [Dependencies](#dependencies)
- [Usage](#usage)
- [Results](#results)
- [License](#license)

## Dependencies

To run the script, you need to have the following R packages installed:

- quantmod
- quadprog

You can install these packages using the `install.packages()` function in R.

## Usage

  1 Clone the repository or download the script file.

  2 Open the R environment or an R script editor.

  3 Install the required packages if they are not already installed:

  install.packages(c("quantmod", "quadprog"))

## Results

The script performs the following steps to construct an efficient portfolio:

    Retrieving historical stock data for the specified symbols from Yahoo Finance using the quantmod package.

    Calculating daily returns from the historical data and computing mean returns and the covariance matrix.

    Generating random portfolios with random weights for each asset and calculating their returns and volatilities.

    Solving a quadratic programming problem to find the optimal portfolio weights that maximize the Sharpe ratio.

    Displaying the optimized portfolio weights, return, and volatility.

    Plotting the efficient frontier, representing the set of optimal portfolios for different levels of risk and return.

Execute the code step by step or run the entire script:

    The script fetches historical stock data for the specified symbols from Yahoo Finance using quantmod.

    It calculates daily returns from the historical data and computes mean returns and the covariance matrix.

    Random portfolios are generated with random weights for each asset.

    The script then solves a quadratic programming problem to find the optimal portfolio weights that maximize the Sharpe ratio.

    Finally, it displays the optimized portfolio weights, return, and volatility. The efficient frontier is visualized using a plot to aid in portfolio decision-making.

The script provides insights into constructing efficient portfolios based on historical stock data. However, it's essential to keep in mind that financial markets are subject to fluctuations, and past performance does not guarantee future results.

## License

This script is released under the MIT License.

Feel free to copy the entire content and use it as a README file in your GitHub repository.
