library(readr)
library(dplyr)
library(ggplot2)

train <- read_csv(file.path(here::here(), "data/external/train.csv"))

train <- train %>%
  select(MSZoning, LotArea, Neighborhood, BldgType, OverallQual, OverallCond, YearBuilt,
         YearRemodAdd, BsmtFullBath, BsmtHalfBath, FullBath, HalfBath, GarageCars,
         TotalBsmtSF, "1stFlrSF", "2ndFlrSF", MoSold, YrSold, SalePrice) %>%
  rename(firstFlrSF = "1stFlrSF", secondFlrSF = "2ndFlrSF")

train %>%
    mutate(interior_area =  TotalBsmtSF + firstFlrSF + secondFlrSF) %>%
    ggplot(aes(x = interior_area, y = SalePrice)) +
    geom_point() +
    geom_smooth()

train %>%
