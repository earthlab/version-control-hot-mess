library(ggplot)



#### Commence analysis

myDATA <- read.csv("https://s3-us-west-2.amazonaws.com/earthlab-teaching/vchm/My_Data2003.csv")
#uh oh -- why are things messed up? 
head(myDATA)


# i really want to create a nice dataframe that summaizes rainfall by month in mm.
# so let's see how this goes. 
#year

# First I need to amek srue that the DATE column is a Date!!!
myDATA$dateasdate <- as.Date(myDATA$DATE)
str(myDATA) # check to make sure that the date column is a date

# Then I want to make sure that I have a column that is the month and another one that is year
myDATA$Month <- lubridate::month(myDATA$dateasdate)
str(myDATA) # check to make sure that the date column is a date

# Then I want to have a YEAR column that is the YEAR
myDATA$year <- lubridate::year(myDATA$dateasdate)
str(myDATA) # check to make sure that the date column is a date

#myDATA$DOY <- as.numeric(strftime(myDATA$dateasdate, format = "%j"))
#
# library(stringr)
# a_year <- myDATA %>%
#    mutate(DATE = gsub("/", "-", DATE),
#           DATE = ) %>% 
#     mutate(DATE2 = as.POSIXct(DATE, format = "%d-%m-%y %H:%M"),
#            DATE3 = as.POSIXct(DATE, format = "%d-%m-%Y %H:%M"))

# a_year$DATE2 <- gsub("(.*)-(..)$", "\\1-20\\2", a_year$DATE)

# fix the year with regex 
# gsub("(.*)-(..)$", "\\1-20\\2", vec1)
# 
# gsub("(.*)/(..)$", "\\1/19\\2", vec1)
# # the dates are all messed up. who made this data? seriously?
# myDATA$DATE
# i don't think this worked but who knows


# Finally, I want to save a CSV file has precip in mm
d2003 <- myDATA[myDATA[[12]] == 2003]
d2003$precip_MM = myDATA$HPCP * 25.4
write.csv(file = 'data/outputs/precip_2003.csv', x = d2003, row.names = FALSE)

as_2003 <- a_year %>% 
  mutate(precip_mm = HPCP * 25.4,
         month = month(DATE))

write.csv(as_2003,"data/outputs/precip_2003.csv")


write.csv(a_year, file = "data/annual/precip-2003.csv")

#year
a_year <- boulder_precip %>%
    filter(year(DATE) == 2004) %>%
    mutate(month = month(DATE))

write.csv(a_year, file = "data/annual/precip-2003.csv")

library(ggplot2)
#year
a_year <- boulder_precip %>%
    filter(year(DATE) == 2005) %>%
    mutate(month = month(DATE))

write.csv(a_year, file = "data/annual/precip-2003.csv")

#year
a_year <- boulder_precip %>%
    filter(year(DATE) == 2005) %>%
    mutate(month = month(DATE))

write.csv(a_year, file = "data/annual/precip-2006.csv")
#year
a_year <- boulder_precip %>%
    filter(year(DATE) == 2003) %>%
    mutate(month = month(DATE))

write.csv(a_year, file = "data/annual/precip-2007.csv")
#year
a_year <- boulder_precip %>%
    filter(year(DATE) == 2003) %>%
    mutate(month = month(DATE))

write.csv(a_year, file = "data/annual/precip-2008.csv")
#year
# I don't think that worked we will do it again but without error







#==============================================================================
#==============================================================================
#STRATEGY: going to calculate monthly averages of precipitation for each dataset
# (each year!) using R
#==============================================================================
#==============================================================================
myDATA <- read.csv("https://s3-us-west-2.amazonaws.com/earthlab-teaching/vchm/My_Data2003.csv")
myFinalData <- myDATA
unique(myFinalData$HPCP)
#na values
myDATA <- read.csv("https://s3-us-west-2.amazonaws.com/earthlab-teaching/vchm/My_Data2003.csv", 
                   na.strings = c("999.99"))
myFinalData <- myDATA
unique(myFinalData$HPCP)
myFinalData$DATE2 = as.POSIXct(myFinalData$DATE, format = "%Y-%d-%m %H:%M")
myFinalData$year <- substr(myFinalData$DATE, 1, 4)
myFinalData$month <- substr(myFinalData$DATE, 6, 7)
myFinalData = myFinalData[myFinalData$year == "2003",]

#myFinalData$month <- month(myFinalData$DATE)
#summary mean dataframe 2003
finalSUMMARYmean <- data.frame(jan_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "01"], na.rm = TRUE),
                           feb_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "02"], na.rm = TRUE),
                           march_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "03"], na.rm = TRUE),
                           apr_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "04"], na.rm = TRUE),
                           may_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "05"], na.rm = TRUE),
                           june_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "05"], na.rm = TRUE),
                           may_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "06"], na.rm = TRUE),
                           july_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "07"], na.rm = TRUE),
                           aug_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "08"], na.rm = TRUE),
                           sept_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "09"], na.rm = TRUE),
                           oct_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "09"], na.rm = TRUE),
                           nov_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "11"], na.rm = TRUE),
                           dec_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "12"], na.rm = TRUE))

finalSUMMARYmean


### 2004 - easy enough 
#i'd like a snack

#na values
myDATA <- read.csv("https://s3-us-west-2.amazonaws.com/earthlab-teaching/vchm/My_Data2004.csv", 
                   na.strings = c("999.99"))
unique(myFinalData$HPCP)
myDATA <- read.csv("https://s3-us-west-2.amazonaws.com/earthlab-teaching/vchm/My_Data2004.csv", 
                   na.strings = c(" ", "999.99", "missing", "n/a"))
unique(myDATA$HPCP)

myDATA$DATE2 = as.POSIXct(myDATA$DATE, format = "%Y-%d-%m %H:%M")
myDATA$year <- substr(myDATA$DATE, 1, 4)
myDATA$month <- substr(myDATA$DATE, 6, 7)
myDATA = myDATA[myDATA$year == "2004",]

jan_mean_2003 = mean(myFinalData$HPCP[myFinalData$month == "01"], na.rm = TRUE)

#myFinalData$month <- month(myFinalData$DATE)
#summary mean dataframe 2003
finalSUMMARYmean$jan_mean_2004 <- mean(myDATA$HPCP[myFinalData$month == "01"], na.rm = TRUE)
finalSUMMARYmean$feb_mean_2004 <- mean(myDATA$HPCP[myFinalData$month == "02"], na.rm = TRUE)
finalSUMMARYmean$march_mean_2004 <-mean(myDATA$HPCP[myFinalData$month == "03"], na.rm = TRUE)
finalSUMMARYmean$apr_mean_2004 = mean(myDATA$HPCP[myFinalData$month == "04"], na.rm = TRUE)
finalSUMMARYmean$may_mean_2004 = mean(myDATA$HPCP[myFinalData$month == "05"], na.rm = TRUE)
finalSUMMARYmean$june_mean_2004 = mean(myDATA$HPCP[myFinalData$month == "05"], na.rm = TRUE)
finalSUMMARYmean$may_mean_2004 = mean(myDATA$HPCP[myFinalData$month == "06"], na.rm = TRUE)
finalSUMMARYmean$july_mean_2004 = mean(myDATA$HPCP[myFinalData$month == "07"], na.rm = TRUE)
finalSUMMARYmean$aug_mean_2004 = mean(myDATA$HPCP[myFinalData$month == "08"], na.rm = TRUE)
finalSUMMARYmean$sept_mean_2004 = mean(myDATA$HPCP[myFinalData$month == "09"], na.rm = TRUE)
finalSUMMARYmean$oct_mean_2004 = mean(myDATA$HPCP[myFinalData$month == "09"], na.rm = TRUE)
finalSUMMARYmean$nov_mean_2004 = mean(myDATA$HPCP[myFinalData$month == "11"], na.rm = TRUE)
finalSUMMARYmean$dec_mean_2004 = mean(myDATA$HPCP[myFinalData$month == "12"], na.rm = TRUE)

finalSUMMARYmean



#na values
#2005 - my fingers are tired. may start lifting finger weights to help with endurance.
myDATA <- read.csv("https://s3-us-west-2.amazonaws.com/earthlab-teaching/vchm/My_Data2005.csv", 
                   na.strings = c("999.99"))
unique(myFinalData$HPCP)
myDATA <- read.csv("https://s3-us-west-2.amazonaws.com/earthlab-teaching/vchm/My_Data2005.csv", 
                   na.strings = c(" ", "999.99", "missing", "n/a"))
unique(myDATA$HPCP)

myDATA$DATE2 = as.POSIXct(myDATA$DATE, format = "%Y-%m-%d %H:%M")
myDATA$year <- substr(myDATA$DATE, 1, 4)
myDATA$month <- substr(myDATA$DATE, 6, 7)
myDATA = myDATA[myDATA$year == "2005",]

#myFinalData$month <- month(myFinalData$DATE)
#summary mean dataframe 2003
finalSUMMARYmean$jan_mean_2005 <- mean(myDATA$HPCP[myFinalData$month == "01"], na.rm = TRUE)
finalSUMMARYmean$feb_mean_2005 <- mean(myDATA$HPCP[myFinalData$month == "02"], na.rm = TRUE)
finalSUMMARYmean$march_mean_2005 <-mean(myDATA$HPCP[myFinalData$month == "03"], na.rm = TRUE)
finalSUMMARYmean$apr_mean_2005 = mean(myDATA$HPCP[myFinalData$month == "04"], na.rm = TRUE)
finalSUMMARYmean$may_mean_2005 = mean(myDATA$HPCP[myFinalData$month == "05"], na.rm = TRUE)
finalSUMMARYmean$june_mean_2005 = mean(myDATA$HPCP[myFinalData$month == "05"], na.rm = TRUE)
finalSUMMARYmean$may_mean_2005 = mean(myDATA$HPCP[myFinalData$month == "06"], na.rm = TRUE)
finalSUMMARYmean$july_mean_2005 = mean(myDATA$HPCP[myFinalData$month == "07"], na.rm = TRUE)
finalSUMMARYmean$aug_mean_2005 = mean(myDATA$HPCP[myFinalData$month == "08"], na.rm = TRUE)
finalSUMMARYmean$sept_mean_2005 = mean(myDATA$HPCP[myFinalData$month == "09"], na.rm = TRUE)
finalSUMMARYmean$oct_mean_2005 = mean(myDATA$HPCP[myFinalData$month == "09"], na.rm = TRUE)
finalSUMMARYmean$nov_mean_2005 = mean(myDATA$HPCP[myFinalData$month == "11"], na.rm = TRUE)
finalSUMMARYmean$dec_mean_2005 = mean(myDATA$HPCP[myFinalData$month == "12"], na.rm = TRUE)

finalSUMMARYmean#mostly working I guess will fix later


#na values
#2006 - i need a nap and some cookies. preferably oreos altho vanilla wafers could be nice
myDATA <- read.csv("https://s3-us-west-2.amazonaws.com/earthlab-teaching/vchm/My_Data2006.csv", 
                   na.strings = c("999.99"))
unique(myFinalData$HPCP)
myDATA <- read.csv("https://s3-us-west-2.amazonaws.com/earthlab-teaching/vchm/My_Data2006.csv", 
                   na.strings = c(" ", "999.99", "missing", "n/a"))
unique(myDATA$HPCP)

myDATA$DATE2 = as.POSIXct(myDATA$DATE, format = "%Y-%m-%d %H:%M")
myDATA$year <- substr(myDATA$DATE, 1, 4)
myDATA$month <- substr(myDATA$DATE, 6, 7)
myDATA = myDATA[myDATA$year == "2006",]

#myFinalData$month <- month(myFinalData$DATE)
#summary mean dataframe 2003
finalSUMMARYmean$jan_mean_2006 <- mean(myDATA$HPCP[myFinalData$month == "01"], na.rm = TRUE)
finalSUMMARYmean$feb_mean_2006 <- mean(myDATA$HPCP[myFinalData$month == "02"], na.rm = TRUE)
finalSUMMARYmean$march_mean_2006 <-mean(myDATA$HPCP[myFinalData$month == "03"], na.rm = TRUE)
finalSUMMARYmean$apr_mean_2006 = mean(myDATA$HPCP[myFinalData$month == "04"], na.rm = TRUE)
finalSUMMARYmean$may_mean_2006 = mean(myDATA$HPCP[myFinalData$month == "05"], na.rm = TRUE)
finalSUMMARYmean$june_mean_2006 = mean(myDATA$HPCP[myFinalData$month == "05"], na.rm = TRUE)
finalSUMMARYmean$may_mean_2006 = mean(myDATA$HPCP[myFinalData$month == "06"], na.rm = TRUE)
finalSUMMARYmean$july_mean_2006 = mean(myDATA$HPCP[myFinalData$month == "07"], na.rm = TRUE)
finalSUMMARYmean$aug_mean_2006 = mean(myDATA$HPCP[myFinalData$month == "08"], na.rm = TRUE)
finalSUMMARYmean$sept_mean_2006 = mean(myDATA$HPCP[myFinalData$month == "09"], na.rm = TRUE)
finalSUMMARYmean$oct_mean_2006 = mean(myDATA$HPCP[myFinalData$month == "09"], na.rm = TRUE)
finalSUMMARYmean$nov_mean_2006 = mean(myDATA$HPCP[myFinalData$month == "11"], na.rm = TRUE)
finalSUMMARYmean$dec_mean_2006 = mean(myDATA$HPCP[myFinalData$month == "12"], na.rm = TRUE)

finalSUMMARYmean# Workikng better now!

write.csv(a_year, file = "finalSUMMARYmean.csv")













#start my analysis
# =============================================================================
# FIGURES FOR THE VISUALIZATION OF PRECIPITATION IN BOULDER COUNTY FROM THE 
# YEARS 2003 THROUGH 2010 - WE ARE GOING TO PLOT THE MONTHLY MEANS OVER TIME
# TO SEE WHETHER THERE ARE LONG TERM CHANGES IN PRECIPITATION ALL OF THE PLOTS
# SHOULD BE ON THE SAME PANEL - I ONLY WANT TO COLOR THE LINES TO INDICATE
# YEAR AND THE X AXIS IS MONTH AND THE Y AXIS IS AVERAGE WATER
# =============================================================================
# LAST MODIFIED ON NOVEMBER 9 2017 BY MAX JOSEPH
# PRETTY SURE THIS WORKS BUT NO GUARANTEES


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
lines(mydata)
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

