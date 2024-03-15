#### Preamble ####
# Purpose: To create the logistic regression model.
# Author: Carl Fernandes, Lexi knight, Raghav Bhatia 
# Date: 12 March 2024
# Contact: raghav.bhatia@mail.utoronto.ca
# License: MIT
# Pre-requisites: Have the cleaned dataset.
# Any other information needed?


#### Workspace setup ####
library(boot)
library(broom.mixed)
library(collapse)
library(dataverse)
library(gutenbergr)
library(janitor)
library(knitr)
library(marginaleffects)
library(modelsummary)
library(rstanarm)
library(tidybayes)
library(tidyverse)
library(arrow)

#### Read data ####
ces2020_data <- read_parquet("data/cleaned_data/ces2020_cleaned/part-0.parquet")

### Mathematical Model ###

#\begin{align*}
#\text{logit(}\pi_i\text{)} &= \beta_0 + \beta_1 \cdot \text{gender}_i \\
#& \quad + \beta_2 \cdot \text{education}_i + b_i \\
#b_i &\sim \mathcal{N}(0, \sigma^2)
#\end{align*}

### Model data ####

## The example considers a sliced sample to improve the runtime of the model.

set.seed(853)

ces2020_data_reduced <- 
  ces2020_data |> 
  slice_sample(n = 2000)

## Voter Outcomes Demographic Only Model

# This glm regresses voting outcome on only demographic variables to test their
# fit

voter_outcomes_demographic_only <-
  stan_glm(
    voted_for ~ gender + education + race + region + marriage_status +
      family_income + economic_outlook + income_change,
    data = ces2020_data_reduced,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

## Voter Outcomes Economic Only Model

# This glm regresses voting outcome on only economic variables to test their
# fit

voter_outcomes_economic_only <-
  stan_glm(
    voted_for ~ economic_outlook + income_change,
    data = ces2020_data_reduced,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

## Final Model

set.seed(853)

ces2020_data_sample <- 
  ces2020_data |> 
  slice_sample(n = 10000)

voter_outcomes_final <-
  stan_glm(
    voted_for ~ gender + education + race + economic_outlook + income_change,
    data = ces2020_data_sample,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

#### Save model ####

saveRDS(
  voter_outcomes_demographic_only,
  file = "models/voter_outcomes_demographic_only.rds"
)

saveRDS(
  voter_outcomes_economic_only,
  file = "models/voter_outcomes_economic_only.rds"
)


saveRDS(
  voter_outcomes_final,
  file = "models/voter_outcomes_final.rds"
)


