# data-scrambler

This is the repo where we store data and code for the git / documentation training.

## Workshop Outline

This workshop will get students to think about best practices when coding including:

### DRY / Modularity

### Expressiveness

### Style Guides

### Documentation

****
# Setup

* Suggest they setup git -- link to instructions
* if not, download the repo as a zip file and save it somewhere
* instructions to create an `R project` using git repo

# Lesson 01
## Part 1 - 40 minutes?

### A. Mini lecture on the four components of clean coding

1. **Syntax**
2. **Modularity** can the function work in various scenarios?
3. **Documentation**
4. **Expressiveness**

* Link to the course materials too in suggested reading
* Link to anything else that Max thinks we should!

# Lesson 02 - Group Activity

## Small group activity. 15 mins

1. **Print out a copy of the code** (or post it on the website) for students to explore
2. Students break out into groups of 2-3 and identify problems they see in the code.
3. In order to complete this we will need to have a quick review of the 4 aspects of good coding that we are focused on in the workshop.
3. Problems should fall into the following areas:
  * Syntax: Consistency of how the code is written. Following a style guide. Spacing, etc...
  * Modularity: is code repeated over and over. could it be written in a more modular way
  * Documentation (readme, comments, etc)
  * Expressiveness (naming of variables and functions in a way that relates to the task or content that the object contains)

Students work on their own for about 15  minutes. then we regroup and together
on the white board fill out the things students found could be improved with the code.

### Activity Approach

* Have them enter this in a google doc.
* Then instructors go through each section and discuss as a group.

Discussion Time: 5-10 minutes

# Lesson 03 - An Approach to Structuring Clean Code

Concepts to Introduce:

* What is pseudo code and why is it valuable?
* What is tidyverse - emphasis on data.frames
* How do you translate pseudo code to code

## A Process for Organizing Your Code

* Write out the steps together as a group required to get to the end goal.
* Identify the tasks that are repeated.
* Identify a style guide that we wish to use (link to style.tidyverse.org) / discuss contributing files in git repos if they are working with others...

#### Code Steps

I need to review what the code actually does but something like:

* open file
* Add month column
* group by month
* calculate mean (or some summary stat)

plot??

Instructors help students translate each step into a usable `R` function with a focus on `tidyverse`

* readr::read_csv
* mutate(month = lubridate::month())
* group_by(month)
* summarise()  (na.rm = TRUE)

* everything is a `dataframe` & want to get a data frame back...
* df as the VIP!

Quick win!!  or not....

### Why doesn't mean() work?

* data exploration 101
* str()
* unique()
* add na = c() to read_csv() : add argument to read_csv to correctly identify na values and it will import as numeric

plot x by month ...

## ISSUES with the data

* cleanup NA values
* mutate to add a column

<<END LESSON 3 >>

# Lesson 4 - Loops

## About Loops

## How to loop through files

Goal is plot by month and site

* Open the .csv that has all paths to amazon S3 where data are stored
* loop through each path... print the path name

Build the loop..

Now - build the loop but instead of printing the path, create a list of data.frames:

1. Loop through using `seq_along()` and create a list of dataframes
2. `bind_rows` to bind together the entire list into 1 df


### ON YOUR OWN --

Finally - use a pipe to summarize the data in your data.frame.
HINT

1. you may want to explore the data before summarizing it. Here are some questions to explore
  * How many unique sites are included in the data.
  * What is the **str**ucture of the columns in the data?
2. Create a pipe that summarizes the data by month and site

HINTS to help

* toupper and tolower for tex manipulation
* group_by() - you can group by several columns

## Plot by SITE and MONTH



### Part 5 plot

Could be example lesson with some simple examples


## Future

* let them create a list of issues. (are we still having them create issues?) this could confound things...
