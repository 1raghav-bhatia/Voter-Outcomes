# Voting Patterns Unveiled

## Overview

The repository contains all related coding scripts and materials used to create the research paper "Voting Patterns Unveiled: The Impact of Demographics and Economic Outlook in the 2020 Election".

## File Structure

The structure of the repo is:

-   `data/raw_data/ces2020_demographic_data.csv` is the raw data containing only demographic variables obtained from the Cooperative Election Study Dataverse in the Harvard Dataverse Repository.
-   `data/raw_data/ces2020_economic_data.csv` is the raw data containing only economic variables obtained from the Cooperative Election Study Dataverse in the Harvard Dataverse Repository.
-   `data/cleaned_data/ces2020_cleaned/part-0.parquet` is the cleaned dataset.
-   `model` contains all the main model, the demographic only model, and economic only model.
-   `other` contains details on LLM usage and sketches
-   `paper` contains the qmd file used to render the research paper, along with the pdf of the paper, and reference bibliography file. It also contains a duplicate copy of the data folder which helps in faster rendering the qmd file. 
-   `scripts` contains the R scripts used to simulate the data, download and clean it, test it, and model it.

## Statement on LLM usage

The following large language models were used for some aspect of the code and data cleaning. The usage is documented in the usage.txt file within the `other\LLM` folder:

- ChatGPT 4
- Gemini Advanced
