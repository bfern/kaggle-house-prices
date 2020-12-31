library(readr)
library(dplyr)
source(file.path(here::here(), "src/manipulate.R"))

train <- read_csv(file.path(here::here(), "data/external/train.csv"))

train <- train %>%
  manipulate_data %>%
  filter(!is.na(SalePrice)) %>%
  filter(
    #MSZoning != "C (all)",
    #Utilities == "AllPub",
    #SaleCondition == "Normal"
  ) %>%
  mutate(logSalePrice = log(SalePrice))

write_csv(train, file.path(here::here(), "data/interim/train.csv"))