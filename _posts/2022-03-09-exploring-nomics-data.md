---
#layout: post
title: Centralized vs. Decentralized Exchanges
subtitle: Exploring the Nomics API
excerpt: "How many cryptocurrency exchanges are there? How many of these are centralized or decentralized? What does this imply in relation to the transparancy of the volumes in cryptocurrency? Let's find out."
header:
  overlay_image: /img/posts/01-exchanges/nomics-api.jpg
  overlay_filter: rgba(0, 0, 0, 0.3)
category: R
---
  
We're going to discuss the following topics:

-   Install RStudio, R and relevant packages
-   Choose what data you wish to work with
    -   Nomics
    -   Find an endpoint you want to look at
-   Construct the endpoint URL
-   Explore the data
-   Clean the data
-   Manipulate and alter the data if required
-   Visualise the data
-   Analyze the data

------------------------------------------------------------------------

## Step 1: Install & Load Packages

Download RStudio and install R if you haven’t already. We are going to
load some libraries that we need. These provide added functionality.
Open a new R script (CTRL+SHIFT+N) and type in the following:

``` r
#install.packages("package_name") 

#working with API data
library(httr)
library(jsonlite)

#data visualization
library(ggplot2)
library(ggthemes) #bonus for ggplot

#data manipulation & wrangling
library(tidyverse)

#html widgets
library(htmlwidgets)
library(readr)
```

## Step 2: Initiate Nomics API & Gather Results

Now we need to get our hands on some data. In this case the data is
obtained via the [Nomics
API](https://p.nomics.com/cryptocurrency-bitcoin-api). In order to
receive your own personal API key, you have to sign up for a free
account. A good place to start is the [API
documentation](https://nomics.com/docs/). Here you will see the
obtainable data, categorized by endpoints. You must include your API Key
as a query parameter in every request you make. For example:
<https://api.nomics.com/v1/markets?key=your-key-here>.

Each endpoint is basically a URL. The URL in the code snippet below is
part of the ‘exchanges’ endpoint and returns some exchange-related data.

``` r
baseurl <- "https://api.nomics.com/v1/exchanges/ticker?key=your-key-here"
```

You will need to obtain data from this URL and convert it into something
readable. Let’s first store the output in a data frame and have a look.

``` r
exchanges_ticker <- fromJSON(baseurl)

glimpse(exchanges_ticker)
```

    ## Rows: 100
    ## Columns: 18
    ## $ id                 <chr> "binance", "ftx", "cryptomkt", "gdax", "uniswapv3",~
    ## $ name               <chr> "Binance", "FTX", "CryptoMarket", "Coinbase Exchang~
    ## $ logo_url           <chr> "https://s3.us-east-2.amazonaws.com/nomics-api/stat~
    ## $ transparency_grade <chr> "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "~
    ## $ coverage_type      <chr> "trades", "trades", "trades", "trades", "trades", "~
    ## $ order_books        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRU~
    ## $ first_trade        <chr> "2017-07-13T00:00:00Z", "2019-03-05T00:00:00Z", "20~
    ## $ first_candle       <chr> "2017-07-13T00:00:00Z", "2019-03-05T00:00:00Z", "20~
    ## $ first_order_book   <chr> "2018-08-29T00:00:00Z", "2019-10-15T00:00:00Z", "20~
    ## $ num_pairs          <chr> "2201", "1969", "159", "493", "3741", "325", "2641"~
    ## $ num_pairs_unmapped <chr> "9", "99", "5", "16", "2332", "486", "68", "4", "96~
    ## $ last_updated       <chr> "2022-03-09T19:45:48.546Z", "2022-03-09T19:45:50.58~
    ## $ fiat_currencies    <list> <"AUD", "BRL", "EUR", "GBP", "NGN", "RUB", "TRY", ~
    ## $ rank               <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", ~
    ## $ weight             <chr> "1.0000", "0.8284", "0.5390", "0.8984", "0.8257", "~
    ## $ centralized        <lgl> TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TR~
    ## $ decentralized      <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, FAL~
    ## $ `1d`               <df[,12]> <data.frame[26 x 12]>

Note that there are only 100 rows. In this case there are several pages
of data for exchanges and we would want to get all pages in the same
object. The URL changes slightly per page so we will make a for loop. We
will make an empty list and store each iteration of the loop inside that
list. Then we construct the data frame from the list.

``` r
#for loop to get more pages for exchanges ticker - store all pages in a list first
pages <- list()

  for(i in 0:4){
    mydata <- fromJSON(paste0(baseurl, "&page=", i))
    message("Retrieving page ", i)
    pages[[i+1]] <- mydata
  }

#combine all pages into one df
exchanges_ticker <- rbind_pages(pages)
```

------------------------------------------------------------------------

## Step 3: Explore the data

Let’s have a look at the data frame we just created.

``` r
glimpse(exchanges_ticker)
```

    ## Rows: 500
    ## Columns: 18
    ## $ id                 <chr> "binance", "ftx", "cryptomkt", "gdax", "uniswapv3",~
    ## $ name               <chr> "Binance", "FTX", "CryptoMarket", "Coinbase Exchang~
    ## $ logo_url           <chr> "https://s3.us-east-2.amazonaws.com/nomics-api/stat~
    ## $ transparency_grade <chr> "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "~
    ## $ coverage_type      <chr> "trades", "trades", "trades", "trades", "trades", "~
    ## $ order_books        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRU~
    ## $ first_trade        <chr> "2017-07-13T00:00:00Z", "2019-03-05T00:00:00Z", "20~
    ## $ first_candle       <chr> "2017-07-13T00:00:00Z", "2019-03-05T00:00:00Z", "20~
    ## $ first_order_book   <chr> "2018-08-29T00:00:00Z", "2019-10-15T00:00:00Z", "20~
    ## $ num_pairs          <chr> "2201", "1969", "159", "493", "3741", "325", "2641"~
    ## $ num_pairs_unmapped <chr> "9", "99", "5", "16", "2332", "486", "68", "4", "96~
    ## $ last_updated       <chr> "2022-03-09T19:41:35.092Z", "2022-03-09T19:41:46.02~
    ## $ fiat_currencies    <list> <"AUD", "BRL", "EUR", "GBP", "NGN", "RUB", "TRY", ~
    ## $ rank               <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", ~
    ## $ weight             <chr> "1.0000", "0.8284", "0.5390", "0.8984", "0.8257", "~
    ## $ centralized        <lgl> TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TR~
    ## $ decentralized      <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, FAL~
    ## $ `1d`               <df[,12]> <data.frame[26 x 12]>

Note that there are a lot of character and some logical variables. There
is also a list and a data frame nested inside the return. We will have
to change some character variables to numerical variables and integers.
We also see a logical variables relating to the type of exchange
(centralized versus decentralized) and we might want to change that to a
single column and a categorical variable.

------------------------------------------------------------------------

Also, If we want to order by transparency grade later, we need to
reorder the variable. Have a look at how this is being sorted.

``` r
sort(exchanges_ticker$transparency)
```

    ##   [1] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ##  [16] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ##  [31] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ##  [46] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ##  [61] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ##  [76] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ##  [91] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [106] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [121] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [136] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [151] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [166] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [181] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [196] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [211] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A-" "A-"
    ## [226] "A-" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+"
    ## [241] "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+"
    ## [256] "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "B"  "B"  "B"  "B"  "B" 
    ## [271] "B"  "B"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [286] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [301] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [316] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [331] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [346] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [361] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [376] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [391] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [406] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [421] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [436] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [451] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [466] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [481] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [496] "D"  "D"  "D"  "D"  "D"

Since it is a character variable it will default to sorting
alphabetically (hence the better score (A+) will not be ranked on top).
We will manually have to reorder this variable.

------------------------------------------------------------------------

## Step 4: Clean the data

We redefine the ‘cleaned’ data frame itself as a new variable so we keep
the original data frame intact in case we need to go back.

``` r
#mutate data
exchanges_ticker_clean <- exchanges_ticker %>% 
  mutate(transparency_grade = factor(transparency_grade, 
                                     levels = c("A+","A","A-","B","C","D")),
         first_trade = as.Date(first_trade),
         first_candle = as.Date(first_candle),
         first_order_book = as.Date(first_order_book),
         num_pairs = as.integer(num_pairs),
         num_pairs_unmapped = as.integer(num_pairs_unmapped),
         last_updated = as.Date(last_updated),
         rank = as.integer(rank),
         weight = as.numeric(weight),
         type = if_else(centralized == TRUE, "centralized", "decentralized")
         )

glimpse(exchanges_ticker_clean)
```

    ## Rows: 500
    ## Columns: 19
    ## $ id                 <chr> "binance", "ftx", "cryptomkt", "gdax", "uniswapv3",~
    ## $ name               <chr> "Binance", "FTX", "CryptoMarket", "Coinbase Exchang~
    ## $ logo_url           <chr> "https://s3.us-east-2.amazonaws.com/nomics-api/stat~
    ## $ transparency_grade <fct> A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A, ~
    ## $ coverage_type      <chr> "trades", "trades", "trades", "trades", "trades", "~
    ## $ order_books        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRU~
    ## $ first_trade        <date> 2017-07-13, 2019-03-05, 2013-12-27, 2014-12-01, 20~
    ## $ first_candle       <date> 2017-07-13, 2019-03-05, 2013-12-27, 2014-12-01, 20~
    ## $ first_order_book   <date> 2018-08-29, 2019-10-15, 2021-12-01, 2018-09-11, 20~
    ## $ num_pairs          <int> 2201, 1969, 159, 493, 3741, 325, 2641, 480, 1398, 5~
    ## $ num_pairs_unmapped <int> 9, 99, 5, 16, 2332, 486, 68, 4, 96, 221, 0, 790720,~
    ## $ last_updated       <date> 2022-03-09, 2022-03-09, 2022-03-09, 2022-03-09, 20~
    ## $ fiat_currencies    <list> <"AUD", "BRL", "EUR", "GBP", "NGN", "RUB", "TRY", ~
    ## $ rank               <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, ~
    ## $ weight             <dbl> 1.0000, 0.8284, 0.5390, 0.8984, 0.8257, 0.7486, 0.7~
    ## $ centralized        <lgl> TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TR~
    ## $ decentralized      <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, FAL~
    ## $ `1d`               <df[,12]> <data.frame[26 x 12]>
    ## $ type               <chr> "centralized", "centralized", "centralized", "c~

Note that this already looks a lot better and we are getting close to
being able to work with this output.

------------------------------------------------------------------------

## Step 5: Select, manipulate and plot

Here we filter our cleaned data into a ggplot. We want to visualize the
counts of the two different types of exchanges (centralized and
decentralized). Then we fill the bars based on the transparency grade to
see where most of the transparent volume originates from.

``` r
#plot types of exchanges
exchanges_ticker_clean %>%  
  ggplot(aes(type, fill=transparency_grade)) + 
  geom_bar(color = "black",
           position = "stack") +
  labs(title = "Types of Exchanges (CEX vs. DEX)",
       subtitle = "Source: Nomics API",
       x = "Exchange Type",
       y = "Number of Exchanges") +
  theme_fivethirtyeight() +
  theme(axis.title = element_text(),
        legend.text =  element_text(size=10)) + 
  scale_fill_brewer(palette = 9) +
  guides(fill = guide_legend(title = "Transparency Grade"))
```

![](/img/posts/01-exchanges/exchange-types.png)<!-- -->

Here we do the same thing, but the other way around. We plot the
different transparency grades on the x-axis, and the count on the
y-axis. The fill resembles the type of exchange.

``` r
#plot exchange types
exchanges_ticker_clean %>% 
  ggplot(aes(transparency_grade, fill=type)) + 
  geom_bar(color = "black",
           position = "stack") +
  labs(title = "Transparancy Grade by Exchange Type",
       subtitle = "Source: Nomics API",
       x = "Transparancy Grade",
       y = "Number of Exchanges") +
  theme_fivethirtyeight() +
  theme(axis.title = element_text(),
        legend.text =  element_text(size=10)) +
  guides(fill = guide_legend(title = "Type"))
```

![](/img/posts/01-exchanges/exchange-transparency.png)<!-- -->

## Conclusion

It would appear that most of the transparent volume originates from the
decentralized exchanges.
