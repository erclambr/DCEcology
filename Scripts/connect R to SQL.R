
# R EN SQL interaction
-------------------------

# Installing new packages nodig om connectie te maken met SQLite ----

install.packages("dbplyr")
install.packages("RSQLite") 

# Load the libraries ----

library(dplyr)
library(dbplyr)
library(DBI) # generic, nodig bij eender wat voor database
library(RSQLite)


# download data ----
download.file(url = "https://ndownloader.figshare.com/files/2292171",
              
              destfile = "data/portal_mammals.sqlite", mode = "wb") # bij sqlite files wb toevoegen omdat het een binairy file is

# create connection to the existing sqlite database----
DBConnection <- DBI::dbConnect(RSQLite::SQLite(),"data/portal_mammals.sqlite")
str(DBConnection)

# to see how our DBConnection object looks like
str(DBconnection)

#looking in to my DBConnection
?src_dbi
src_dbi(DBConnection)  # maakt een verbinding met de database in dit geval op de pc maar hoeft niet zo te zijn

#interacting with tables
?tbl
dplyr::tbl(DBConnection, "surveys")
dplyr::tbl(DBConnection, "species")
dplyr::tbl(DBConnection, "plots")

#assign to an object
surveys <- dplyr::tbl(DBConnection, "surveys")
species<- dplyr::tbl(DBConnection, "species")
plots <- dplyr::tbl(DBConnection, "plots")

head(surveys)
nrow(surveys)


surveys %>%
    filter (year ==2002, weight > 220)

show_query(surveys %>% 
            filter(year ==2002, weight >220))
surveys2002<- surveys %>%
  as.data.frame()   # zorgt ervoor dat er reeele data ontstaat in the environment

# write a dplyr mutate on surveys to add a column called mean_weight
surveys %>%
    mutate(weight_kg = weight/1000)

# Make a subset of your data and plot it

surveys2002 <- surveys %>% 
  
  filter(year == 2002) %>% 
  
  as.data.frame() 

library(ggplot2)  

ggplot(data = surveys2002, aes(weight, colour = "red")) +
  
  stat_density(geom = "line", size = 2, position = "identity") +
  
  theme_classic() +
  
  theme(legend.position = "none")



# Exercise 

# make one chunk of code to do the subset and the plot
surveys %>%
  
  filter (year == 2002) %>%
  
  as.data.frame() %>%   # omzetten naar dataframe omdat ggplot dit nodig heeft
  
  ggplot(aes(weight, colour = "red")) +
  
  stat_density(geom = "line", size = 2, position = "identity") +
  
  theme_classic() +
  
  theme(legend.position = "none")


# Save the surveys2002 into a cvs file in your data folder

library(readr)
?write.csv
write_csv(surveys2002, path = "data/surveys2002.csv")

# The RSQLite package allows R to interface with SQLite databases
# Important this SQLite function does not load the data into the R session, handig voor grote databases, enkel connectie maken

