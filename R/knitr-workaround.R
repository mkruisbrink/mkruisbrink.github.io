# load knitr
library(knitr)

# navigate to directory of caRds.Rmd
getwd()

setwd("_reports/")

# knit
knit("2022-08-11-tidyverse-introduction.Rmd")

# define paths
base.dir <- "~/Developer/mkruisbrink.github.io/"
base.url <- "/"
fig.path <- "_reports/figure/"

# this is where figures will be sent
paste0(base.dir, fig.path)

# this is where markdown will point for figures
paste0(base.url, fig.path)

# set knitr parameters
opts_knit$set(base.dir = base.dir, base.url = base.url)
opts_chunk$set(fig.path = fig.path) 

# change directory
setwd("~/Developer/mkruisbrink.github.io/_reports/")

# knit
knit("2022-08-11-tidyverse-introduction.Rmd")
