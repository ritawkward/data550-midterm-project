final_project_report.html: code/05_render_report.R NBA_Report.Rmd \
  output/table1.rds \
  output/histogram_pts.png output/scatter_pts_efg.png output/scatter_pts_ast.png \
  output/ranking_plot.png \
  output/reg_model.rds output/reg_coef_table.rds output/reg_fit_stats.rds \
  output/reg_augmented.rds output/reg_pred_vs_actual.png
	Rscript code/05_render_report.R

output/table1.rds: code/01_summary_table.R data/raw_nba_2025-10-30.csv
	Rscript code/01_summary_table.R

output/histogram_pts.png output/scatter_pts_efg.png output/scatter_pts_ast.png: code/02_summary_graphs.R data/raw_nba_2025-10-30.csv
	Rscript code/02_summary_graphs.R

output/ranking_plot.png: code/03_ranking.R data/raw_nba_2025-10-30.csv
	Rscript code/03_ranking.R

output/reg_model.rds output/reg_coef_table.rds output/reg_fit_stats.rds output/reg_augmented.rds output/reg_pred_vs_actual.png: code/04_regression.R data/raw_nba_2025-10-30.csv
	Rscript code/04_regression.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html && rm -f *.pdf