library(readr)
library(dplyr)
source(file.path(here::here(), "src/manipulate.R"))

test <- read_csv(file.path(here::here(), "data/external/test.csv")) %>%
  manipulate_data

model <- readRDS(file.path(here::here(), "models/model.rds"))

test_with_preds <- test %>%
  mutate(SalePrice = exp(predict(model, test))) %>%
  dplyr::select(Id, SalePrice)

write_csv(test_with_preds, file.path(here::here(), "data/interim/test_with_preds.csv"))
          