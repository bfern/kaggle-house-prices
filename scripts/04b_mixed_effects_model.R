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

model_file <- file.path(here::here(), "models", "mixed_effects_model.rds")
saveRDS(model, model_file)
