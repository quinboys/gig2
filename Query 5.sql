/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */

DROP VIEW IF EXISTS SalesTemp;
CREATE VIEW SalesTemp
	AS
		SELECT 
			SaleID,
			Total
		FROM Sales
		WHERE SaleID > 1;

SELECT * FROM SalesTemp;

DROP VIEW IF EXISTS PercentageGrowth;
CREATE VIEW PercentageGrowth 
	AS
		SELECT 
			DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month,
			Sales.Total,
			(CONCAT(ROUND((100 * Sales.Total / (SELECT SalesTemp.Total FROM SalesTemp)), 2), "%")) AS Growth
		FROM Sales
		GROUP BY DATE_FORMAT(Sales.SaleDate, "%Y-%m");
    
DROP VIEW SalesTemp;
    
SELECT * FROM PercentageGrowth;
