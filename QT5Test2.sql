/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */

DROP VIEW IF EXISTS TempView;
CREATE VIEW TempView 
	AS
		SELECT DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month, ROUND(SUM(Sales.Total), 2) AS Total
        FROM Sales
        GROUP BY DATE_FORMAT(Sales.SaleDate, "%Y-%m") ASC;
        
SELECT * FROM TempView;

DROP VIEW IF EXISTS PercentageGrowth;
CREATE SQL SECURITY INVOKER VIEW PercentageGrowth 
	AS
		SELECT 
			DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month,
			Sales.SaleID,
            Sales.Total,
			CONCAT(ROUND(((TempView.Total - Sales.Total) / Sales.Total) * 100, 2), "%") AS Growth
		FROM TempView, Sales
		#JOIN Sales ON TempView.Month=DATE_FORMAT(Sales.SaleDate,"%Y-%m")
		GROUP BY Sales.SaleDate;
        
SELECT * FROM PercentageGrowth ORDER BY Month;

DROP VIEW PercentageGrowth;
DROP VIEW SalesTemp;
    

