#add other make rules here






output/table1.rds: code/01_summary_table.R raw_data/nba_2025-10-30.csv
	Rscript code/01_summary_table.R
	
.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html
