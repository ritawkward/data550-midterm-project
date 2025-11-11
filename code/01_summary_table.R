library(gtsummary)
library(gt)
library(kableExtra)

here::i_am("code/01_summary_table.R")
nba_data <- readr::read_csv(here::here("data/raw_nba_2025-10-30.csv"), show_col_types = FALSE)

theme_gtsummary_journal(journal = "jama")
theme_gtsummary_compact()

vars <- c("PTS","AST","TRB","FG%","3P%","FT%","eFG%")
vars <- intersect(vars, names(nba_data))

table1 <-
  nba_data %>% select(all_of(vars)) %>% 
  tbl_summary(
    type = all_continuous() ~ "continuous2",
    statistic = all_continuous() ~ c("{mean} ({sd})", "{median} [{p25}, {p75}]"),
    digits = all_continuous() ~ 2,
    missing = "no",
    label = list(
      PTS   ~ "Points per 36 min",
      AST   ~ "Assists per 36 min",
      TRB   ~ "Total Rebounds per 36 min",
      `FG%`  ~ "Field Goal Rate",
      `3P%`  ~ "3-Point Rate",
      `FT%`  ~ "Free Throw Rate",
      `eFG%` ~ "Effective FG Rate"))

table1 %>% 
  modify_header(label ~ "**Variable**", stat_0 ~ "**Summary**") %>% 
  bold_labels() %>% 
  as_gt() %>% 
  tab_caption("Table 1. Key per–36-minute statistics") %>% 
  tab_options(table.align = "center", table.width = pct(50))

saveRDS(table1, file = here::here("output/table1.rds"))
