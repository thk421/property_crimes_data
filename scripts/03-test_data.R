#### Preamble ####
# Purpose: Sanity check of the simulated data
# Author: Tina Kim
# Date: 26 September 2024
# Contact: tinak.kim@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to have the simulated data
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)


#### Test simulated data ####
simulated_data <- read_csv("data/raw_data/simulated_crime_data.csv")

# Check year range
year_range <- simulated_crime_data$report_year
test_year_range <- all(year_range >= 2016 & year_range <= 2023)

if (test_year_range) {
  print("All years are in the range 2016 to 2023.")
} else {
  print("Not all years are in the range 2016 to 2023.")
}

# Test if all crime types are within the defined set
test_crime_type <- all(simulated_crime_data$crime_type %in%
                         c("Break and Enter", "Theft", "Fraud", "Assault",
                           "Sexual Assault", "Attempted Murder", "Other"))

if (test_crime_type) {
  print("All crime types are valid.")
} else {
  print("Not all crime types are valid.")
}

# Test if all divisions are within the defined set
test_divisions <- all(simulated_crime_data$division
                      %in% c("D11", "D12", "D13", "D14", "D22", "D23", "D31",
                             "D32", "D33", "D41", "D42", "D43", "D51", "D52",
                             "D53", "D55"))

if (test_divisions) {
  print("All divisons are valid.")
} else {
  print("Not all divisions are valid.")
}

# Test if all cleared values are only 0 or 1
test_cleared_values <- all(simulated_crime_data$cleared %in% c(0, 1))

if (test_cleared_values) {
  print("All cleared values are either 0 or 1.")
} else {
  print("Not all cleared values are 0 or 1.")
}

# Test if there are empty values in the data

data_variables <- c("report_year", "division", "crime_type", "cleared")

for (var in data_variables) {
  if (all(is.na(simulated_crime_data[[var]]))) {
    print(paste(var, "contains NA values."))
  } else {
    print(paste(var, "does not contain any NA values."))
  }
}

# Test if the test simulated data matches the original simulated data

set.seed(123)
simulated_crime_data_test <- tibble(
  report_year = sample(year, size = 500, replace = TRUE),
  division = sample(division, size = 500, replace = TRUE),
  crime_type = sample(crime, size = 500, replace = TRUE),
  cleared = sample(c(0, 1), size = 500, replace = TRUE, prob = c(0.5, 0.5))
)

if (all.equal(simulated_crime_data, simulated_crime_data_test)) {
  print("The new simulated data matches the original simulated data.")
} else {
  print("The new simulated data does not match the original simulated data.")
}

#### Test cleaned data ####

cleaned_data <- read_csv("data/analysis_data/analysis_data.csv")

# Check year range
year_range <- cleaned_data$year
test_year_range <- all(year_range >= 2016 & year_range <= 2023)

if (test_year_range) {
  print("All years are in the range 2016 to 2023.")
} else {
  print("Not all years are in the range 2016 to 2023.")
}

# Test if crime types of interest are within the defined set
test_crime_type <- any(cleaned_data$crime %in%
                         c("Home Invasion", "Property Theft"))


if (test_crime_type) {
  print("Contains crime types of interest.")
} else {
  print("Does not contain crime types of interest.")
}


# Test if all divisions are within the defined set
test_divisions <- all(cleaned_data$division
                      %in% c("D11", "D12", "D13", "D14", "D22", "D23", "D31",
                             "D32", "D33", "D41", "D42", "D43", "D51", "D52",
                             "D53", "D55", "NSA"))

if (test_divisions) {
  print("All divisons are valid.")
} else {
  print("Not all divisions are valid.")
}

# Test if all covid_period values are either "Pre-COVID" or "Post-COVID"
test_cleared_values <-
  all(cleaned_data$covid_period %in% c("Pre-COVID", "Post-COVID"))

if (test_cleared_values) {
  print("All covid_period values are either Pre-COVID or Post-COVID.")
} else {
  print("Not all covid_period values are Pre-COVID or Post-COVID.")
}

# Test if count and count_cleared values are non-zero
non_negative <- all(cleaned_data$count >= 0) &&
  all(cleaned_data$count_cleared >= 0)

if (non_negative) {
  print("All count and count_cleared values are non-negative.")
} else {
  print("There are negative values in count or count_cleared.")
}

# Test if there are empty values in the data

data_variables <-
  c("year", "division", "crime", "count", "count_cleared", "covid_period")

for (var in data_variables) {
  if (all(is.na(cleaned_data[[var]]))) {
    print(paste(var, "contains NA values."))
  } else {
    print(paste(var, "does not contain any NA values."))
  }
}
