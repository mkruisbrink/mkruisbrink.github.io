---
title: "Centralized vs. Decentralized Exchanges"
excerpt: "How many cryptocurrency exchanges are there? Comparing transparant volumes for centralised and decentralized cryptocurrency exchanges"
header:
  overlay_image: /assets/images/midjourney-optimised/big-computer-screen-financial-dashoard-optimised.jpg
categories: 
  - Cryptocurrency
tags:
  - Visualisation
  - Rstudio
---
  
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

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.2 --
    ## v tibble  3.1.8     v dplyr   1.0.9
    ## v tidyr   1.2.0     v stringr 1.4.0
    ## v readr   2.1.2     v forcats 0.5.1
    ## v purrr   0.3.4     
    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter()  masks stats::filter()
    ## x purrr::flatten() masks jsonlite::flatten()
    ## x dplyr::lag()     masks stats::lag()

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
    ## $ id                 <chr> "binance", "fuzionx", "gdax", "lbank", "kraken", "c~
    ## $ name               <chr> "Binance", "FuzionX", "Coinbase Exchange", "Lbank",~
    ## $ logo_url           <chr> "https://s3.us-east-2.amazonaws.com/nomics-api/stat~
    ## $ transparency_grade <chr> "A", "A+", "A", "A", "A", "A", "A", "A", "A", "A", ~
    ## $ coverage_type      <chr> "trades", "trades", "trades", "trades", "trades", "~
    ## $ order_books        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRU~
    ## $ first_trade        <chr> "2017-07-13T00:00:00Z", "2018-11-15T00:00:00Z", "20~
    ## $ first_candle       <chr> "2017-07-13T00:00:00Z", "2018-11-15T00:00:00Z", "20~
    ## $ first_order_book   <chr> "2018-08-29T00:00:00Z", "2022-08-03T00:00:00Z", "20~
    ## $ num_pairs          <chr> "2477", "148", "636", "1779", "671", "167", "3040",~
    ## $ num_pairs_unmapped <chr> "1", "11", "7", "258", "17", "9", "95", "3972", "79~
    ## $ last_updated       <chr> "2022-11-28T21:47:13.375Z", "2022-11-28T21:47:21.12~
    ## $ fiat_currencies    <list> <"AUD", "BRL", "EUR", "GBP", "NGN", "PLN", "RUB", ~
    ## $ rank               <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", ~
    ## $ weight             <chr> "1.0000", "0.1392", "0.8653", "0.6920", "0.7830", "~
    ## $ centralized        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TR~
    ## $ decentralized      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TR~
    ## $ `1d`               <df[,12]> <data.frame[26 x 12]>

Note that there are only 100 rows. In this case there are several pages
of data for exchanges and we would want to get all pages in the same
object. The URL changes slightly per page so we will make a for loop. We
will make an empty list and store each iteration of the loop inside that
list. Then we construct the data frame from the list.

``` r
# create a for loop and store all pages in a list
pages <- list()

# there are currently 9 pages (https://nomics.com/exchanges/9)
# you could webscrape untill the last page automatically
  for(i in 0:9){
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

    ## Retrieving page 7

    ## Retrieving page 8

    ## Retrieving page 9

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

    ## Rows: 965
    ## Columns: 18
    ## $ id                 <chr> "binance", "fuzionx", "gdax", "lbank", "kraken", "c~
    ## $ name               <chr> "Binance", "FuzionX", "Coinbase Exchange", "Lbank",~
    ## $ logo_url           <chr> "https://s3.us-east-2.amazonaws.com/nomics-api/stat~
    ## $ transparency_grade <chr> "A", "A+", "A", "A", "A", "A", "A", "A", "A", "A", ~
    ## $ coverage_type      <chr> "trades", "trades", "trades", "trades", "trades", "~
    ## $ order_books        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRU~
    ## $ first_trade        <chr> "2017-07-13T00:00:00Z", "2018-11-15T00:00:00Z", "20~
    ## $ first_candle       <chr> "2017-07-13T00:00:00Z", "2018-11-15T00:00:00Z", "20~
    ## $ first_order_book   <chr> "2018-08-29T00:00:00Z", "2022-08-03T00:00:00Z", "20~
    ## $ num_pairs          <chr> "2477", "148", "636", "1779", "671", "167", "3040",~
    ## $ num_pairs_unmapped <chr> "1", "11", "7", "258", "17", "9", "95", "3972", "79~
    ## $ last_updated       <chr> "2022-11-28T21:47:13.375Z", "2022-11-28T21:47:21.12~
    ## $ fiat_currencies    <list> <"AUD", "BRL", "EUR", "GBP", "NGN", "PLN", "RUB", ~
    ## $ rank               <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", ~
    ## $ weight             <chr> "1.0000", "0.1392", "0.8653", "0.6920", "0.7830", "~
    ## $ centralized        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TR~
    ## $ decentralized      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TR~
    ## $ `1d`               <df[,12]> <data.frame[26 x 12]>

Note that there are a lot of character and some logical variables. There
is also a list and a data frame nested inside the return. We will have
to change some character variables to numerical variables and integers.
We also see a logical variables relating to the type of exchange
(centralized versus decentralized) and we might want to change that to a
single column and a categorical variable.

------------------------------------------------------------------------

Also, If we want to order by transparency grade later, we need to
reorder this variable. Have a look at how this is being sorted.

``` r
sort(exchanges_ticker$transparency)
```

    ##   [1] "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?" 
    ##  [16] "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?" 
    ##  [31] "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "?"  "A"  "A" 
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
    ## [421] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [436] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [451] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A" 
    ## [466] "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A-"
    ## [481] "A-" "A-" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+"
    ## [496] "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+"
    ## [511] "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+" "A+"
    ## [526] "A+" "A+" "B"  "B"  "B"  "B"  "B"  "B"  "B"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [541] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [556] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [571] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [586] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [601] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [616] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [631] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C" 
    ## [646] "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "C"  "D"  "D" 
    ## [661] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [676] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [691] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [706] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [721] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [736] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [751] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [766] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [781] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [796] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [811] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [826] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [841] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [856] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [871] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [886] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [901] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [916] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [931] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [946] "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D"  "D" 
    ## [961] "D"  "D"  "D"  "D"  "D"

Since it is a character variable it will default to sorting
alphabetically (hence the better score (A+) will not be ranked on top).
We will manually have to reorder this variable.

We also note that there’s a nested data frame inside (1d metrics) and we
need to unnest this to get tidy data.

``` r
df <- exchanges_ticker %>% unnest(`1d`)
```

------------------------------------------------------------------------

## Step 4: Clean the data

We redefine the ‘manipulated’ data frame (`df`) itself as a new variable
so we keep the original data frame intact in case we need to go back.

``` r
# clean and mutate the data frame

df <- df %>%
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
         type = if_else(centralized == TRUE, "Centralized", "Decentralized"),
         volume = as.numeric(volume),
         volume_change = as.numeric(volume_change),
         volume_change_pct = as.numeric(volume_change_pct),
         trades = as.numeric(trades), 
         trades_change = as.numeric(trades_change),
         trades_change_pct = as.numeric(trades_change_pct),
         spot_volume= as.numeric(spot_volume),
         spot_volume_change = as.numeric(spot_volume_change),
         spot_volume_change_pct = as.numeric(spot_volume_change_pct),
         derivative_volume = as.numeric(derivative_volume),
         derivative_volume_change = as.numeric(derivative_volume_change),
         derivative_volume_change_pct = as.numeric(derivative_volume_change_pct)
         )

glimpse(df)
```

    ## Rows: 965
    ## Columns: 30
    ## $ id                           <chr> "binance", "fuzionx", "gdax", "lbank", "k~
    ## $ name                         <chr> "Binance", "FuzionX", "Coinbase Exchange"~
    ## $ logo_url                     <chr> "https://s3.us-east-2.amazonaws.com/nomic~
    ## $ transparency_grade           <fct> A, A+, A, A, A, A, A, A, A, A, A, A, A, A~
    ## $ coverage_type                <chr> "trades", "trades", "trades", "trades", "~
    ## $ order_books                  <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE,~
    ## $ first_trade                  <date> 2017-07-13, 2018-11-15, 2014-12-01, 2017~
    ## $ first_candle                 <date> 2017-07-13, 2018-11-15, 2014-12-01, 2017~
    ## $ first_order_book             <date> 2018-08-29, 2022-08-03, 2018-09-11, 2019~
    ## $ num_pairs                    <int> 2477, 148, 636, 1779, 671, 167, 3040, 541~
    ## $ num_pairs_unmapped           <int> 1, 11, 7, 258, 17, 9, 95, 3972, 793, 282,~
    ## $ last_updated                 <date> 2022-11-28, 2022-11-28, 2022-11-28, 2022~
    ## $ fiat_currencies              <list> <"AUD", "BRL", "EUR", "GBP", "NGN", "PLN~
    ## $ rank                         <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13~
    ## $ weight                       <dbl> 1.0000, 0.1392, 0.8653, 0.6920, 0.7830, 0~
    ## $ centralized                  <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE,~
    ## $ decentralized                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,~
    ## $ volume                       <dbl> 44418323887, 4313251712, 1635514410, 1151~
    ## $ volume_change                <dbl> 16590039808, 1498599265, 919610187, 17924~
    ## $ volume_change_pct            <dbl> 0.5962, 0.5324, 1.2845, 0.1843, 1.4961, 0~
    ## $ trades                       <dbl> 34683821, 802232, 2753104, 3263070, 54507~
    ## $ trades_change                <dbl> 6438742, -9186, 979737, -351542, 281507, ~
    ## $ trades_change_pct            <dbl> 0.2280, -0.0113, 0.5525, -0.0973, 1.0681,~
    ## $ spot_volume                  <dbl> 8981597036, 4313251712, 1635514410, 11516~
    ## $ spot_volume_change           <dbl> 422128664, 1498599265, 919610187, 1792484~
    ## $ spot_volume_change_pct       <dbl> 0.0493, 0.5324, 1.2845, 0.1843, 1.4961, 0~
    ## $ derivative_volume            <dbl> 35436726851, NA, NA, NA, NA, NA, NA, NA, ~
    ## $ derivative_volume_change     <dbl> 16167911143, NA, NA, NA, NA, NA, NA, NA, ~
    ## $ derivative_volume_change_pct <dbl> 0.8391, NA, NA, NA, NA, NA, NA, NA, 0.772~
    ## $ type                         <chr> "Centralized", "Centralized", "Centralize~

``` r
df$type <- as_factor(df$type)
```

Note that this already looks a lot better and we are getting close to
being able to work with this output.

------------------------------------------------------------------------

## Step 5: Select, manipulate and plot

Here we pipe (`%>%`) our cleaned data into the `ggplot()` function to
obtain graphics.

### CEX versus DEX

We want to visualize the counts of the two different types of exchanges
(centralized and decentralized). Then we fill the bars based on the
transparency grade to see where most of the transparent volume
originates from.

``` r
# plot types of exchanges
df %>%
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

![](/assets/reports/plots/types-of-exchanges-1.png)<!-- -->

Here we do the same thing, but the other way around. We plot the
different transparency grades on the x-axis, and the count on the
y-axis. The fill resembles the type of exchange.

``` r
# plot exchange types
df %>% 
  ggplot(aes(transparency_grade, fill=type)) + 
  geom_bar(color = "black",
           position = "stack") +
  labs(title = "Transparency Grade by Exchange Type",
       subtitle = "Source: Nomics API",
       x = "Transparency Grade",
       y = "Number of Exchanges") +
  theme_pilot() +
  theme(axis.title = element_text(),
        legend.text =  element_text(size=10)) +
  guides(fill = guide_legend(title = "Type"))
```

![](/assets/reports/plots/transparancy-exchange-types-1.png)<!-- -->

## Results

From these two rather simple plots, it would appear that most of the
transparent volumes (grade A+ and A) originate from decentralized
exchanges. In addition, most of the low transparent volumes are
originating from centralized exchanges.
