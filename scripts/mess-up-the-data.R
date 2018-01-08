library(tidyverse)

# Scrambling the raw data to produce a messy dataset ----------------------
precip_d <- "https://ndownloader.figshare.com/files/7270970" %>%
  read_csv(na = c('', 'NA', 999.99)) %>%
  mutate(DATE = as.POSIXct(DATE, format = "%Y%m%d %H:%M"), 
         year = format(DATE, '%Y'))

# predict values for new sites by randomly sampling rows in the actual data
new_site_names <- c('LYONS 1 CO US', 
                    'DENVER 1 CO US')
new_data <- vector(mode = 'list', length = length(new_site_names))
names(new_data) <- new_site_names
for (i in seq_along(new_data)) {
  new_data[[i]] <- sample_n(precip_d, size = nrow(precip_d), replace = TRUE)
  new_station_id <- paste0('COOP:', sprintf("%06d", sample(x = 0:999999, size = 1)))
  new_data[[i]] <- new_data[[i]] %>%
    mutate(STATION = new_station_id, 
           STATION_NAME = names(new_data)[i],
           ELEVATION = round(1650 + rnorm(1, 0, 100), digits = 1), 
           LATITUDE = round(40 + rnorm(1), digits = 5), 
           LONGITUDE = round(-105.28 + rnorm(1), digits = 5), 
           DATE = precip_d$DATE, 
           year = precip_d$year)
}

# merge simulated station data with actual station data
joined_d <- bind_rows(new_data) %>%
  full_join(precip_d)

# randomly replace missing values with various missing entries
is_missing <- is.na(joined_d$HPCP)
num_missing <- sum(is_missing)
possible_na_vals <- c(999.99, 'missing', 'n/a', ' ')
na_replacements <- sample(possible_na_vals, size = num_missing, replace = TRUE)
joined_d$HPCP[is_missing] <- na_replacements

# randomly generate modified station names
lower_rand <- function(x, prob = .05) {
  # chooses unique letters to lowercase in a string
  # with probability = prob
  n_char <- nchar(x)
  unique_chars <- unique(strsplit(x, "")[[1]])
  to_modify <- sample(unique_chars, 1)
  modify_x <- sample(c(TRUE, FALSE), 1, prob = c(prob, 1 - prob))
  if (modify_x) {
    x <- gsub(to_modify, replacement = tolower(to_modify), x)
  }
  return(x)
}

dirty_d <- joined_d %>%
  rowwise %>%
  mutate(STATION_NAME = lower_rand(STATION_NAME), 
         clean_station_name = strsplit(STATION_NAME, ' ')[[1]][[1]] %>% tolower)

# split into yearly files and save out a csv file for each year X site combo
dir.create(file.path('data', 'messy'))

write_dirty_csv <- function(df) {
  path <- file.path('data', 'messy',
                    paste0('My_Data', 
                           unique(df$year),
                           '-', 
                           unique(df$clean_station_name),
                           ".csv"))
  df_to_save <- df %>% select(-clean_station_name, -year)
  write_csv(df_to_save, path)
}

dirty_d %>%
  split(interaction(.$year, .$clean_station_name)) %>%
  map(~write_dirty_csv(.))

# push to amazing web services S3
# make sure that you have installed configured the AWS CLI with your credentials
system('aws s3 cp data/messy/ s3://earthlab-teaching/vchm/ --recursive --acl public-read')
