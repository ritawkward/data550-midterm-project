here::i_am("code/04_regression.R")

library(dplyr)
library(broom)
library(ggplot2)
library(here)
library(readr)
library(tidyr)

in_csv  <- here::here("data", "raw_nba_2025-10-30.csv")
nba_data <- readr::read_csv(in_csv, show_col_types = FALSE)

vars <- c("PTS","AST","TRB","FG%","3P%")
vars <- intersect(vars, names(nba_data))

model_data <- nba_data %>%
  select(all_of(vars)) %>%
  drop_na()

lm_fit <- lm(PTS ~ `FG%` + `3P%` + AST + TRB, data = model_data)

coef_table <- tidy(lm_fit)
fit_stats  <- glance(lm_fit)
aug_data<- augment(lm_fit)

saveRDS(lm_fit, here::here("output","reg_model.rds"))
saveRDS(coef_table, here::here("output", "reg_coef_table.rds"))
saveRDS(fit_stats, here::here("output", "reg_fit_stats.rds"))
saveRDS(aug_data, here::here("output", "reg_augmented.rds"))

p_pred <- ggplot(aug_data, aes(x = .fitted, y = PTS)) +
  geom_point(color = "#2E86AB", alpha = 0.6) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "gray40") +
  labs(
    x = "Predicted Points per 36 Minutes",
    y = "Actual Points per 36 Minutes",
    title = "Predicted vs Actual Points per 36 Minutes") +
  theme_minimal()

ggsave(filename = here("output","reg_pred_vs_actual.png"), plot = p_pred, width = 8, height = 4.5, dpi = 300)
