library(readr)

train <- read_csv(file.path(here::here(), "data/interim/train.csv"))

model <- lm(logSalePrice ~ 1, train)                  

train_with_preds <- train %>%
    mutate(pred = as.numeric(predict(model, train)))

saveRDS(train_with_preds, file.path(here::here(), "data/interim/train_preds.rds"))
