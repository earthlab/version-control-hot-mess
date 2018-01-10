library(readr)
library(lubridate)
library(dplyr)
library(ggplot2)
options(stringsAsFactors = FALSE)



# readr does weird things
all_paths <- read_csv("data/data_urls.csv")
class(all_paths)
all_paths[1,1]
str(all_paths)
# grab a url
first_csv <- all_paths$url[1]

year_one <- read_csv(first_csv)
str(year_one)

# summarize the data
year_one %>% 
  mutate(month = month(DATE)) %>% 
  group_by(month) %>% 
  summarise(avg_precip = mean(HPCP)) %>%
  ggplot(aes(x = month, y = avg_precip)) +
  geom_point()

# the above code doesn't work. why?
str(year_one$HPCP)
unique(year_one$HPCP)

# fix missing data values and try again
year_one <- read_csv(first_csv,
                     na = c("999.99", "missing"))

str(year_one$HPCP)
unique(year_one$HPCP)

# summarize the data
year_one %>% 
  mutate(month = month(DATE)) %>% 
  group_by(month) %>% 
  summarise(avg_precip = mean(HPCP, na.rm = TRUE)) %>% 
  ggplot(aes(x = month, y = avg_precip)) +
  geom_point()

# next let's try to work with all of the data
for (path in all_paths) {
  print(path)
}

for (i in (1:nrow(all_paths))) {
  print(i)
  print(all_paths$url[[i]])
}


# prepopulate a list
all_data_list <- list()

for (i in (1:nrow(all_paths))) {
  a_year_of_data <- read_csv(all_paths$url[[i]],
                       na = c("999.99", "missing"))
  
# summarize the data & assign it to the list
# note this is actually a bit slow
  all_data_list[[i]] <-  a_year_of_data %>% 
    mutate(month = month(DATE)) %>% 
    group_by(month) %>% 
    summarise(avg_precip = mean(HPCP, na.rm = TRUE))
}

all_years_data <- bind_rows(all_data_list)

# the above works but it looks like we get some na values in the data
# we may need another approach
# one option could be to develop a function that parses out all unique HPCP values
# another is to adjust our code - bring in all of the data and 
# create a giant data frame. then deal with na values 

# force everything to a char to see missing values (safer as a first go)
# prepopulate a list
all_data_list <- list()

for (i in (1:nrow(all_paths))) {
  a_year_of_data <- read_csv(all_paths$url[[i]])
  
  # summarize the data & assign it to the list
  # note this is actually a bit slow
  all_data_list[[i]] <-  a_year_of_data %>% 
    mutate(month = month(DATE),
           HPCP = as.character(HPCP))
}

all_years_data <- bind_rows(all_data_list)
# view all unique instances of the data 
unique(all_years_data$HPCP)

# prepopulate a list
all_data_list <- list()

for (i in (1:nrow(all_paths))) {
  a_year_of_data <- read_csv(all_paths$url[[i]])
  
  # summarize the data & assign it to the list
  # note this is actually a bit slow
  all_data_list[[i]] <-  a_year_of_data %>% 
    mutate(month = month(DATE),
           HPCP = parse_number(HPCP))
}

all_years_data <- bind_rows(all_data_list)



unique(all_years_data$HPCP)

# now that you can see all of the possible NA values you can do this right

for (i in (1:nrow(all_paths))) {
  a_year_of_data <- read_csv(all_paths$url[[i]],
                             na = c("999.99", "n/a", "missing"))
  
  # summarize the data & assign it to the list
  # note this is actually a bit slow
  all_data_list[[i]] <-  a_year_of_data %>% 
    mutate(month = month(DATE),
           HPCP = parse_number(HPCP))
}

all_years_data <- bind_rows(all_data_list)
all_years_data$HPCP

all_years_data %>% 
  group_by(month) %>% 
  summarise(total_precip = sum(HPCP, na.rm = TRUE)) %>% 
  ggplot(aes(x = month, y = total_precip)) +
  geom_bar(stat = "identity")

# Rut Ro
all_years_data %>% 
  group_by(month, STATION_NAME) %>% 
  summarise(total_precip = sum(HPCP, na.rm = TRUE)) %>% 
  ggplot(aes(x = month, y = total_precip)) +
  geom_bar(stat = "identity") + 
  facet_wrap(~STATION_NAME)

# oh for peats sake...
unique(all_years_data$STATION_NAME)

unique(toupper(all_years_data$STATION_NAME))


# fix stuff using mutate
all_years_data %>% 
  mutate(STATION_NAME = toupper(all_years_data$STATION_NAME)) %>% 
  group_by(month, STATION_NAME) %>% 
  summarise(total_precip = sum(HPCP, na.rm = TRUE)) %>% 
  ggplot(aes(x = month, y = total_precip)) +
  geom_bar(stat = "identity") + 
  facet_wrap(~STATION_NAME, ncol = 2)


## challenges

# create a set of plots by year for each site using a loop 
# fix stuff using mutate
all_sites <- unique(toupper(all_years_data$STATION_NAME))
for (a_site in all_sites){
  print(a_site)
}

all_years_data <- all_years_data %>% 
  mutate(STATION_NAME = toupper(all_years_data$STATION_NAME),
         the_year = year(DATE))

# this is weird. it's not actually printing 3 plots 
for (a_site in all_sites) {
  print(a_site)
site_plot <-   all_years_data %>% 
  filter(STATION_NAME == a_site) %>%  
  group_by(the_year, month, STATION_NAME) %>% 
  summarise(total_precip = sum(HPCP, na.rm = TRUE)) %>% 
  ggplot(aes(x = month, y = total_precip)) +
  geom_bar(stat = "identity") + 
  facet_wrap(~the_year, ncol = 2) +
    labs(title = a_site)

# apparently you have to print when ggplot is in a loop
print(site_plot)
}

# Compare just the precip in Febuary or maybe just a few months? for each site across all years

# other options?

# maybe an advanced option. really messed up data. mess up the date and have them fix it. i'd do something like use - and / in the dates. i'm not sure how readr will handle that.

# plot the data by month using a month name as the x axis label (this is tricky i did it a few times but always forget how to)
