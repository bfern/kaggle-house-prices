library(readr)
library(DataExplorer)

train <- read_csv(file.path(here::here(), "data/external/train.csv"))

create_report(train, output_file = "01_report.html", output_dir = file.path(here::here(), "scripts/"))
