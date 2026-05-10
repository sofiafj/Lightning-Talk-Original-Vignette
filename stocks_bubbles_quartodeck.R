# Load quantmod package
library(quantmod)

# Creates a white chart theme 
my_theme <- chartTheme("white")


# Custom Quarterly Return Plot Function:
  # Creates a barplot of quarterly returns
  # Highlights either the lowest or highest return quarter
plot_quarterly_returns <- function(stock_data, title, subset_range, highlight = "low") {
  
  # Calculates quarterly returns
  returns <- periodReturn(stock_data,
                          period = "quarterly",
                          subset = subset_range)
  
  # Converts returns into numeric values for plotting
  barplot_heights <- as.numeric(returns)
  
  # Default bar colors
  bar_colors <- rep("gray70", length(barplot_heights))
  
  # Highlights lowest or highest quarter
  if (highlight == "low") {
    bar_colors[which.min(barplot_heights)] <- "red"
  } else if (highlight == "high") {
    bar_colors[which.max(barplot_heights)] <- "darkgreen"
  }
  
  # Creates barplot
  barplot(barplot_heights,
          names.arg = format(index(returns), "%Y-Q%q"),
          las = 2,
          col = bar_colors,
          main = title,
          ylab = "Quarterly Return",
          cex.names = 0.7)
  
  # Adds horizontal reference line at zero return
  abline(h = 0, lty = 2)
}

# Download Historical Market Data

  # 2008 Housing Crisis Data
xlf_08 <- getSymbols("XLF",
                     from = "2006-01-01",
                     to = "2010-01-01",
                     auto.assign = FALSE)

sp500_08 <- getSymbols("^GSPC",
                       from = "2006-01-01",
                       to = "2010-01-01",
                       auto.assign = FALSE)

vix_08 <- getSymbols("^VIX",
                     from = "2006-01-01",
                     to = "2010-01-01",
                     auto.assign = FALSE)

fnma_08 <- getSymbols("FNMA",
                      from = "2006-01-01",
                      to = "2010-01-01",
                      auto.assign = FALSE)

  # AI Boom / Modern Market Data
sp500_now <- getSymbols("^GSPC",
                        from = "2020-01-01",
                        to = "2024-01-01",
                        auto.assign = FALSE)

xlf_now <- getSymbols("XLF",
                      from = "2020-01-01",
                      to = "2024-01-01",
                      auto.assign = FALSE)

nvda_now <- getSymbols("NVDA",
                       from = "2020-01-01",
                       to = "2024-01-01",
                       auto.assign = FALSE)

vix_now <- getSymbols("^VIX",
                      from = "2020-01-01",
                      to = "2024-01-01",
                      auto.assign = FALSE)

# FNMA Stock Performance During Housing Crisis
  # Displays FNMA chart during the 2008 housing crisis
  # Adds 50-day and 200-day moving averages
chartSeries(fnma_08,
            subset = "2007::2009",
            name = "FNMA During the Housing Crisis",
            theme = my_theme,
            TA = "addSMA(n = 50, col = 'blue');
                  addSMA(n = 200, col = 'red')")

# NVIDIA Stock Performance During AI Boom
  # Displays NVIDIA stock performance during AI expansion
  # Adds moving average trendlines
chartSeries(nvda_now,
            subset = "2020::2023",
            name = "NVIDIA During the AI Boom",
            theme = my_theme,
            TA = "addSMA(n = 50, col = 'blue');
                  addSMA(n = 200, col = 'red')")

# Financial Sector Performance During 2008 Crisis
  # XLF tracks the financial sector within the S&P 500
chartSeries(xlf_08,
            subset = "2007::2009",
            name = "XLF: Financial Sector During 2008",
            theme = my_theme,
            TA = "addSMA(n = 50, col = 'blue');
                  addSMA(n = 200, col = 'red')")

# Financial Sector Performance During AI Period
chartSeries(xlf_now,
            subset = "2020::2023",
            name = "XLF: Financial Sector Today",
            theme = my_theme,
            TA = "addSMA(n = 50, col = 'blue');
                  addSMA(n = 200, col = 'red')")

# S&P 500 Performance During 2008 Crisis
  # GSPC tracks the S&P 500 index
chartSeries(sp500_08,
            subset = "2007::2009",
            name = "S&P 500 During the 2008 Crisis",
            theme = my_theme,
            TA = "addSMA(n = 50, col = 'blue');
                  addSMA(n = 200, col = 'red')")

# S&P 500 Performance During AI Period
chartSeries(sp500_now,
            subset = "2020::2023",
            name = "S&P 500 During the AI Boom",
            theme = my_theme,
            TA = "addSMA(n = 50, col = 'blue');
                  addSMA(n = 200, col = 'red')")

# VIX During 2008 Crisis
  # VIX measures expected market volatility ("fear index")
  # Highlights periods where VIX exceeds 40
chartSeries(vix_08,
            subset = "2007::2009",
            name = "VIX During the 2008 Crisis",
            theme = my_theme,
            TA = "addTA(ifelse(Cl(vix_08) > 40,
                               Cl(vix_08),
                               NA),
                        col = 'red',
                        type = 'p')")

  # VIX During Recent Market Volatility
chartSeries(vix_now,
            subset = "2020::2023",
            name = "VIX During Recent Market Volatility",
            theme = my_theme,
            TA = "addTA(ifelse(Cl(vix_now) > 40,
                               Cl(vix_now),
                               NA),
                        col = 'red',
                        type = 'p')")

# Quarterly Return Analysis
  # FNMA quarterly returns during housing crisis
  # Highlights worst quarter
plot_quarterly_returns(fnma_08,
                       title = "FNMA Quarterly Returns, 2007–2009",
                       subset_range = "2007::2009",
                       highlight = "low")

  # NVIDIA quarterly returns during AI boom
  # Highlights strongest quarter
plot_quarterly_returns(nvda_now,
                       title = "NVIDIA Quarterly Returns, 2020–2023",
                       subset_range = "2020::2023",
                       highlight = "high")

  # S&P 500 quarterly returns during 2008 crisis
plot_quarterly_returns(sp500_08,
                       title = "S&P 500 Quarterly Returns, 2007–2009",
                       subset_range = "2007::2009",
                       highlight = "low")

  # S&P 500 quarterly returns during AI boom
plot_quarterly_returns(sp500_now,
                       title = "S&P 500 Quarterly Returns, 2020–2023",
                       subset_range = "2020::2023",
                       highlight = "high")
