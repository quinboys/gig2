/*1. (View) - Show all transactions for ANY given week (you decide the dates). */
CREATE VIEW WeeklyStatistic 
	AS
		SELECT * FROM Sales 
		WHERE SaleDate between CAST('2019-03-11' AS DATE) and CAST('2019-03-18' AS DATE);

SELECT * FROM WeeklyStatistic;