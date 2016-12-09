# Wrangle food-world-cup-data
library(dplyr)
library(tidyr)

combineCols <- function(df) {
  # Rename columns relating to country ratings to only be the country name
  names(df) <- gsub("Please.rate.how.much.you.like.the.traditional.cuisine.of.", "", names(df))
  names(df)[4:43] <- gsub("\\.", "", names(df)[4:43])
  
  # Create one column with Country, another column with Rating
  tidy <- df %>%
    gather("country", "rating", 4:43)
  
  tidy$rating <- type.convert(tidy$rating, na.strings = "N/A")
  #setwd("~/INFO-201/food-world-cup/")
  
  return(tidy)
}

makePretty <- function(df) {
  # Makes values that have blanks into NA
  
  df$Gender[df$Gender == ""] <- NA
  
  # Removes observations that had entire rows with blank values.
  df <- na.omit(df)
  
  df$Age[df$Age == ""] <- NA
  df$Household.Income[df$Household.Income == ""] <- NA
  df$Education[df$Education == ""] <- NA
  
  return (df)
}