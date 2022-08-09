---
#layout: post
title: Rstudio Introduction
subtitle: Getting started with R and RStudio
excerpt: "In this guide I'm going to show you how to get familiar with the very basics of RStudio itself as a complete beginner."
header:
  overlay_image: /img/posts/rstudio-introduction/R-project-demo-1.PNG
  overlay_filter: rgba(0, 0, 0, 0.8)
category: 
- Guides
tags:
- R
- Rstudio
---

## Introduction

In this guide I'm going to show you how to get familiar with the very basics of RStudio itself. We're going to cover:

* The prerequisits (what you need before you start)
* What is RStudio? (brief)
* The RStudio layout
* Using RStudio
* Usefull links to get started

## Prerequisites

You will need to have R and RStudio installed. You can follow [this guide for base R installation]({% post_url 2022-08-08-installing-base-R %}) and [this guide for the RStudio installation].

## What is RStudio?
RStudio is an open-source software project and computer program that allows you to interact with the R computing language that you've previously installed on your system. RStudio provides you with a Graphical User Interface (GUI) that serves as a *front-end* which literally lies on top of R. RStudio is thus an **IDE** specifically for R. 

The RStudio environment makes it easy for you to manage your projects and you will have everything that you need right at your fingertips. For instance, the GUI provides you with many of the well-known graphical elements such as navigation, menu items, preferences, file explorers etc. In RStudio, you will be able to easily manage your workflow in so-called R-projects (a collection of R files). 

>
For me it is most important that my work is reproducable. With R & RStudio I can easily refresh that specific script containing an important analysis and I'm able to run that **exact same** analysis whenever I want. I can even plan the running of a script via Windows Task Manager to run daily. Write once and maintain, profit forever.

RStudio can be learned by anyone. It's layout (default) is made up out of four different panels and rather intuitive. On the top left we have a source code editor packed with features (including syntax highlighting). On the top right we got the environment pane, which tells you what information you have currently stored in R in various objects. On the bottom left you will have the R console or terminal respectively. And on the bottom right you will find the explorer, help window, plot window and much more. Note that you can tweak your panel layout with ease.


## Layout

When you open up RStudio you immediately see four distinctive panes. All of which will be discussed here.

<figure class="centered">
    <a href="/img/posts/rstudio-introduction/R-project-demo-1.PNG" title="R Project Demo" alt="R Project Demo">
    <img src="/img/posts/rstudio-introduction/R-project-demo-1.PNG"></a>
</figure>

### Script Editor & Data Viewport

The top-left pane is where you will find the *Script Editor* and view your data(tables). The script editor is where you store your commands (code). These commands (the script) are provided to the R *Console* (bottom-left) as input. The *Script Editor* is an advanced text-editor which is designed for coding specifically. 

### Console & Terminal

The bottom-left pane is where you will find the R *Console*. The *Console* is a viewport into **R** itself. That is where R takes your input (the code) and performs it's magic. It is a live window to the R language. You can use the Console as a calculator or to run commands that you don't want to include in your script. You will also find the terminal window in this pane, which you can use for navigation and other tasks (learning to use terminal will make your life easier).

### Environment & History

The top-right pane is where you will find the R *Environment*. The *Environment* is where RStudio stores all the inputs as objects. This can be data tables, lists, numbers etc. You can double-click on many of these objects to view them in your *Script Editor* (usefull for tables and data frames). In the *History* tab you will find all of the input you have provided to the R *Console*. 

>
**Note:** You might also see *Connections*, *Git* and *Tutorial*, which are out of the scope of this introduction. Git is important but will be dealt with another time.

### Files, Plots, Packages, Help, Viewer & Presentation

The bottom-right pane is made up out of at least five tabs – Files, Plots, Packages, Help, and Viewer. 

1. The Files tab will show your current directory and allows you to quickly see your working files and folders. These are what make up your R project.
2. The Plots tab will show the plots (graphics) produced by commands (your scripts) submitted to the Console. 
3. The Packages tab will show all of the currently installed packages on your system for your current R installation.
4. The Help tab will show you usefull information regarding packages and functions (click anywhere on a function, i.e. `mutate()` and press `F1`).
5. Some more advanced tabs that are not required for this introcution:
    * The Viewer tab is used to display and output local web applications and content. If you are making an interactive application and you want to preview the results, this is where you would see your work.
    * The Presentation tab is used for the creation of slides and presentations that make use of R code and is mostly used in classrooms or teaching in academia.

>
*include RStudio Files, Plots, Packages, Help*

## Using RStudio

You will use RStudio by creating so-called scripts in the *Script Editor* pane. Scripts are text files that contain (R) code and you will submit your scripts to the *Console* for interpretation. R will then output graphical results to the *Plot* pane and textual or tabular content to the *Console*. If you specified in your R script to store data in variables, your data will be saved into objects in the *Environment* pane. 

### Creating your first R script

To create your first R script there are a few options:

1. You open a blank file for an R script by selecting *New File* ![New File](/img/icons/r-studio/new-file-rstudio.png) at the top-left and then selecting *R Script* ![R Script](/img/icons/r-studio/R-script-rstudio.png)
2. Select the *File* menu and click the *R Script* ![R Script](/img/icons/r-studio/R-script-rstudio.png) option.
3. Simply press `<CTRL> + <Shift> + N` to create a new R script. 

>
**Note:** Instead of a new R Script, create a new R *Project*. You can think of an R project as a collection of files stored in a folder/directory that are all related. Information about the project is stored in a special R.proj file. When you open your Project, R starts in the correct folder from the start and you have everything you need in one place. 

### Creating your first R Project

My advice is to create a new R *Project* to experiment and tryout new things as you learn about R. You will have all your *experiments* (scripts) in one place and you are implementing best-practices right from the start by working with R Projects. So let's create that new Project. Simply follow the steps after clicking on the *File* menu and selecting the *New Project...* option.

<figure class="centered">
    <a href="/img/posts/rstudio-introduction/R-project-1.PNG" title="R Project" alt="R Project">
    <img src="/img/posts/rstudio-introduction/R-project-1.PNG"></a>
</figure>

* If you already have a folder with some R scripts you can associate your Project with this directory. Select **Existing Directory** and provide the location of your folder containing R Scripts.

<figure class="centered">
    <a href="/img/posts/rstudio-introduction/R-project-5-existing-directory.PNG" title="R Project Existing Directory" alt="R Project Existing Directory">
    <img src="/img/posts/rstudio-introduction/R-project-5-existing-directory.PNG"></a>
</figure>

* Otherwise, select **New Directory**, click on **New Project** and in the next window provide both the name and location of your new directory as seen in below screenshots. You can uncheck the checkboxes for `git` and `renv` for this introduction. Check **Open in a new session** and click **Create Project**. 


<figure class="half">
    <a href="/img/posts/rstudio-introduction/R-project-2.PNG"><img src="/img/posts/rstudio-introduction/R-project-2.PNG"></a>
    <a href="/img/posts/rstudio-introduction/R-project-3.PNG"><img src="/img/posts/rstudio-introduction/R-project-3.PNG"></a>
</figure>

* Cool! Now you have created your first R *Project*! You'll see the `R.proj` file in the *File* tab on the bottom right.

<figure class="centered">
    <a href="/img/posts/rstudio-introduction/R-project-4.PNG" title="New R Project" alt="New R Project">
    <img src="/img/posts/rstudio-introduction/R-project-4.PNG"></a>
</figure>

Remember how to create your first script? Go ahead and do just that.

### Save your Scripts!

I usually create a script and immediately save it afterwards with the *Save* ![Save](/img/icons/r-studio/save-rstudio.png) command or `<CTRL> + <S>` hotkeys. This might sound obvious but when you're working in a new script it will be an *untitled.R* script and your work is **not** saved before you name and store the R script.

### Installing R Packages

We're going to install and load a package called the *Tidyverse*. This package provides a whole lot of additional functionalities that you are going to use *a lot*. In your new R script, type:

```R
install.package("tidyverse") #installs the package
library("tidyverse") #loads the package
```

* All text behind a '#' character is considered to be a comment and **will not** be interpreted by R. I advise you to make use of comments from the start. It will help you understand earlier decisions.
* To run these lines of code you can use the *Run* ![Run](/img/icons/r-studio/run-script-rstudio.png) command (`<CTRL> + <Enter>`). This will run the current line or selection.
* If you want to run the entire script, select everything with `<CTRL> + <A>` and then press either `<CTRL> + <Enter>` or click the *Run* ![Run](/img/icons/r-studio/run-script-rstudio.png) command after you made the selection.

You'll see the package being installed via the R *Console* (you only have to install a package once!). You can also provide the `install.package()` function straight to your *Console* pane (this keeps your script lean).

### Loading data into RStudio

Now we're going to load some data. R comes prepacked with a bunch of dataframes that you can check out using the `data()` function. 

```R
#checkout available datasets
data() # and press <CTRL> + <Enter>!
```

I dont want to use these though and because I like Star Wars I'm going to use another dataset that is provided by a package that comes with the *Tidyverse* that we just installed. 

```R
#starwars dataset
starwars # and press <CTRL> + <Enter>!
```
You will see the dataset in your R *Console*. 

### Saving data in R objects in RStudio

Now, in order to work with the data and to manipulate or change the data, we need to store it in an object. To store something in R you can use the assignment operator (`<-` with shortcut `<ALT> + <->` or `=` with shortcut `<ALT> + <+>`). Let's assign the `starwars` dataframe to an R object.

```R
#starwars dataset
starwars # and press <CTRL> + <Enter>!

starwars_df <- starwars 
```
Your RStudio window should look something like this:

<figure class="centered">
    <a href="/img/posts/rstudio-introduction/R-project-demo.PNG" title="R Project Demo" alt="R Project Demo">
    <img src="/img/posts/rstudio-introduction/R-project-demo.PNG"></a>
</figure>

### Visualizing data in RStudio

Let's make a simple plot from data obtained from the `starwars` data set. For this, we're going to use a function called `ggplot()`. In this little section of code we're using a few functionalities from the `tidyverse` package. For the sake of the introduction I will not elaborate on these here.

```R
# create a plot using our new R object
starwars %>% ggplot(aes(species, fill = gender)) +
  geom_bar() + 
  coord_flip()
```

1. We're taking the `starwars` object that we saved
2. We're piping it (via the pipe operator `%>%`) to the `ggplot()` function
3. In the `ggplot()` function we're stating that we want to visualize the species on the x-axis, and fill (colour) by gender
4. Since there's a lot of species and they don't all fit on the horizontal x-axis, we're swapping the axes.

The result looks like this:

<figure class="centered">
    <a href="/img/posts/rstudio-introduction/R-project-demo-1.PNG" title="R Project Demo" alt="R Project Demo">
    <img src="/img/posts/rstudio-introduction/R-project-demo-1.PNG"></a>
</figure>

As you can see, with just a few lines of code we were able to create a rather goodlooking graphic (but we barely scratched the surface). At this point you can import data into RStudio and play around with it. 

Goodluck and have fun learning R and RStudio!

## Usefull Links

1. [Rstudio Cheatsheets](https://www.rstudio.com/resources/cheatsheets/)
2. [HarvardX Data Science Course](https://www.edx.org/professional-certificate/harvardx-data-science)


