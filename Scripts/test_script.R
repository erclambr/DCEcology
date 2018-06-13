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



download.file("https://ndownloader.figshare.com/files/11930600?private_link=fe0cd1848e06456e6f38",
              
              "data/surveys_complete.csv")

surveys_complete <-read_csv("data/surveys_complete.csv")      # read_csv functie uit het tidyverse pakket
head(surveys_complete)
View(surveys_complete)

ggplot(data=surveys_complete) # er gebeurt niks omdat ggplot extra info nodig heeft wat te plotten
ggplot(data=surveys_complete, aes(x=weight, y= hindfoot_length))  #aes= aestethics
ggplot(data=surveys_complete, aes(x=weight, y= hindfoot_length)) + geom_point(alpha=0.1, aes(color= species_id))

## scatter plot weight y axis, id (x axs), dot = plot type


# boxplot met individuele datapunten (jitter)
ggplot(data=surveys_complete, aes(x=species_id, y= weight)) + geom_boxplot() + geom_jitter(alpha=0.3, color= "tomato")

ggplot(data=surveys_complete, aes(x=species_id, y= weight)) + geom_jitter(alpha=0.3, aes(color= plot_id))+ geom_boxplot()

surveys_complete$plot_id <-factor(surveys_complete$plot_id)

ggplot(data=surveys_complete, aes(x=species_id, y= weight)) + geom_violin(aes(color=plot_type))
ggplot(data=surveys_complete, aes(x=species_id, y= weight)) + geom_violin() + scale_y_log10()

ggplot(data=surveys_complete, aes(x=species_id, y= hindfoot_length)) + geom_boxplot() + geom_jitter(alpha=0.3, aes(color= plot_id))


yearly_count <-surveys_complete %>%
  group_by(year, species_id) %>%
  tally()
ggplot(data= yearly_count, aes(x=year, y=n, color=species_id)) +
 geom_line()
 
ggplot(data=yearly_count, aes (x=year, y=n)) + geom_line() + facet_wrap(~species_id)   # facet_wrap= aparte grafieken voor de species

yearly_sex_counts<- surveys_complete %>%
  group_by(year, species_id, sex) %>%
  tally()

ggplot(data=yearly_sex_counts, aes(x=year, y=n, color=sex)) + geom_line()+facet_wrap(~species_id)


# achtergrond wit maken
myplot<-ggplot(data=yearly_sex_counts, aes(x=year, y=n, color=sex)) + 
  geom_line() +
  facet_wrap(~species_id) + 
  theme_bw() +
  theme(panel.grid = element_blank(),
          text=element_text(size=16),
        axis.text.x= element_text(color="grey20", size= 12, angle=90, hjust=0.5, vjust=0.5))
  labs(title="observed species over time", x="Year of observation", y= "Number of observations")
                                                                                                                                                          ")

ggsave("plots/my_first_plot.png", myplot, width = 15, height=10, dpi=300)




