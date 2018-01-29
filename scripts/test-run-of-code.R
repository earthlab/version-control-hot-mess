library(readr)
library(lubridate)
library(dplyr)
library(ggplot2)
options(stringsAsFactors = FALSE)


all_paths <- read_csv("data/data_urls.csv")
all_paths

# grab a url
first_csv <- all_paths$url[1]

year_one <- read_csv(first_csv)
year_one

# notice that HPCP is read as a character column: why?
unique(year_one$HPCP)

na_vals <- c("999.99", "missing")

# fix missing data values and try again
year_one <- read_csv(first_csv, na = na_vals)

year_one
unique(year_one$HPCP)

# summarize the data
year_one %>% 
  mutate(month = month(DATE)) %>% 
  group_by(month) %>% 
  summarise(avg_precip = mean(HPCP)) %>%
  ggplot(aes(x = month, y = avg_precip)) +
  geom_point()

# notice that we need na.rm = TRUE if we want to ignore missing data when 
# calculating means
# why does this work above given na.rm = TRUE is removeD??

# next let's try to work with all of the data
# you will use loops to do this
for (path in all_paths) {
  print(path)
}

for (i in 1:nrow(all_paths)) {
  print(i)
  print(all_paths$url[i])
}



# Naive reading of each file with known na values -------------------------
# create an empy list and read in data for each file
all_data_list <- list()
for (i in (1:nrow(all_paths))) {
  all_data_list[[i]] <- read_csv(all_paths$url[[i]], 
                                 na = na_vals)
}

# merge all of these data frames into one by binding row-wise
all_years_data <- bind_rows(all_data_list)
# returns an error: HPCP is sometimes a number, sometimes a character
#  because we missed some NA string values


# next let's look at all of the data to determine what is going on with NA values.
# we won't specify any NA values so we can determine the complete list of possible NA values
# Force HPCP to be read as a character ------------------------------------
all_data_list <- list()
for (i in (1:nrow(all_paths))) {
  all_data_list[[i]] <- read_csv(all_paths$url[[i]], 
                                 col_types = cols(HPCP = 'c'))
}

all_years_data <- bind_rows(all_data_list)

unique(all_years_data$HPCP)

# notice some new types of NA values: we need to update na_vals
na_vals <- c("999.99", "missing", "n/a", "")


# Reading with all known NA values ----------------------------------------
all_data_list <- list()
for (i in (1:nrow(all_paths))) {
  all_data_list[[i]] <- read_csv(all_paths$url[[i]], 
                                 na = na_vals)
}

all_years_data <- bind_rows(all_data_list)

# verify that HPCP is a number
str(all_years_data)



# Compute and plot monthly totals ------------------------------------------
# first, we need to create a "month" column in the data
all_years_data <- all_years_data %>%
  mutate(month = month(DATE))

# across all stations
all_years_data %>% 
  group_by(month) %>% 
  summarise(total_precip = sum(HPCP, na.rm = TRUE)) %>% 
  ggplot(aes(x = month, y = total_precip)) +
  geom_point()

# for each month-station combination
all_years_data %>% 
  group_by(month, STATION_NAME) %>% 
  summarise(total_precip = sum(HPCP, na.rm = TRUE)) %>% 
  ggplot(aes(x = month, y = total_precip)) +
  geom_bar(stat = "identity") + 
  facet_wrap(~STATION_NAME)

# oh for peats sake...
unique(all_years_data$STATION_NAME)

unique(tolower(all_years_data$STATION_NAME))


# fix stuff using mutate
all_years_data <- all_years_data %>% 
  mutate(station_name = tolower(all_years_data$STATION_NAME))

all_years_data %>% 
  group_by(month, station_name) %>% 
  summarise(total_precip = sum(HPCP, na.rm = TRUE)) %>% 
  ggplot(aes(x = month, y = total_precip)) +
  geom_point() + 
  facet_wrap(~station_name, ncol = 2)




# Challenges --------------------------------------------------------------
# designed to give them practice with functions we went over, and encourage
# then to seek help for new functions (filter, count)

# 1. Using year(), mutate(), group_by(), and summarize(), evaluate whether 
# the annual variability in precipitation has increased or decreased at each
# of the three stations and make a figure that supports your conclusion

# 2. Using filter() and ggplot(aes(..., color = ...)) + ...
# create a scatterplot of HPCP over time, with color indicating the station,
# excluding any observations with any non-NA measurement or quality flag

# 3. Using count(), find out how many observations (rows) we have for each 
# station. Does one station have more observations than another?

# 4. Make the plot of monthly means at each station publication ready. You can
# add axis labels, change the theme, display pretty axis labels (e.g., Jan 
# instead of 1.0 for month), and anything else you might think of, then save
# the plot as a pdf file. 

