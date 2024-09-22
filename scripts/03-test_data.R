#### Preamble ####
# Purpose: Sanity check of the data
# Author: Tina Kim
# Date: 19 September 2024
# Contact: tinak.kim@mail.utoronto.ca
# License: University of Toronto
# Pre-requisites: Need to have the simulated data
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)


#### Test simulated data ####
simulated_data <- read_csv("data/raw_data/simulated_crime_data.csv")

# Check year range
year_range <- simulated_crime_data$report_year
test_year_range <- all(year_range >= 2014 & year_range <= 2024)
test_year_range

# Test if all crime types are within the defined set
test_crime_type <- all(simulated_crime_data$crime_type %in% 
                         c("Break and Enter", "Theft", "Fraud"))

test_crime_type

# Test if all divisions are within the defined set
test_divisions <- all(simulated_crime_data$division 
                      %in% c("D11", "D12", "D13", "D14", "D22", "D23", "D31", 
                             "D32", "D33", "D41", "D42", "D43", "D51", "D52", 
                             "D53", "D55"))

test_divisions

# Test if all cleared values are only 0 or 1
test_cleared_values <- all(simulated_crime_data$cleared %in% c(0, 1))

test_cleared_values

# Test if the test simulated data matches the original simulated data

set.seed(123)
simulated_crime_data_test <- tibble(
  report_year = sample(year, size = 500, replace = TRUE),
  division = sample(division, size = 500, replace = TRUE),
  crime_type = sample(crime, size = 500, replace = TRUE),
  cleared = sample(c(0, 1), size = 500, replace = TRUE, prob = c(0.5, 0.5))
)

all.equal(simulated_crime_data, simulated_crime_data_test)

