---
#layout: post
title: An introduction to the Tidyverse
subtitle: Getting started with R and RStudio
excerpt: "In this guide I'm going to walk you through on how to install base R, an open-source software environment used mainly for statistical computing and graphics."
header:
  overlay_image: /img/20220808_supernova-midjourney.jpg
  overlay_filter: rgba(0, 0, 0, 0.3)
category: 
- R Packages
tags:
- R
- RStudio
- tidyverse
---

## What is the tidyverse?

The tidyverse is a package in R that is - in itself - a collection of individual R packages that all work closely together in the same way (they speak thesame kind of language, if you will). Data import & export, manipulation, exploration and visualisation becomes simpler and more elegant by using new and additional syntax which is more intuitive to and readible for us humans.

>
The tidyverse is an opinionated **[collection of R packages](https://www.tidyverse.org/packages)** designed for data science. All packages share an underlying design philosophy, grammar, and data structures. __www.tidyverse.org__

The tidyverse is a toolkit of functionality that is perfect for data scientists. Working with the tidyverse makes your code more intuitive and easy to read and understand. The tidyverse offers a more elegant way to approach the most common data science problems and is widely used today.

<figure class="small-centered">
  <img src="/img/icons/r-packages/thumbs/tidyverse.png" alt="dplyr logo"/>
</figure>

You can install the tidyverse via **`install.packages("tidyverse")`** and you only have to install it once.

## Contents of the tidyverse

We’re going to briefly discuss the core contents of the tidyverse, what you might use these packages for and I’ll provide links to the respective documentation as well. 

>
You will definitely not need to know and understand all of these packages, but I am sure that you will love using the functionality that these packages provide. 

The core tidyverse includes the packages that you’re likely to use in everyday data analyses. As of tidyverse 1.3.0, the following packages are included in the core tidyverse:

<figure class="small-centered">
  <img src="/img/icons/r-packages/thumbs/ggplot2.png" alt="ggplot2 logo"/>
</figure>

### [ggplot2](https://ggplot2.tidyverse.org/) (visualization)

`ggplot2` is a system for declaratively creating graphics, based on The Grammar of Graphics. You provide the data, tell ggplot2 how to map variables to aesthetics, what graphical primitives to use, and it takes care of the details. [Go to docs...](https://ggplot2.tidyverse.org/)

```R
library(tidyverse) #loads ggplot 

ggplot(mydata, aes(x = x, y = y)) +
  geom_line(color = red)
```


<figure class="small-centered">
  <img src="/img/icons/r-packages/thumbs/dplyr.png" alt="dplyr logo"/>
</figure>

### [dplyr](https://dplyr.tidyverse.org/) (wrangling)

`dplyr` provides a grammar of data manipulation, providing a consistent set of verbs that solve the most common data manipulation challenges. [Go to docs...](https://dplyr.tidyverse.org/)

<figure class="small-centered">
  <img src="/img/icons/r-packages/thumbs/tidyr.png" alt="tidyr logo"/>
</figure>

### [tidyr](https://tidyr.tidyverse.org/) (tidying)

`tidyr` provides a set of functions that help you get to tidy data. Tidy data is data with a consistent form: in brief, every variable goes in a column, and every column is a variable. [Go to docs...](https://tidyr.tidyverse.org/)

<figure class="small-centered">
  <img src="/img/icons/r-packages/thumbs/readr.png" alt="readr logo"/>
</figure>

### [readr](https://readr.tidyverse.org/) (read & import)

`readr` provides a fast and friendly way to read rectangular data (like csv, tsv, and fwf). It is designed to flexibly parse many types of data found in the wild, while still cleanly failing when data unexpectedly changes.  [Go to docs...](https://readr.tidyverse.org/)

<figure class="small-centered">
  <img src="/img/icons/r-packages/thumbs/purrr.png" alt="purrr logo"/>
</figure>

### [purrr](https://purrr.tidyverse.org/) (mapping)

`purrr` enhances R’s functional programming (FP) toolkit by providing a complete and consistent set of tools for working with functions and vectors. Once you master the basic concepts, purrr allows you to replace many for loops with code that is easier to write and more expressive. [Go to docs...](https://purrr.tidyverse.org/)

<figure class="small-centered">
  <img src="/img/icons/r-packages/thumbs/tibble.png" alt="tibble logo"/>
</figure>

### [tibble](https://tibble.tidyverse.org/) (enhanced data frames)

`tibble` is a modern re-imagining of the data frame, keeping what time has proven to be effective, and throwing out what it has not. Tibbles are data.frames that are lazy and surly: they do less and complain more forcing you to confront problems earlier, typically leading to cleaner, more expressive code. [Go to docs...](https://tibble.tidyverse.org/)

<figure class="small-centered">
  <img src="/img/icons/r-packages/thumbs/stringr.png" alt="stringr logo"/>
</figure>

### [stringr](https://stringr.tidyverse.org/) (strings)

`stringr` provides a cohesive set of functions designed to make working with strings as easy as possible. It is built on top of stringi, which uses the ICU C library to provide fast, correct implementations of common string manipulations. [Go to docs...](https://stringr.tidyverse.org/)

<figure class="small-centered">
  <img src="/img/icons/r-packages/thumbs/forcats.png" alt="forcats logo"/>
</figure>

### [forcats](https://forcats.tidyverse.org/) (factors)

`forcats` provides a suite of useful tools that solve common problems with factors. R uses factors to handle categorical variables, variables that have a fixed and known set of possible values. [Go to docs...](https://forcats.tidyverse.org/)

## Tidyverse essentials

If you get to know the basics of `ggplot`, `dplyr`, `tidyr` and `readr` you will be well-equiped to approach and tackle most data analysis tasks. Once you become a more advanced user and start to feel that you lack in functionality, the other tidyverse packages will be rather easy to learn swiftly.