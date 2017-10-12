library(tidyverse)

# Scrambling the raw data to produce a messy dataset ----------------------
precip_d <- "https://ndownloader.figshare.com/files/7270970" %>%
  read_csv(na = c('', 'NA', 999.99)) %>%
  mutate(DATE = as.POSIXct(DATE, format = "%Y%m%d %H:%M")) %>%
  mutate(year = format(DATE, '%Y'))

# randomly replace missing values with various missing entries
is_missing <- is.na(precip_d$HPCP)
num_missing <- sum(is_missing)
possible_na_vals <- c(999.99, 'missing', 'n/a')
na_replacements <- sample(possible_na_vals, size = num_missing, replace = TRUE)
precip_d$HPCP[is_missing] <- na_replacements

# randomly generate modified station names
possible_station_names <- c(
  'Boulder 2 CO US', 
  'boulder 2 co us', 
  'BOULDER 2 CO US', 
  'Boulder 2 co US', 
  'Boulder 2 CO US', 
  'Boulder 2 Co Us', 
  'boulder 2 CO US'
)
precip_d <- precip_d %>%
  mutate(STATION_NAME = sample(possible_station_names, n(), replace = TRUE))

# randomly choose between date-time formats
possible_date_formats <- c("%d/%m/%y %H:%M:%OS", 
                           "%d-%m-%Y %H:%M:%OS")
precip_d <- precip_d %>%
  mutate(DATE = format(precip_d$DATE, 
                       sample(possible_date_formats, 
                              n(), 
                              replace = TRUE)
                       )
         )

# split into yearly files and save out a csv file for each year
dir.create(file.path('data', 'messy'))
precip_d %>%
  split(.$year) %>%
  map(~select(.x, -STATION) %>% 
        write.csv(file = file.path('data', 'messy',
                                   paste0('My_Data', 
                                          unique(.x$year), 
                                          ".csv")
                                   ),
                  row.names = FALSE)
      )

# push to amazing web services S3
# make sure that you have installed configured the AWS CLI with your credentials
system('aws s3 cp data/messy/ s3://earthlab-teaching/vchm/ --recursive --acl public-read')
