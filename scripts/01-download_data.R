#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Report - Reported Crimes data from Open Data Toronto
# Author: Tina Kim
# Date: 19 September 2024
# Contact: tinak.kim@mail.utoronto.ca
# License: University of Toronto
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)


#### Download data ####
library(opendatatoronto)
library(dplyr)

# get package
package <- show_package("police-annual-statistical-report-reported-crimes")
package

# get all resources for this package
resources <- list_package_resources("police-annual-statistical-report-reported-crimes")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
crime_data <- filter(datastore_resources, row_number()==1) %>% get_resource()


#### Save data ####
write_csv(crime_data, "data/raw_data/raw_crime_data.csv") 

