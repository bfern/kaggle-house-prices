select <- dplyr::select

manipulate_data <- function(df) {
  bsmt_cond_levels <- c("Unf", "LwQ", "Rec", "BLQ", "ALQ", "GLQ")
  functional_levels <- c("Sal", "Sev", "Maj2", "Maj1", "Mod", "Min2", "Min1", "Typ")
  df %>%
    rename(firstFlrSF = "1stFlrSF", secondFlrSF = "2ndFlrSF") %>%
    mutate(
      TotalBsmtSF = coalesce(TotalBsmtSF, 0),
      MSZoning = coalesce(MSZoning, "RL"),
      HighQualFinSF = GrLivArea - LowQualFinSF,
      BsmtUnfSF = coalesce(BsmtUnfSF, 0),
      BsmtFinType1 = as.numeric(factor(BsmtFinType1, levels = bsmt_cond_levels)),
      BsmtFinType1 = if_else(is.na(BsmtFinType1), 0, BsmtFinType1),
      BsmtFinType2 = as.numeric(factor(BsmtFinType2, levels = bsmt_cond_levels)),
      BsmtFinType2 = if_else(is.na(BsmtFinType2), 0, BsmtFinType2),
      BsmtFinSF_1 = if_else(BsmtFinType1 == 1, BsmtFinSF1, 0) +
        if_else(BsmtFinType2 == 1, BsmtFinSF2, 0) +
        BsmtUnfSF,
      BsmtFinSF_2 = if_else(BsmtFinType1 == 2, BsmtFinSF1, 0) +
        if_else(BsmtFinType2 == 2, BsmtFinSF2, 0),
      BsmtFinSF_3 = if_else(BsmtFinType1 == 3, BsmtFinSF1, 0) +
        if_else(BsmtFinType2 == 3, BsmtFinSF2, 0),
      BsmtFinSF_4 = if_else(BsmtFinType1 == 4, BsmtFinSF1, 0) +
        if_else(BsmtFinType2 == 4, BsmtFinSF2, 0),
      BsmtFinSF_5 = if_else(BsmtFinType1 == 5, BsmtFinSF1, 0) +
        if_else(BsmtFinType2 == 5, BsmtFinSF2, 0),
      BsmtFinSF_6 = if_else(BsmtFinType1 == 6, BsmtFinSF1, 0) +
        if_else(BsmtFinType2 == 6, BsmtFinSF2, 0),
      BathsBsmt = BsmtFullBath + 0.5 * BsmtHalfBath,
      BathsAbvGr = FullBath + 0.5 * HalfBath,
      BathsTotal = BathsBsmt + BathsAbvGr,
      RecepAbvGr = TotRmsAbvGrd - BedroomAbvGr - KitchenAbvGr,
      AdjacentArterialStreet = Condition1 == "Artery" | Condition2 == "Artery",
      AdjacentFeederStreet = Condition1 == "Feedr" | Condition2 == "Feedr",
      Within200FtOfNSRailroad = Condition1 == "RRNn" | Condition2 == "RRNn",
      AdjacentToNSRailroad = Condition1 == "RRAn" | Condition2 == "RRAn",
      NearPosOffsiteFeature = Condition1 == "PosN" | Condition2 == "PosN",
      AdjacentPosOffsiteFeature = Condition1 == "PosA" | Condition2 == "PosA",
      Within200FtOfEWRailroad = Condition1 == "RRNe" | Condition2 == "RRNe",
      AdjacentEWRailroad = Condition1 == "RRAe" | Condition2 == "RRAe",
      Functional = as.numeric(factor(Functional, levels = functional_levels)),
      Functional = coalesce(Functional, 8)
    )
}
