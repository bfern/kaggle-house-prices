library(readr)
library(lme4)

train <- read_csv(file.path(here::here(), "data/interim/train.csv"))

model <- lmer(
  formula = logSalePrice ~ 1 +
    I(pmin(interiorArea, 4000)) +
    I(pmin(LotArea, 15000)) +
    MSZoning +
    OverallQual +
    OverallCond +
    YearRemodAdd +
    (1|Neighborhood),
  data = train
)

saveRDS(model, file.path(here::here(), "models/model.rds"))

# model <- lm(logSalePrice ~ 1, data = train)

train_with_preds <- train %>%
    mutate(pred = as.numeric(predict(model, train)))

saveRDS(train_with_preds, file.path(here::here(), "data/interim/train_with_preds.rds"))
