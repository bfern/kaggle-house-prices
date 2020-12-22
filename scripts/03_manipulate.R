library(readr)
library(dplyr)
library(ggplot2)
library(mgcv)

train <- read_csv(file.path(here::here(), "data/external/train.csv"))

train <- train %>%
  select(MSZoning, LotArea, Neighborhood, BldgType, OverallQual, OverallCond, YearBuilt,
         YearRemodAdd, GarageCars, TotalBsmtSF, "1stFlrSF", "2ndFlrSF",
         MoSold, YrSold, SalePrice) %>%
  rename(firstFlrSF = "1stFlrSF", secondFlrSF = "2ndFlrSF")

train %>%
    mutate(
      interiorArea =  TotalBsmtSF + firstFlrSF + secondFlrSF,
      logSalePrice = log(SalePrice)
    ) %>%
    select(-c(TotalBsmtSF, firstFlrSF, secondFlrSF, SalePrice))

write_csv(train, file.path(here::here(), "data/interim/train.csv"))