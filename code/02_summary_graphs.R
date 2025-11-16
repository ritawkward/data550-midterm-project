here::i_am("code/02_summary_graphs.R")
nba_data <- readr::read_csv(here::here("data/raw_nba_2025-10-30.csv"), show_col_types = FALSE)

library(ggplot2)

# Histogram: Points per 36 min

hist_pts <- ggplot(nba_data, aes(x = PTS)) +
  geom_histogram(fill = "#17408B", color = "white", bins = 30) +
  labs(
    title = "Distribution of Points per 36 Minutes",
    x = "Points per 36 Minutes",
    y = "Count"
  ) +
  theme_minimal()

# Scatter Plot 1: Points vs eFG%

scatter_efg <- ggplot(nba_data, aes(x = `eFG%`, y = PTS)) +
  geom_point(color = "#C9082A", alpha = 0.7) +
  geom_smooth(method = "lm", color = "#17408B", se = TRUE) +
  labs(
    title = "Points vs Effective Field Goal Percentage",
    x = "Effective Field Goal Percentage",
    y = "Points per 36 Minutes"
  ) +
  theme_minimal()

cor_pts_efg <- cor(nba_data$PTS, nba_data$`eFG%`, use = "complete.obs")

# Scatter Plot 2: Points vs Assists

scatter_ast <- ggplot(nba_data, aes(x = AST, y = PTS)) +
  geom_point(color = "#17408B", alpha = 0.7) +
  geom_smooth(method = "lm", color = "#C9082A", se = TRUE) +
  labs(
    title = "Points vs Assists",
    x = "Assists per 36 Minutes",
    y = "Points per 36 Minutes"
  ) +
  theme_minimal()

cor_pts_ast <- cor(nba_data$PTS, nba_data$AST, use = "complete.obs")

ggsave(here::here("output/histogram_pts.png"), plot = hist_pts, width = 6, height = 4)
ggsave(here::here("output/scatter_pts_efg.png"), plot = scatter_efg, width = 6, height = 4)
ggsave(here::here("output/scatter_pts_ast.png"), plot = scatter_ast, width = 6, height = 4)
