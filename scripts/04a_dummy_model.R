library(readr)

train <- read_csv(file.path(here::here(), "data/interim/train.csv"))

model <- lm(
  formula = logSalePrice ~ 1,
  data = train
)

model_file <- file.path(here::here(), "models", "dummy_model.rds")
saveRDS(model, model_file)
