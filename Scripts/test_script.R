library(tidyverse)
download.file("https://ndownloader.figshare.com/files/2292169","data/portal_data_joined.csv") # file downloaden en in data folder opslaan
surveys <- read.csv("data/portal_data_joined.csv")

View(surveys) # geeft surveys weer in nieuw tabblad
head(surveys) # geeft enkel de eerste lijnen
dim(surveys) # geeft dimensie van surveys

nrow(surveys) # aantal rijen

ncol(surveys) 

head(surveys) 

tail(surveys) # einde van de file

names(surveys)    # geeft kolomnamen weer
      
rownames(surveys) # geeft rijnamen
      
str(surveys) 
      
summary(surveys)
sex<- factor(c("male","female","female", "male"))


plot(surveys$sex)   # plot sexkolom
levels(surveys$sex)
sex <-surveys$sex
levels(sex)[1] <-"undetermined"  #change the name of the first level to undetermined
levels(sex)
plot(sex)
levels(sex)[2] <- "Female" 
levels(sex)[3] <- "Male"
levels(sex)[2:3 <-c("female", "male")]  # in eens verzetten
plot(sex)
sex2<-factor(sex, levels =c("Female", "Male", "undetermined"))  #change the order of the x-values
plot(sex2)
summary(surveys$sex)


surveys$genus <-factor(surveys$genus)  #genus omzetten naar factors ipv characters
str(surveys)


install.packages("lubridate")
library(lubridate)


my_date <-ymd("2015-01-01")  # datum weergeven op 2 verschillende manieren
my_date <-ymd(paste("2015","1","1", sept="-"))
# datum weergeven van verschillende kolommen
paste(surveys$year, surveys$month, surveys$day, sep="-")
ymd(paste(surveys$year, surveys$month, surveys$day, sep="-")) # aangeven dat het datums zijn
surveys$data <-ymd(paste(surveys$year, surveys$month, surveys$day, sep="-")) # nieuwe kolom toevoegen aan surveys

is_missing_date<- is.na(surveys$data)
date_columns <-c("year", "month","day") # kies welke kolommen je wil weergeven later
missing_dates <- surveys[is_missing_date, date_columns]
head(missing_dates)





download.file("https://figshare.com/s/fe0cd1848e06456e6f38","data/surveys_complete.csv")



