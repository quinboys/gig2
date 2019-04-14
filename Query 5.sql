/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */

DROP VIEW IF EXISTS SalesTemp;
CREATE SQL SECURITY INVOKER VIEW SalesTemp
	AS
		SELECT 
			DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month,
			Sales.SaleID,
			Sales.Total
		FROM Sales
		WHERE SaleID > 1
		GROUP BY DATE_FORMAT(Sales.SaleDate, "%Y-%m"); 

SELECT * FROM SalesTemp;

DROP VIEW IF EXISTS PercentageGrowth;
CREATE SQL SECURITY INVOKER VIEW PercentageGrowth 
	AS
		SELECT 
			DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month,
			Sales.Total,
			(CONCAT(ROUND((100 * (SELECT SalesTemp.Total FROM SalesTemp) / Sales.Total), 2), "%")) AS Growth
		FROM Sales
		GROUP BY DATE_FORMAT(Sales.SaleDate, "%Y-%m");
    
DROP VIEW SalesTemp;
    
SELECT * FROM PercentageGrowth;
