library(readr)
library(dplyr)
source(file.path(here::here(), "src/manipulate.R"))

train <- read_csv(file.path(here::here(), "data/external/train.csv"))

train <- train %>%
  manipulate_data %>%
  filter(!is.na(SalePrice)) %>%
  mutate(logSalePrice = log(SalePrice)) %>%
  select(Id, MSZoning, LotArea, Neighborhood, BldgType, OverallQual, OverallCond, YearBuilt,
         YearRemodAdd, interiorArea, MoSold, YrSold, logSalePrice)

write_csv(train, file.path(here::here(), "data/interim/train.csv"))