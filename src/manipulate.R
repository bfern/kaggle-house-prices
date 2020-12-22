select <- dplyr::select

manipulate_data <- function(df) {
  df %>%
    rename(firstFlrSF = "1stFlrSF", secondFlrSF = "2ndFlrSF") %>%
    mutate(
      TotalBsmtSF = coalesce(TotalBsmtSF, 0),
      MSZoning = coalesce(MSZoning, "RL"),
      interiorArea =  TotalBsmtSF + firstFlrSF + secondFlrSF
    )
}