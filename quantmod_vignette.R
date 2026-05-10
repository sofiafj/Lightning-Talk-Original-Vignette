# Lightning Talk Original Vignette
# Demonstrating basic functionality of the quantmod package

# Install package if needed
# install.packages("quantmod", type = "binary")

library(quantmod)

# ------------------------------------------------------------
# 1. Demonstrates getSymbols() functionality
# ------------------------------------------------------------

# Load QQQ and SPY from Yahoo Finance
getSymbols(c("QQQ", "SPY"), src = "yahoo")

# Load Ford market data from Yahoo Finance
getSymbols("F", src = "yahoo")

# Load Ford as a time series object
ford_ts <- getSymbols("F",
                      src = "yahoo",
                      return.class = "ts",
                      auto.assign = FALSE)

str(ford_ts)

# ------------------------------------------------------------
# 2. Load data into a new environment
# ------------------------------------------------------------

data.env <- new.env()

getSymbols("AAPL", env = data.env, src = "yahoo")

ls.str(data.env)

# ------------------------------------------------------------
# 3. Constrain object to local scope
# ------------------------------------------------------------

try(local({
  getSymbols("AAPL", src = "yahoo")
  str(AAPL)
}))

# AAPL does not exist in the global environment after local()
exists("AAPL")

# ------------------------------------------------------------
# 4. Directly return data to caller
# ------------------------------------------------------------

aapl_direct <- getSymbols("AAPL",
                          src = "yahoo",
                          auto.assign = FALSE)

str(aapl_direct)

# ------------------------------------------------------------
# 5. Draw charts based on symbols
# ------------------------------------------------------------

getSymbols("AAPL", src = "yahoo")

chartSeries(AAPL,
            name = "Apple Stock Price")

chartSeries(AAPL,
            subset = "last 4 months",
            name = "Apple Stock Price: Last 4 Months")

chartSeries(AAPL,
            subset = "2007::2008-01",
            name = "Apple Stock Price: 2007 to January 2008")

chartSeries(AAPL,
            TA = NULL,
            name = "Apple Stock Price Without Volume")

chartSeries(AAPL,
            TA = "addVo(); addBBands()",
            name = "Apple with Volume and Bollinger Bands")

addMACD()

chartSeries(AAPL,
            name = "Apple Stock Price with Indicators")

# ------------------------------------------------------------
# 6. Symbol return functionality
# ------------------------------------------------------------

getSymbols("QQQ", src = "yahoo")

allReturns(QQQ)

periodReturn(QQQ,
             period = "yearly",
             subset = "2003::")

periodReturn(QQQ,
             period = "yearly",
             subset = "2003")

rm(QQQ)

# ------------------------------------------------------------
# 7. Quote return functionality
# ------------------------------------------------------------

getQuote("AAPL")

getQuote("QQQ;SPY;^VXN",
         what = yahooQF(c("Bid", "Ask")))

standardQuote()

# ------------------------------------------------------------
# 8. Stock split functionality
# ------------------------------------------------------------

getSymbols("MSFT", src = "yahoo")

getSplits("MSFT")

getSplits(MSFT)
