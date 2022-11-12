---
#layout: post
title: Centralized vs. Decentralized Exchanges
date: 2022-11-6 14:40:45
subtitle: Exploring the Nomics API
excerpt: "How many cryptocurrency exchanges are there? Comparing transparant volumes for centralised and decentralized cryptocurrency exchanges."
header:
  overlay_image: /assets/images/midjourney-optimised/big-computer-screen-financial-dashoard-optimised.jpg
category: 
- Visualization
tags:
- Cryptocurrency
- Exchanges
- Nomics
---
  
How many cryptocurrency exchanges are there? How many of these are centralized or decentralized? How do the transparant volumes compare?

## Introduction

In this article we’re going to import cryptocurrency related data via
the API provided by [Nomics.com](https://www.nomics.com) into RStudio.

- Find an endpoint you want to look at
- Construct the endpoint URL
- Import the data into RStudio
- Explore the data
- Clean the data
- Manipulate and alter the data if required
- Visualise the data
- Analyze the data

------------------------------------------------------------------------

## Prerequisites

I am assuming you have R and RStudio installed and know the basics of
how to use RStudio. If not, follow:

1.  [My guide for base R
    installation](%7B%%20post_url%202022-08-08-r-installation%20%%7D)
2.  [My guide for RStudio
    installation](%7B%%20post_url%202022-08-08-rstudio-installation%20%%7D)
3.  [My guide for an RStudio
    introduction](%7B%%20post_url%202022-08-09-rstudio-introduction%20%%7D)

## Step 1: Install & Load Packages

We are going to load some libraries that we need. These provide added
functionality. Open up your R Project or opena new R script and type in
the following:

``` r
# install.packages("package_name") 

# working with API data
library(httr)
library(jsonlite)

# data visualization
library(ggplot2)
library(ggthemes) #bonus for ggplot
library(pilot)

# data manipulation & wrangling
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ## ✔ tibble  3.1.8      ✔ dplyr   1.0.10
    ## ✔ tidyr   1.2.1      ✔ stringr 1.4.1 
    ## ✔ readr   2.1.3      ✔ forcats 0.5.2 
    ## ✔ purrr   0.3.5      
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter()  masks stats::filter()
    ## ✖ purrr::flatten() masks jsonlite::flatten()
    ## ✖ dplyr::lag()     masks stats::lag()

``` r
# html widgets
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
# pasting the base url and API variable
baseurl <- paste0("https://api.nomics.com/v1/exchanges/ticker?key=",
                  API_key)
```

You will need to obtain data from this URL and convert it into something
readable. Let’s first store the output in a data frame and have a look.

``` r
# convert object from JSON
exchanges_ticker <- fromJSON(baseurl)

# peekaboo
glimpse(exchanges_ticker)
```

    ## Rows: 100
    ## Columns: 18
    ## $ id                 <chr> "binance", "ftx", "fuzionx", "gdax", "lbank", "cryp…
    ## $ name               <chr> "Binance", "FTX", "FuzionX", "Coinbase Exchange", "…
    ## $ logo_url           <chr> "https://s3.us-east-2.amazonaws.com/nomics-api/stat…
    ## $ transparency_grade <chr> "A", "A", "A+", "A", "A", "A", "A", "A", "A", "A", …
    ## $ coverage_type      <chr> "trades", "trades", "trades", "trades", "trades", "…
    ## $ order_books        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRU…
    ## $ first_trade        <chr> "2017-07-13T00:00:00Z", "2019-03-05T00:00:00Z", "20…
    ## $ first_candle       <chr> "2017-07-13T00:00:00Z", "2019-03-05T00:00:00Z", "20…
    ## $ first_order_book   <chr> "2018-08-29T00:00:00Z", "2019-10-15T00:00:00Z", "20…
    ## $ num_pairs          <chr> "2471", "2305", "148", "632", "1754", "167", "3021"…
    ## $ num_pairs_unmapped <chr> "1", "173", "11", "6", "252", "9", "99", "3793", "7…
    ## $ last_updated       <chr> "2022-11-06T20:55:03.738Z", "2022-11-06T20:55:02.76…
    ## $ fiat_currencies    <list> <"AUD", "BRL", "EUR", "GBP", "NGN", "PLN", "RUB", …
    ## $ rank               <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", …
    ## $ weight             <chr> "1.0000", "0.8212", "0.1398", "0.8524", "0.6878", "…
    ## $ centralized        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TR…
    ## $ decentralized      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TR…
    ## $ `1d`               <df[,12]> <data.frame[26 x 12]>

Note that there are only 100 rows. In this case there are several pages
of data for exchanges and we would want to get all pages in the same
object. The URL changes slightly per page so we will make a for loop. We
will make an empty list and store each iteration of the loop inside that
list. Then we construct the data frame from the list.

``` r
# create a for loop and store all pages in a list
pages <- list()

# there are currently 6 pages (https://nomics.com/exchanges/6)
# you could webscrape untill the last page automatically
  for(i in 0:6){
    mydata <- fromJSON(paste0(baseurl, "&page=", i))
    message("Retrieving page ", i)
    pages[[i+1]] <- mydata
  }
```

    ## Retrieving page 0

    ## Retrieving page 1

    ## Retrieving page 2

    ## Retrieving page 3

    ## Retrieving page 4

    ## Retrieving page 5

    ## Retrieving page 6

``` r
# combine all pages into one df
exchanges_ticker <- rbind_pages(pages)
```

------------------------------------------------------------------------

## Step 3: Explore the data

Let’s have a look at the data frame we just created.

``` r
glimpse(exchanges_ticker)
```

    ## Rows: 700
    ## Columns: 18
    ## $ id                 <chr> "binance", "ftx", "fuzionx", "gdax", "lbank", "cryp…
    ## $ name               <chr> "Binance", "FTX", "FuzionX", "Coinbase Exchange", "…
    ## $ logo_url           <chr> "https://s3.us-east-2.amazonaws.com/nomics-api/stat…
    ## $ transparency_grade <chr> "A", "A", "A+", "A", "A", "A", "A", "A", "A", "A", …
    ## $ coverage_type      <chr> "trades", "trades", "trades", "trades", "trades", "…
    ## $ order_books        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRU…
    ## $ first_trade        <chr> "2017-07-13T00:00:00Z", "2019-03-05T00:00:00Z", "20…
    ## $ first_candle       <chr> "2017-07-13T00:00:00Z", "2019-03-05T00:00:00Z", "20…
    ## $ first_order_book   <chr> "2018-08-29T00:00:00Z", "2019-10-15T00:00:00Z", "20…
    ## $ num_pairs          <chr> "2471", "2305", "148", "632", "1754", "167", "3021"…
    ## $ num_pairs_unmapped <chr> "1", "173", "11", "6", "252", "9", "99", "3793", "7…
    ## $ last_updated       <chr> "2022-11-06T20:55:03.738Z", "2022-11-06T20:55:02.76…
    ## $ fiat_currencies    <list> <"AUD", "BRL", "EUR", "GBP", "NGN", "PLN", "RUB", …
    ## $ rank               <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", …
    ## $ weight             <chr> "1.0000", "0.8212", "0.1398", "0.8524", "0.6878", "…
    ## $ centralized        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TR…
    ## $ decentralized      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TR…
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
    ## [211] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [226] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [241] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [256] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [271] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [286] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [301] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [316] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [331] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [346] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [361] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [376] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [391] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [406] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [421] "A"  "A"  "A"  "A"  "A"  "A"  "A-" "A-" "A-" "A+" "A+" "A+" "A+" "A+" "A+"
    ## [436] "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+"
    ## [451] "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+"
    ## [466] "A+" "A+" "A+" "A+" "A+" "B"  "B"  "B"  "B"  "B"  "B"  "B"  "C"  "C"  "C" 
    ## [481] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [496] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [511] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [526] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [541] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [556] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [571] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [586] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [601] "C"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [616] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [631] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [646] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [661] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [676] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [691] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"

Since it is a character variable it will default to sorting
alphabetically (hence the better score (A+) will not be ranked on top).
We will manually have to reorder this variable.

------------------------------------------------------------------------

## Step 4: Clean the data

We redefine the ‘cleaned’ data frame itself as a new variable so we keep
the original data frame intact in case we need to go back.

``` r
# mutate data
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
         type = if_else(centralized == TRUE, "Centralized", "Decentralized")
         )

glimpse(exchanges_ticker_clean)
```

    ## Rows: 700
    ## Columns: 19
    ## $ id                 <chr> "binance", "ftx", "fuzionx", "gdax", "lbank", "cryp…
    ## $ name               <chr> "Binance", "FTX", "FuzionX", "Coinbase Exchange", "…
    ## $ logo_url           <chr> "https://s3.us-east-2.amazonaws.com/nomics-api/stat…
    ## $ transparency_grade <fct> A, A, A+, A, A, A, A, A, A, A, A, A, A, A, A, A, A,…
    ## $ coverage_type      <chr> "trades", "trades", "trades", "trades", "trades", "…
    ## $ order_books        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRU…
    ## $ first_trade        <date> 2017-07-13, 2019-03-05, 2018-11-15, 2014-12-01, 20…
    ## $ first_candle       <date> 2017-07-13, 2019-03-05, 2018-11-15, 2014-12-01, 20…
    ## $ first_order_book   <date> 2018-08-29, 2019-10-15, 2022-08-03, 2018-09-11, 20…
    ## $ num_pairs          <int> 2471, 2305, 148, 632, 1754, 167, 3021, 5233, 389, 6…
    ## $ num_pairs_unmapped <int> 1, 173, 11, 6, 252, 9, 99, 3793, 769, 19, 1123806, …
    ## $ last_updated       <date> 2022-11-06, 2022-11-06, 2022-11-06, 2022-11-06, 20…
    ## $ fiat_currencies    <list> <"AUD", "BRL", "EUR", "GBP", "NGN", "PLN", "RUB", …
    ## $ rank               <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, …
    ## $ weight             <dbl> 1.0000, 0.8212, 0.1398, 0.8524, 0.6878, 0.4995, 0.7…
    ## $ centralized        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TR…
    ## $ decentralized      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TR…
    ## $ `1d`               <df[,12]> <data.frame[26 x 12]>
    ## $ type               <chr> "Centralized", "Centralized", "Centralized", "C…

Note that this already looks a lot better and we are getting close to
being able to work with this output.

------------------------------------------------------------------------

## Step 5: Select, manipulate and plot

Here we filter our cleaned data into a ggplot. We want to visualize the
counts of the two different types of exchanges (centralized and
decentralized). Then we fill the bars based on the transparency grade to
see where most of the transparent volume originates from.

``` r
# plot types of exchanges
exchanges_ticker_clean %>%  
  ggplot(aes(type, fill=transparency_grade)) + 
  geom_bar(color = "black",
           position = "stack") +
  labs(title = "Types of Exchanges (CEX vs. DEX)",
       subtitle = "Source: Nomics API",
       x = "Exchange Type",
       y = "Number of Exchanges") +
  theme_pilot() +
  theme(axis.title = element_text(),
        legend.text =  element_text(size=10)) + 
  scale_fill_brewer(palette = 9) +
  guides(fill = guide_legend(title = "Transparency Grade"))
```

![](/assets/rmd/types-of-exchanges-1.png)<!-- -->

Here we do the same thing, but the other way around. We plot the
different transparency grades on the x-axis, and the count on the
y-axis. The fill resembles the type of exchange.

``` r
# plot exchange types
exchanges_ticker_clean %>% 
  ggplot(aes(transparency_grade, fill=type)) + 
  geom_bar(color = "black",
           position = "stack") +
  labs(title = "Transparancy Grade by Exchange Type",
       subtitle = "Source: Nomics API",
       x = "Transparancy Grade",
       y = "Number of Exchanges") +
  theme_pilot() +
  theme(axis.title = element_text(),
        legend.text =  element_text(size=10)) +
  guides(fill = guide_legend(title = "Type"))
```

![](/assets/rmd/transparancy-exchange-types-1.png)<!-- -->

## Results

From these two rather simple plots, it would appear that most of the
transparent volumes (grade A+ and A) originate from the decentralized
exchanges. In addition, most of the low transparent volumes are
originating from centralized exchanges.
