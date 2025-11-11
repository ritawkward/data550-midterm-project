#add other make rules here

# Generate Summary Table 
output/table1.rds: code/01_summary_table.R data/raw_nba_2025-10-30.csv
	Rscript code/01_summary_table.R
	
# Generate Regression Results
output/reg_model.rds output/reg_coef_table.rds output/reg_fit_stats.rds output/reg_augmented.rds output/reg_pred_vs_actual.png: code/04_regression.R data/raw_nba_2025-10-30.csv
	Rscript code/04_regression.R
	
.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html
