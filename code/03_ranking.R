here::i_am("code/03_ranking.R")
nba_data <- readr::read_csv(here::here("data/raw_nba_2025-10-30.csv"), show_col_types = FALSE)

library(dplyr)
library(tidyr)
library(ggplot2)

top_n <- 10
top_n_env <- Sys.getenv("TOP_N")
if (top_n_env != "") top_n <- as.integer(top_n_env)

nba_top <- nba_data %>%
  arrange(desc(PTS)) %>% 
  slice_head(n = top_n)

nba_top_scaled <- nba_top %>%
  mutate(across(c(PTS, AST, TRB, `FG%`, `3P%`, `FT%`, `eFG%`),
                ~ scales::rescale(.))) %>%
  pivot_longer(
    cols = c(PTS, AST, TRB, `FG%`, `3P%`, `FT%`, `eFG%`),
    names_to = "Metric",
    values_to = "Scaled_Value") %>%
  mutate(Player = paste0(Player," (", Team, ")"),
         Player = factor(Player, levels = paste0(nba_top$Player, " (", nba_top$Team, ")")))

hm <- ggplot(nba_top_scaled, aes(x = Metric, y = Player, fill = Scaled_Value)) +
  geom_tile(color = "white") +
  scale_y_discrete(limits = rev(levels(nba_top_scaled$Player))) +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(
    title = paste0("Top", top_n, " Players – Performance Summary Heatmap"),
    subtitle = "Players ordered by original PTS (non-scaled)",
    x = "Performance Metric",
    y = "Player (Team)",
    fill = "Relative Performance") +
  theme_minimal(base_size = 12)
ggsave("output/ranking_plot.png", plot = hm, width = 8, height = 5, dpi = 400)
