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
## Group Activity - 15-20 minutes

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
* +1 for things they agree with
* Then instructors go through each section and discuss as a group.

Discussion Time: 20 minutes
Discussion topics:

1. **Syntax**
2. **Modularity** can the function work in various scenarios?
3. **Documentation**
4. **Expressiveness**

* Link to the course materials & other resources
* Identify a style guide that we wish to use (link to style.tidyverse.org)

# Lesson 02 - Summarize Data

**TIME:** 15 minutes

Explore your data

* What's the length of record for each STATION_NAME  calculate the total number of days?

* Write out what you want to do in ENGLISH
  * we then get their feedback and write it on the board in steps
* Then convert to code
  * convert each step above to a line of Code
  * Introduce pipes

* group_by
* summarise()

group by station_NAME, Calculate difference...
output: data.frame

## A Bigger Picture - Structuring Clean Code

Use the "messy code" to begin to organize and develop an approach via pseudo code.

Concepts to Introduce:

* What is pseudo code and why is it valuable?
* What is tidyverse - emphasis on `data.frames`
* How do you translate pseudo code to code

## A Process for Organizing Your Code

* Write out the steps together as a group required to get to the end goal.
* * translate them to R Syntax
* Use pipes and tidyverse to minimize outputs of individual steps & for Expressiveness

#### Code Steps

Some kind of conceptual drawing... or diagram that breaks this down ??
I need to review what the code actually does but something like:


**OYO**

Create a plot of precipitation by month

(show that they can pipe to ggplot)

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

<<END LESSON 2 >>

# Lesson 3 - Loops

## About Loops

## How to loop through files

Ultimate goal: plot by month and site
First step: get all of the files into one data.frame for easy manipulation

Ask the group: how would you do it?

* Open the .csv that has all paths to amazon S3 where data are stored
* loop through each path... print the path name

Build the loop..

Now - build the loop but instead of printing the path, create a list of data.frames:

1. Loop through using `seq_along()` and create a list of data.frames
2. `bind_rows` to bind together the entire list into 1 df


### ON YOUR OWN --

Finally - use a pipe to summarize the data in your data.frame total precipitation by month.

1. you may want to explore the data before summarizing it. Here are some questions to explore
  * How many unique sites are included in the data.
  * What is the **str**ucture of the columns in the data?
2. Create a pipe that summarizes the data by month and site


### ON YOUR OWN --

Summarize by STATION_NAME, month AND precip
HINTS to help

* toupper and tolower for tex manipulation
* group_by() - you can group by **several** columns


# BONUS FUN TIMES WITH GGPLOT


## Future

* let them create a list of issues. (are we still having them create issues?) this could confound things...
