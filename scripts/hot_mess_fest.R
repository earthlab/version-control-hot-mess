library(ggplot)
library(ggplot2)
library(lubridate)
library(dplyr)

# cause we love paths to other people's computers a lot
setwd("~/Documents/github/1_teaching_repos/version-control-hot-mess")

options(stringsAsFactors = FALSE)

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


min_yr <- min(year(boulder_precip$DATE))
max_yr <- max(year(boulder_precip$DATE))

#this does stuff 
check_create_dir("data/annual/")
#make all the things
for (the_year in min_yr:max_yr) {
  a_year <- boulder_precip %>%
    filter(year(DATE) == the_year) %>%
    mutate(month = month(DATE))
  write.csv(a_year, file = paste0("data/annual/precip-", the_year, ".csv"))
}




#start my analysis
read.csv("data/annual/precip-2003.csv")
plot(data)

mydata <- read.csv("data/week_06/outputs/precip_mm/precip-2003.csv")
myData$newcolumn <- mydata$precip * 12 / 2
my.data <-read.csv("data/week_06/outputs/precip_mm/precip-2004.csv")
my.data$newcolumn <- mydata$precip * 12 / 2
my.data<-read.csv("data/week_06/outputs/precip_mm/precip-2006.csv")
my.data$newcolumn <- mydata$precip * 12 / 2
my.data <-read.csv("data/week_06/outputs/precip_mm/precip-2007.csv")
my.data$newcolumn <- mydata$precip * 12 / 2
my.data <-read.csv("data/week_06/outputs/precip_mm/precip-20010.csv")
my.data$newcolumn <- mydata$precip * 12 / 2
plot(mydata)
#export stuff -  i should do this for all of my csv files
write.csv(mydata)


my.data <-read.csv("data/week_06/outputs/precip_mm/precip-2008.csv")
my.data$newcolumn <- mydata$month
#testing some stuff with pipes
outputs <- my.data %>%
  mutate(newcolumn = "fredyymack") %>%
  group_by(month) %>%
  summarise(mean(Precip_MM))

plot(mydata)
#export stuff
write.csv(mydata)

my.data <-read.csv("data/week_06/outputs/precip_mm/precip-2009.csv")
my.data$newcolumn <- mydata$month
#testing some stuff with pipes
outputs <- my.data %>%
  mutate(newcolumn = "fredyymack") %>% #i dont think i need this column do i?
  group_by(month) %>%
  summarise(mean(Precip_MM))

plot(mydata)
#export stuff
write.csv(mydata)

my.data <-read.csv("data/week_06/outputs/precip_mm/precip-2006.csv")
my.data$newcolumn <- mydata$month
#testing some stuff with pipes
outputs2 <- my.data %>%
  mutate(newcolumn = "fredyymack") %>%
  group_by(month) %>%
  summarise(mean(Precip_MM))

plot(mydata)
#export stuff
write.csv(mydata)

my.data <-read.csv("data/week_06/outputs/precip_mm/precip-2009.csv")
my.data<-read.csv("data/week_06/outputs/precip_mm/precip-2012.csv")
my.data <-read.csv("data/week_06/outputs/precip_mm/precip-2013.csv")

#not sure why everything isn't plotting
plot(my.data)
plot(my.data)
plot(mydata)
plot(my.data)
plot(my.data)

#testing some stuff with pipes
my.data %>%
  mutate(newcolumn = "fredyymack") %>%
  group_by(month) %>%
  summarise(mean(Precip_MM))


#testing some stuff with pipes
outputs <- my.data %>%
  mutate(newcolumn = "fredyymack") %>%
  group_by(month) %>%
  summarise(mean(Precip_MM))


ggplot(outputs, aes(y=month, x=precipmm)) +
  geom_point()

#need to do this to all of my data
#testing some stuff with pipes
#mydata <- my.data %>%
#  mutate(newcolumn = "fredyymack") %>%
#  group_by(month) %>%
#  summarise(mean(Precip_MM))



#export the data to a csv
write.csv(mydata)


library(dplyr)
library(ggplot2)
