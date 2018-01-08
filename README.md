# data-scrambler

This is the repo where we store data and code for the git / documentation training.

## Workshop Outline

This workshop will get students to think about best practices when coding including:

### DRY / Modularity

### Expressiveness

### Style Guides

### Documentation

****

# Lesson 01
## Part 1 - 40 minutes?

### A. Mini lecture on the four components of clean coding

1. **Syntax**
2. **Modularity** can the function work in various scenarios?
3. **Documentation**
4. **Expressiveness**

### B. Small group activity. 15 mins

1. Print out a copy of the code (or post it on the website) for students to explore
2. Students break out into groups of 2-3 and identify problems they see in the code.
3. In order to complete this we will need to have a quick review of the 4 aspects of good coding that we are focused on in the workshop.
3. Problems should fall into the following areas:
  * Syntax: Consistency of how the code is written. Following a style guide. Spacing, etc...
  * Modularity: is code repeated over and over. could it be written in a more modular way
  * Documentation (readme, comments, etc)
  * Expressiveness (naming of variables and functions in a way that relates to the task or content that the object contains)

Students work on their own for about 15  minutes. then we regroup and together
on the white board fill out the things students found could be improved with the code.

We could have them add to the list on the white board?
We could also do this in a google doc if we wanted so everyone could participate?

#### C. Review all issues generally.

Cap timing at about 5-10 minutes


## PART A: TASK
* Create 1 lesson on the 4 areas discussed.
* Link to the course materials too in suggested reading

### TO DOs:
Point them to the code on github.
* let them create a list of issues. (are we still having them create issues?) this could confound things...
* Make sure code captures all of the stuff we want to call attention to.

# Lesson 02
## Part 2 -

### A Process for Organizing Your Code

Introduce the concept of pseudo code.
Introduce the concept of functions
Introduce the tidyverse

* Write out the steps together as a group required to get to the end goal.
* Identify the tasks that are repeated.
* Identify a style guide that we wish to use (link to style.tidyverse.org) / discuss contributing files in git repos if they are working with others...
*

#### Code Steps

I need to review what the code actually does but something like:

* define file path
* open file <-
* clean up column x
* group
* summary stat

Instructors help students translate each step into a usable `R` function with a focus on `tidyverse`

* readr::read_csv
* mutate()
* group_by()
* summarise()


* everything is a `dataframe` & want to get a data frame back...
* df as the VIP!

### TO DOs:

* add a second site, create fake data around that site. this will allow us to explore the data and see "how many sites" and realize the text cleaning issues in the file
* create overview page on these functions only <- refer to R for Data Science lessons...

###  OYO Part 3 -- Process a few more files 10 minutes

Ask them to process a few more files
Give them questions -- to discuss as a group
1. what problems do they encounter? (na's)
2. Is there a more efficient way

# Lesson 03
## Part 4 Iteration

* How do you read in a list of files
* bind_rows them together into a single dataframe (map)
* split() out 2 csvs (one for each site?)

* provide list of file names in csv format

#### OYO

Add group and summarize the data before outputting the


To dos:
* Provide example of for loop on the website as a "you could do this but"
* Teach the map / (lapply alternative) way to

## Summary

* looking at the code ... have we achieved our goals?

****
maybe a plotting example but don't teach this
### Part 5 plot

COuld be example lesson with some simple examples
