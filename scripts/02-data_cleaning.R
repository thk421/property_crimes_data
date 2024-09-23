#### Preamble ####
# Purpose: Cleans the raw crime data into an analysis dataset
# Author: Tina Kim
# Date: 19 September 2024
# Contact: tinak.kim@mail.utoronto.ca
# License: University of Toronto
# Pre-requisites: Need to have downloaded the data
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(stringr)

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_crime_data.csv")

cleaned_data <- raw_data %>%
  # Use the 'CATEGORY' column to only filter out crimes against property
  filter(CATEGORY == "Crimes Against Property") |>
  # Remove unnecessary variable 'CATEGORY' 
  mutate(CATEGORY = NULL) |>
  # Rename variable subtype into 'CRIME_TYPE'
  rename(CRIME_TYPE = SUBTYPE) |>
  # Remove 'Fraud' rows from 'CRIME_TYPE' column
  filter(CRIME_TYPE != "Fraud") |>
  # Combine different Break & Enter property types into Home Invasion crimes
  mutate(CRIME_TYPE = if_else(str_detect(CRIME_TYPE, "Break & Enter"), 
                              "Home Invasion", CRIME_TYPE)) |>
  # Combine different Theft prices into Theft crimes
  mutate(CRIME_TYPE = if_else(str_detect(CRIME_TYPE, "Theft"), 
                              "Theft", CRIME_TYPE))


#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")

