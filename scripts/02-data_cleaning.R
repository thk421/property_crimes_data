#### Preamble ####
# Purpose: Cleans the raw crime data into an analysis dataset
# Author: Tina Kim
# Date: 26 September 2024
# Contact: tinak.kim@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to have downloaded the data
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)


#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_crime_data.csv")

cleaned_data <- raw_data %>%
  # Remove rows with missing variables
  na.omit(raw_data) |>
  # Remove unnecessary variable 'CATEGORY' 
  mutate(CATEGORY = NULL) |>
  # Rename variables for better understanding 
  rename(year = REPORT_YEAR) |>
  rename(division = DIVISION) |>
  rename(crime = SUBTYPE) |>
  rename(count = COUNT_) |>
  rename(count_cleared = COUNT_CLEARED) |>
  # Filter report years to 2016-2023
  filter(year >= 2016 & year <= 2023) |>
  # Combine different Break & Enter property types into a single Home Invasion crime category
  mutate(crime = if_else(str_detect(crime, "Break & Enter"), 
                              "Home Invasion", crime)) |>
  # Combine different Theft prices into a single Property Theft crime category
  mutate(crime = if_else(str_detect(crime, "Theft"), 
                              "Property Theft", crime)) |>
  # Make a new column called 'covid_period' to indicate if the report was before or after 2020
  mutate(covid_period = ifelse(year < 2020, 'Pre-COVID', 'Post-COVID'))


#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")

