library(readr)
library(dplyr)

test <- read_csv(file.path(here::here(), "data/external/test.csv"))

test <- test %>%
  rename(firstFlrSF = "1stFlrSF", secondFlrSF = "2ndFlrSF") %>%
  mutate(
    TotalBsmtSF = coalesce(TotalBsmtSF, 0),
    interiorArea = TotalBsmtSF + firstFlrSF + secondFlrSF,
    MSZoning = coalesce(MSZoning, "RL")
  )

model <- readRDS(file.path(here::here(), "models/model.rds"))

test_with_preds <- test %>%
  mutate(SalePrice = exp(predict(model, test))) %>%
  dplyr::select(Id, SalePrice)

write_csv(test_with_preds, file.path(here::here(), "data/interim/test_with_preds.csv"))
          