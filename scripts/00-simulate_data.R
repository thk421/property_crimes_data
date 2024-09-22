#### Preamble ####
# Purpose: Simulate data for property crime reports in Toronto over the past
# 10 years, and make a graph showing whether or not the report was cleared.
# Author: Tina Kim
# Date: 19 September 2024
# Contact: tinak.kim@mail.utoronto.ca
# License: University of Toronto
# Pre-requisites: Know where to get Toronto property crime data.
# Any other information needed? None


#### Workspace setup ####

#install.packages("tidyverse")
#install.packages("janitor")
#install.packages("knitr")
#install.packages("opendatatoronto")

library(tidyverse)
library(janitor)
library(knitr)
library(opendatatoronto)

#### Simulate data ####

set.seed(123)

# define parameters

# Use 2014 through 2024 to represent the past 10 years
year <- 2014:2024
# Represent each of the divisions in Toronto
division <- c("D11", "D12", "D13", "D14", "D22", "D23", "D31", "D32", 
              "D33", "D41", "D42", "D43", "D51", "D52", "D53", "D55")
# Represent property crime types
crime <- c("Break and Enter", "Theft", "Fraud")


simulated_crime_data <-
  tibble(
    # Randomly simulate 500 crime reports in random divisions in random years
    report_year = sample(year, size = 500, replace = TRUE),
    division = sample(division, size = 500, replace = TRUE),
    crime_type = sample(crime, size = 500, replace = TRUE),
    cleared = sample(c(0, 1), size = 500, replace = TRUE, prob = c(0.5, 0.5))
  )

head(simulated_crime_data)

#### Save simulated data ####
write_csv(simulated_crime_data, file = "data/raw_data/simulated_crime_data.csv")

