library(readr)
library(lme4)

train <- read_csv(file.path(here::here(), "data/interim/train.csv"))

model <- lmer(
  formula = logSalePrice ~ 1 +
    I(pmin(LotArea, 15000)) +
    HighQualFinSF +
    I(log(HighQualFinSF)) +
    LowQualFinSF +
    BsmtFinSF_6 +
    BsmtFinSF_5 +
    BsmtFinSF_4 +
    BsmtFinSF_3 +
    BsmtFinSF_2 +
    BsmtFinSF_1 +
    MSZoning +
    I(log(9 - Functional)) +
    I(log(YrSold - YearRemodAdd + 3)) +
    I(log(OverallQual)) +
    I(log(OverallCond)) +
    (1|Neighborhood),
  data = train
)

model_file <- file.path(here::here(), "models", "mixed_effects_model.rds")
saveRDS(model, model_file)
