# Midterm Project: NBA player statistics

This project analyzes NBA player performance based on per-36-minute statistics (as of October 30, 2025) using data from Basketball Reference. You can build the report by typing `make` in the terminal.

---

## Code Description

### `code/01_summary_table.R`

-   Reads `data/raw_nba_2025-10-30.csv`.
-   Creates a descriptive summary table (Table 1) of NBA player characteristics using **gtsummary**.
-   Saves outputs as **`output/table1.rds`**.

### `code/02_summary_graphs.R`

- Reads `data/raw_nba_2025-10-30.csv`.
- Creates a histogram of points per 36 minutes for all players.
- Creates scatter plots to show relationships between points per 36 minutes and:
  - Effective field goal percentage (shooting efficiency)
  - Assists
- Saves outputs as:
  - **`output/histogram_pts.png`**
  - **`output/scatter_pts_efg.png`**
  - **`output/scatter_pts_ast.png`**

### `code/03_ranking.R`

- Reads `data/raw_nba_2025-10-30.csv`.
- Selects the top 10 players by points (PTS).
- Scales key performance metrics (`PTS`, `AST`, `TRB`, `FG%`, `3P%`, `FT%`, `eFG%`) to a 0-1 range.
- Creates a heatmap of relative performance across metrics using **ggplot2**.
- Saves the figure as **`output/ranking_plot.png`**.

### `code/04_regression.R`

- Reads `data/raw_nba_2025-10-30.csv`.
- Fits a linear regression model predicting points per 36 minutes from shooting and assist metrics.
- Saves model objects, summary tables, and the **Predicted vs. Actual plot** to the `output/` folder:
  - `output/reg_model.rds`
  - `output/reg_coef_table.rds`
  - `output/reg_fit_stats.rds`
  - `output/reg_augmented.rds`
  - `output/reg_pred_vs_actual.png`

### `code/05_regression.R`

- Uses **`rmarkdown::render()`** to compile the final R Markdown report (`NBA_Report.Rmd`).
- Pulls in the saved tables and figures from `output/`.
- Produces the final HTML report:
  - **`final_project_report.html`**

------------------------------------------------------------------------

## Report Description

### `NBA_Report.Rmd`

1. **Introduction**  
   Brief overview of the NBA per-36-minute dataset and the motivation for evaluating player performance using standardized metrics.

2. **Summary Table**  
   Loads the summary table saved in `output/table1.rds` and presents key per-36-minute statistics for players.

3. **Exploratory Visualizations**  
   Displays the histogram and scatterplots generated in `02_summary_graphs.R` to illustrate scoring distributions and relationships between points, shooting efficiency, and assists.

4. **Top-10 Player Ranking**  
   Shows the heatmap from `output/ranking_plot.png`, summarizing standardized performance metrics for the top ten scorers.

5. **Regression Analysis**  
   Incorporates saved model outputs (`reg_model.rds`, coefficient table, fit statistics, augmented data) and the predicted-vs-actual plot to describe factors associated with points per 36 minutes.

6. **Conclusion**  
   Provides a brief summary of findings across the descriptive, graphical, ranking, and regression components.

------------------------------------------------------------------------

## Report customization

The report is parameterized through the YAML header in `NBA_Report.Rmd`. The main parameters are:

- **`params$top_n`**  
  Controls how many players are highlighted in the ranking sections of the report (e.g., Top 10, Top 15). This affects summary tables/text that refer to the "top N" players. You can directly make the report with the number you want running `TOP_N=your_number make`. Unless you specify this, the report will build with top 10 as default.
  
- **`params$cutoff_date`**  
  Stores the reference date for the dataset (e.g., `"October 30, 2025"`). This value is used in figure captions and narrative text so the report clearly states the time frame of the data.

- **`params$outcome_label`**  
  Controls how the primary outcome is described in the report text and figure titles (e.g., `"points per 36 minutes"`). The current analysis uses points per 36 minutes as the outcome in all models and plots.
