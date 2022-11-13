---
#layout: post
title: The basics of data visualisation
subtitle: The best part of any analysis is when you can dive in an visualise the data
excerpt: "How many cryptocurrency exchanges are there? Comparing transparant volumes for centralised and decentralized cryptocurrency exchanges."
header:
  overlay_image: /assets/images/midjourney-optimised/big-computer-screen-financial-dashoard-optimised.jpg
category: 
- Exploration
---
## The basics of data visualisation

We start with the fun part, visualizing data. This is considered to be
the biggest pay-off and provided me with loads of motivation to keep
learning more and more, and to be able to produce better looking graphs
as a result.

To start of, we’re going to need to load only the `tidyverse`.

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ## ✔ ggplot2 3.4.0      ✔ purrr   0.3.5 
    ## ✔ tibble  3.1.8      ✔ dplyr   1.0.10
    ## ✔ tidyr   1.2.1      ✔ stringr 1.4.1 
    ## ✔ readr   2.1.3      ✔ forcats 0.5.2 
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

Note that the tidyverse loads **eight** packages and lists their current
version number. If you don’t see the message above you have to install
the package first (`install.packages("tidyverse"`).

You also see conflicts: some functions are provided in two packages. You
could specify which exact function from a package you would like to use
by using `package::function()` like so `ggplot2::ggplot()`.

Now let’s load up a data set about fuel usage for different types of
cars (`mpg`) which comes with the `tidyverse`.

``` r
mpg
```

    ## # A tibble: 234 × 11
    ##    manufacturer model      displ  year   cyl trans drv     cty   hwy fl    class
    ##    <chr>        <chr>      <dbl> <int> <int> <chr> <chr> <int> <int> <chr> <chr>
    ##  1 audi         a4           1.8  1999     4 auto… f        18    29 p     comp…
    ##  2 audi         a4           1.8  1999     4 manu… f        21    29 p     comp…
    ##  3 audi         a4           2    2008     4 manu… f        20    31 p     comp…
    ##  4 audi         a4           2    2008     4 auto… f        21    30 p     comp…
    ##  5 audi         a4           2.8  1999     6 auto… f        16    26 p     comp…
    ##  6 audi         a4           2.8  1999     6 manu… f        18    26 p     comp…
    ##  7 audi         a4           3.1  2008     6 auto… f        18    27 p     comp…
    ##  8 audi         a4 quattro   1.8  1999     4 manu… 4        18    26 p     comp…
    ##  9 audi         a4 quattro   1.8  1999     4 auto… 4        16    25 p     comp…
    ## 10 audi         a4 quattro   2    2008     4 manu… 4        20    28 p     comp…
    ## # … with 224 more rows

The `mpg` data set has 11 columns containing variables and 234 rows
containing observations.

Now we create our first plot. Engine displacement (`displ`) versus
highway miles per gallon (`hwy`).

We can map aesthetics to variables via the `ggplot` package. You can do
this explicitly with base R.

``` r
# explicitly telling ggplot what to use
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
```

![](/assets/plots/displ-hwy-1.png)<!-- -->

The `class` variable of the `mpg` data set classifies cars into groups
such as compact, midsize, and SUV. If the outlying points are hybrids,
they should be classified as compact cars or, perhaps, subcompact cars
(keep in mind that this data was collected before hybrid trucks and SUVs
became popular).

You can also map the colors aesthetic to the `class` variable. Here we
will use the `tidyverse` way and make use of the pipe operator (`%>%`).
The pipe tells whatever is on the right side, to take everything on the
left side, and use it as input for the **first** argument on the right
side. Your code becomes shorter and more intuitive to read.

``` r
# using the pipe operator the tidyverse way
mpg %>%  # take mpg and use it for the first argument on the right side
  ggplot(., aes(displ, hwy, color = class)) +  
  geom_point()
```

![](/assets/plots/displ-hwy-color-class-1.png)<!-- -->

> The dot character in `ggplot(., aes(displ, hwy, color = class))`
> represents the location of the first argument and is where `mpg` gets
> piped into. You can omit this as it is **always** the first argument
> after a `%>%`.

## Mapping variables to aesthetics

Besides the X and Y axis there are several other **aesthethics** you can
map variables to.

- color
- shape
- alpha; transparency

We can also map the `class` to the shape aesthetic:

``` r
mpg %>% 
  ggplot(aes(displ, hwy, shape = class)) +
  geom_point()
```

    ## Warning: The shape palette can deal with a maximum of 6 discrete values because
    ## more than 6 becomes difficult to discriminate; you have 7. Consider
    ## specifying shapes manually if you must have them.

    ## Warning: Removed 62 rows containing missing values (`geom_point()`).

![](/assets/plots/displ-hwy-shape-class-1.png)<!-- -->

> Note the warning: shapes are more difficult to compare than colors.
> Unless explicitly specified, 6 shapes are included in the base plot.
> In this case we have 7 unique values for the `class` variable and the
> SUV class has no shape assigned.

For instance, if we mapp the `class` variable to the alpha aesthetic -
controlling the transparency of the points - the results are not as
clear.

``` r
mpg %>% 
  ggplot(aes(displ, hwy, alpha = class)) +
  geom_point()
```

    ## Warning: Using alpha for a discrete variable is not advised.

![](/assets/plots/displ-hwy-alpha-class-1.png)<!-- -->

The `class` variable is discrete and the alpha aesthetic is not best
suited to highlight this.

Color and shape are better suited to display categorical variables while
size and alpha are better used for continuous variables.

You can also manually set specific aesthetics for a geom. You do this
**inside** of the `geom_point()` function.

``` r
mpg %>% 
  ggplot(aes(displ, hwy, size = cyl)) +
  geom_point(color = "red")
```

![](/assets/plots/displ-hwy-size-cyl-color-red-1.png)<!-- -->

## Facets

When dealing with categorical variables, *facets* are quite useful and
display their own subset of data. You can use `facet_wrap()` to facet
your plot with a single variable. The first argument that goes into
`facet_wrap()` is a discrete variable and is prefixed with the `~`
character.

``` r
mpg %>% 
  ggplot(aes(displ, hwy)) +  # plot displacement versus highway miles per gallon
  geom_point() +  # add point geometry
  facet_wrap(~ class, nrow = 2)  # facet by class and use only 2 rows for the data
```

![](/assets/plots/displ-hwy-facet-wrap-1.png)<!-- -->

If you want to plot against two discrete variables, you can use
`facet_grid()`. You use two variable names, separated by a `~`.

``` r
mpg %>% 
  ggplot(aes(displ, hwy)) +  # plot displacement versus highway miles per gallon
  geom_point() +  # add point geometry
  facet_grid(drv ~ cyl)  # facet by drive and cylinders on x and y axes
```

![](/assets/plots/displ-hwy-facet-grid-1.png)<!-- -->

## Geometric objects

Up untill now we have only used the `geom_point()` geom to plot and show
data. There are other options that you can use. Instead of
`geom_point()` you might use `geom_smooth()`, which creates a smoothed
line chart.

``` r
mpg %>% 
  ggplot(aes(displ, hwy)) +
  geom_smooth()
```

![](/assets/plots/displ-hwy-geom-smooth-1.png)<!-- -->

Both visualizations represent the same variables on the x and y axis and
are based on the same dataset. With `ggplot()`, you can use different
**geoms** to visualize your data. Every geom object takes a `mapping`
argument but not every aesthetic will work with every geom. You may
decide the shape of a point by using `geom_point(shape = 5)` but you
can’t set the shape of a line like that.

However, instead of using the shape aesthetic, you can use the
*linetype* aesthetic to draw a different line for the unique variable
that you map to linetype.

``` r
mpg %>% 
  ggplot(aes(displ, hwy)) + 
  geom_smooth(aes(linetype = drv))
```

![](/assets/plots/displ-hwy-linetype-1.png)<!-- -->

In this plot we see the lines associated with their `drv` values, which
stands for a car’s drivetrain (the group of components that deliver
mechanical power from the prime mover to the driven components). We see
a line for 4-wheel drive, front-wheel drive and rear-wheel drive.

But where are the original points? To make it more clear, you can simply
add the points by adding another geom. Everything you define in the
first `aes()` function inside `ggplot()` is applied on **all** geoms. In
the case below we color both the line and the points by their `drv`
value and we define specific linetypes for the `geom_smooth()`
component.

``` r
mpg %>% 
  ggplot(aes(displ, hwy, color = drv)) + 
  geom_smooth(aes(linetype = drv)) +
  geom_point()
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](/assets/plots/displ-hwy-more-geoms-1.png)<!-- -->

You can add multiple geoms to a plot to make absolutely insane graphs.
There are over 40 geoms in ggplot2 and if you use [additional extensions
to the
tidyverse](https://exts.ggplot2.tidyverse.org/gallery/){:target=“\_blank”}
you get even more. Take a look at the [ggplot2
cheatsheet](https://r4ds.had.co.nz/data-visualisation.html#geometric-objects){:target=“\_blank”}
and if you want to learn more about a specific geom, use `?geom_smooth`.

Unlike `geom_point()`, which maps an observation (a single row of data)
to a single point, geoms such as `geom_smooth()` map a whole set of
observations (multiple rows of data) to a single object (a line chart).

``` r
# mapping a variable to a group doesn't add any aesthetic properties like color or size to the plot
mpg %>% 
  ggplot() +
  geom_smooth(aes(displ, hwy, group = drv))
```

![](/assets/plots/displ-hwy-group-drv-1.png)<!-- -->

``` r
# mapping a variable to an aesthetic like color obviously does
mpg %>% 
  ggplot() +
  geom_smooth(aes(displ, hwy, color = drv),
              show.legend = FALSE
  )
```

![](/assets/plots/displ-hwy-color-drv-1.png)<!-- -->

### Multiple geoms

Simply add more geoms to the plot when you want to add more geometric
elements. You may choose to map your variables inside the different
geoms or in `ggplot2`. You may see some duplicate code if you decide to
map inside the geom functions.

``` r
# duplicate mapping
mpg %>% 
  ggplot() +
  geom_point(aes(displ, hwy)) +
  geom_smooth(aes(displ, hwy))
```

These mappings are overruled if you explicitly specify another mapping
inside the geom functions. Mapping variables to aesthetics inside the
`ggplot()` function are seen as **global** mappings and apply to all
geoms.

``` r
mpg %>% 
  ggplot(aes(displ, hwy)) +  # global mappings
  geom_point() +  # empty mapping
  geom_smooth()   # empty mapping
```

![](/assets/plots/more-geoms-2-1.png)<!-- -->

You can add a specific mapping to a single geom only. In this case we
map color to the `class` variable.

``` r
# adding color mapping to geom_point only
mpg %>%
  ggplot(aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth()
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](/assets/plots/unnamed-chunk-3-1.png)<!-- -->

## Statistical transformations

> Coming soon

## Position adjustments

> Coming soon

## Coordinate systems

> Coming soon

## The layered grammar of graphics

> Coming soon
