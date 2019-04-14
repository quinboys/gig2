/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */

#SELECT Total FROM Sales prev WHERE prev.Total < Total)

CREATE TABLE IF NOT EXISTS SalesTemp LIKE Sales;
	INSERT SalesTemp
	SELECT *
	FROM Sales;

DROP VIEW IF EXISTS PercentageGrowth;
CREATE VIEW PercentageGrowth 
AS
     SELECT 
		DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month,
        Sales.Total,
		(CONCAT(ROUND((100 * Sales.Total / (SELECT SalesTemp.Total FROM SalesTemp WHERE SalesTemp.SaleID > 2)), 2), "%")) AS Growth
	FROM Sales
    GROUP BY DATE_FORMAT(Sales.SaleDate, "%Y-%m");
    
DROP TABLE SalesTemp;
    
SELECT * FROM PercentageGrowth;
