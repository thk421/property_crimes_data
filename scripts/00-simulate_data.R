#### Preamble ####
# Purpose: Simulate data for property crime reports in Toronto before and after
# the onset of COVID-19, and indicate whether or not the report was cleared.
# Author: Tina Kim
# Date: 26 September 2024
# Contact: tinak.kim@mail.utoronto.ca
# License: University of Toronto
# Pre-requisites: Know where to get Toronto property crime data.
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####

# Set a random seed for random data simulations
set.seed(123)

# Define parameters year, division, and crime

# Use 2016 through 2023 to represent years before and after onset of COVID-19
year <- 2016:2023
# Represent each of the divisions in Toronto
division <- c("D11", "D12", "D13", "D14", "D22", "D23", "D31", "D32", 
              "D33", "D41", "D42", "D43", "D51", "D52", "D53", "D55")
# Represent possible crime types 
crime <- c("Break and Enter", "Theft", "Fraud", "Assault", "Sexual Assault",
           "Attempted Murder", "Other")

# Randomly simulate 500 crime reports in random divisions in random years,
# then whether or not the crime report was solved
simulated_crime_data <-
  tibble(
    report_year = sample(year, size = 500, replace = TRUE),
    division = sample(division, size = 500, replace = TRUE),
    crime_type = sample(crime, size = 500, replace = TRUE),
    cleared = sample(c(0, 1), size = 500, replace = TRUE, prob = c(0.5, 0.5))
  )

head(simulated_crime_data)

#### Save simulated data ####
write_csv(simulated_crime_data, file = "data/raw_data/simulated_crime_data.csv")

