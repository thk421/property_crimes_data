#### Preamble ####
# Purpose: Make models to compare the change in property invasion and theft 
# crimes before and after COVID-19
# Author: Tina Kim
# Date: 23 September 2024
# Contact: tinak.kim@mail.utoronto.ca
# License: University of Toronto
# Pre-requisites: Have the cleaned data ready to use for analysis
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(rstanarm)


#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")


### Model data ####

# Property theft reports per year
theft_data <- analysis_data %>%
  filter(CRIME_TYPE == "Theft")

theft_counts_per_year <- theft_data %>%
  group_by(REPORT_YEAR) %>%
  summarise(total_crime_count = sum(COUNT_))

first_model <- ggplot(theft_counts_per_year, aes(x = factor(REPORT_YEAR), 
                                                  y = total_crime_count)) +
  geom_bar(stat = "identity", fill = "steelblue") +   # Create bar plot
  labs(title = "Property Theft Reports per Year",
       x = "Year",
       y = "Total Property Theft Reports") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Home invasion crime reports per year
home_invasion_data <- analysis_data %>%
  filter(CRIME_TYPE == "Home Invasion")

home_invasion_counts_per_year <- home_invasion_data %>%
  group_by(REPORT_YEAR) %>%
  summarise(total_crime_count = sum(COUNT_))

second_model <- ggplot(home_invasion_counts_per_year, 
                       aes(x = factor(REPORT_YEAR), y = total_crime_count)) +
  geom_bar(stat = "identity", fill = "steelblue") +   # Create bar plot
  labs(title = "Home Invasion Reports per Year",
       x = "Year",
       y = "Total Home Invasion Reports") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Total property invasion and theft crime reports per year
property_crime_data <- analysis_data %>%
  filter(CRIME_TYPE == "Home Invasion", "Theft")

property_crime_counts_per_year <- property_crime_data %>%
  group_by(REPORT_YEAR) %>%
  summarise(total_crime_count = sum(COUNT_))

third_model <- ggplot(property_crime_counts_per_year, 
                       aes(x = factor(REPORT_YEAR), y = total_crime_count)) +
  geom_bar(stat = "identity", fill = "steelblue") +   # Create bar plot
  labs(title = "Home Invasion and Property Theft Crime Reports per Year",
       x = "Year",
       y = "Total Home Invasion and Property Theft Crime Reports") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Change in property crime trends before and after COVID across 
# 16 districts in Toronto

# Overall crime rates from raw data across 16 districts in Toronto

# Compare if ratio of counts cleared affects change in crime rate trends
# before and after COVID


#### Save model ####
# example code
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

saveRDS(
  second_model,
  file = "models/second_model.rds"
)

saveRDS(
  third_model,
  file = "models/third_model.rds"
)




