# Lightning Talk Original Vignette

This repository contains an original worked vignette demonstrating basic functionality from the `quantmod` package in R. It also contains  reworked vignette used to compare the 2008 housing bubble with the current AI market.

The examples show how to:

- Install and load `quantmod`
- Retrieve stock data with `getSymbols()`
- Store stock data in different environments
- Create stock charts with `chartSeries()`
- Add technical indicators
- Calculate returns with `allReturns()` and `periodReturn()`
- Retrieve quotes and stock split data

## Installation

```r
install.packages("quantmod", type = "binary")
library(quantmod)
```

## Running the Vignette

Open `quantmod_vignette.R` in RStudio and run the code section by section.

Some functions retrieve live data from Yahoo Finance, so an internet connection is required.

## Files

- `quantmod_vignette.R`: Main worked example using the `quantmod` package.
- `README.md`: Overview of the project.
- `.gitignore`: Prevents unnecessary R files from being uploaded.

## Notes

Some examples from the original package documentation use external databases, such as MySQL. Those examples were removed or commented out because they require additional setup.
