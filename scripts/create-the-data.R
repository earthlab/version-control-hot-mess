library(ggplot2)
library(lubridate)
library(dplyr)

# cause we love absolute paths that are for other people's computers a lot
setwd("~/Documents/github/1_teaching_repos/version-control-hot-mess")

options(stringsAsFactors = FALSE)

# check for output dir
check_create_dir <- function(a_dir_path){
  # This function checks to see if a dir exists and if it doesnt it makes it
  if (!dir.exists(a_dir_path)) {
    dir.create(a_dir_path, recursive = TRUE)
  }
}

# load the data
boulder_precip <- read.csv("https://ndownloader.figshare.com/files/7270970")

# fix the date
boulder_precip <- boulder_precip %>%
  mutate(DATE = as.POSIXct(DATE, format = "%Y%m%d %H:%M"))

### my code below works to make the files but above is more special
min_yr <- min(year(boulder_precip$DATE))
max_yr <- max(year(boulder_precip$DATE))

#this does stuff
check_create_dir("data/annual/")
#make all the things - files for each year1

for (the_year in min_yr:max_yr) {
  a_year <- boulder_precip %>%
    filter(year(DATE) == the_year) %>%
    mutate(month = month(DATE))
  write.csv(a_year, file = paste0("data/annual/precip-", the_year, ".csv"))
}