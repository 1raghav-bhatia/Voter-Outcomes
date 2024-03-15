#### Preamble ####
# Purpose: Downloads and saves the ces20 dataset from the Harvard dataverse
# database with the required variables for the study.
# Author: Carl Fernandes, Lexi Knight and Raghav Bhatia
# Date: 12 March 2024
# Contact: raghav.bhatia@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(dataverse)
library(gutenbergr)
library(janitor)
library(knitr)
library(readr)

#### Download data ####

## Downloading the demographic variable data

ces2020_demographic <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  ) |>
  select(votereg, CC20_410, gender, educ, race, marstat, region, faminc_new)

## Downloading the economic variable data

ces2020_economic <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  ) |>
  select(votereg, CC20_410, CC20_302, CC20_303)

#### Save data ####

write_csv(ces2020_demographic, "data/raw_data/ces2020_demographic_data.csv")
write_csv(ces2020_economic, "data/raw_data/ces2020_economic_data.csv")

         
