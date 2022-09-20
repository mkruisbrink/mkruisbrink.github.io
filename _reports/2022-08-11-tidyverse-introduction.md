## What is the tidyverse?

The tidyverse is a package in R that is - in itself - a collection of
individual R packages that all work closely together in the same way
(they speak thesame kind of language, if you will). Data import &
export, manipulation, exploration and visualization becomes simpler and
more elegant by using new and additional syntax which is more intuitive
to and readable for us humans.

> The tidyverse is an opinionated **[collection of R
> packages](https://www.tidyverse.org/packages)** designed for data
> science. All packages share an underlying design philosophy, grammar,
> and data structures. **www.tidyverse.org**

The tidyverse is a toolkit of functionality that is perfect for data
scientists. Working with the tidyverse makes your code more intuitive
and easy to read and understand. The tidyverse offers a more elegant way
to approach the most common data science problems and is widely used
today.

<img src="/img/icons/r-packages/thumbs/tidyverse.png" title="tidyverse logo" alt="tidyverse logo" width="50%" style="display: block; margin: auto;" />

You can install the tidyverse via **`install.packages("tidyverse")`**
and you only have to install it once. Check the prompt for the resulting
output.

``` r
# installs the tidyverse
#install.packages("tidyverse")

# loads the tidyverse
library(tidyverse)
```

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.2 --
    ## v ggplot2 3.3.6     v purrr   0.3.4
    ## v tibble  3.1.8     v dplyr   1.0.9
    ## v tidyr   1.2.0     v stringr 1.4.0
    ## v readr   2.1.2     v forcats 0.5.1
    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

## Contents of the tidyverse

We’re going to briefly discuss the core contents of the tidyverse, what
you might use these packages for and I’ll provide links to the
respective documentation as well.

> You will definitely not need to know and understand all of these
> packages, but I am sure that you will love using the functionality
> that these packages provide.

The core tidyverse includes the packages that you’re likely to use in
everyday data analyses. As of tidyverse 1.3.0, the following packages
are included in the core tidyverse:

<img src="/img/icons/r-packages/thumbs/ggplot2.png" title="ggplot2 logo" alt="ggplot2 logo" width="50%" style="display: block; margin: auto;" />

### [ggplot2](https://ggplot2.tidyverse.org/) (visualization)

`ggplot2` is a system to create beautiful graphics, based on what they
call ***the grammar of graphics***. You provide the data, tell ggplot2
how to map variables to aesthetics, what kind of geometry to use (lines,
points, bars etc.), and it takes care of the details. [Go to
docs…](https://ggplot2.tidyverse.org/)

<img src="/img/icons/r-packages/thumbs/dplyr.png" title="ggplot2 logo" alt="ggplot2 logo" width="50%" style="display: block; margin: auto;" />

### [dplyr](https://dplyr.tidyverse.org/) (wrangling)

`dplyr` provides a grammar of data manipulation, providing a consistent
set of verbs that solve the most common data manipulation challenges.
[Go to docs…](https://dplyr.tidyverse.org/)

<img src="/img/icons/r-packages/thumbs/tidyr.png" title="tidyr logo" alt="tidyr logo" width="50%" style="display: block; margin: auto;" />

### [tidyr](https://tidyr.tidyverse.org/) (tidying)

`tidyr` provides a set of functions that help you get to tidy data. Tidy
data is data with a consistent form: in brief, every variable goes in a
column, and every column is a variable. [Go to
docs…](https://tidyr.tidyverse.org/)

<img src="/img/icons/r-packages/thumbs/readr.png" title="readr logo" alt="readr logo" width="50%" style="display: block; margin: auto;" />

### [readr](https://readr.tidyverse.org/) (read & import)

`readr` provides a fast and friendly way to read rectangular data (like
csv, tsv, and fwf). It is designed to flexibly parse many types of data
found in the wild, while still cleanly failing when data unexpectedly
changes. [Go to docs…](https://readr.tidyverse.org/)

<img src="/img/icons/r-packages/thumbs/purrr.png" title="purrr logo" alt="purrr logo" width="50%" style="display: block; margin: auto;" />

### [purrr](https://purrr.tidyverse.org/) (mapping)

`purrr` enhances R’s functional programming (FP) toolkit by providing a
complete and consistent set of tools for working with functions and
vectors. Once you master the basic concepts, purrr allows you to replace
many for loops with code that is easier to write and more expressive.
[Go to docs…](https://purrr.tidyverse.org/)

<img src="/img/icons/r-packages/thumbs/tibble.png" title="tibble logo" alt="tibble logo" width="50%" style="display: block; margin: auto;" />

### [tibble](https://tibble.tidyverse.org/) (enhanced data frames)

`tibble` is a modern re-imagining of the data frame, keeping what time
has proven to be effective, and throwing out what it has not. Tibbles
are data.frames that are lazy and surly: they do less and complain more
forcing you to confront problems earlier, typically leading to cleaner,
more expressive code. [Go to docs…](https://tibble.tidyverse.org/)

<img src="/img/icons/r-packages/thumbs/stringr.png" title="stringr logo" alt="stringr logo" width="50%" style="display: block; margin: auto;" />

### [stringr](https://stringr.tidyverse.org/) (strings)

`stringr` provides a cohesive set of functions designed to make working
with strings as easy as possible. It is built on top of stringi, which
uses the ICU C library to provide fast, correct implementations of
common string manipulations. [Go to
docs…](https://stringr.tidyverse.org/)

<img src="/img/icons/r-packages/thumbs/forcats.png" title="forcats logo" alt="forcats logo" width="50%" style="display: block; margin: auto;" />

### [forcats](https://forcats.tidyverse.org/) (factors)

`forcats` provides a suite of useful tools that solve common problems
with factors. R uses factors to handle categorical variables, variables
that have a fixed and known set of possible values. [Go to
docs…](https://forcats.tidyverse.org/)

## Tidyverse essentials

If you get to know the basics of `ggplot`, `dplyr`, `tidyr` and `readr`
you will be well-equiped to approach and tackle most data analysis
tasks. Once you become a more advanced user and start to feel that you
lack in functionality, the other tidyverse packages will be rather easy
to learn swiftly.

## Wrap-up

All of these packages add-up in terms of functionality and are designed
and meant to be used together! I highly recommend to read/scan through
the documentation and make a bookmark in an R/tidyverse folder or
something similar. This way, you’ll be one click away from help in case
you get stuck while trying to get one or more of these functions to work
in your own projects.
