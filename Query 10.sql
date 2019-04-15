/*10. (View) - Create a View that will display a breakdown of (a) sales (b) profit and (c) returns for each month of the year. */
DROP VIEW IF EXISTS SalesPerMonth;
CREATE VIEW SalesPerMonth 
	AS
		SELECT DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month, COUNT(Sales.SaleID) AS Total_Sales,
		Round(SUM(Sales.Total),2) AS TotalRevenueForMonth
		FROM Sales
		GROUP BY DATE_FORMAT(SaleDate, "%Y-%m");

SELECT * FROM SalesPerMonth;

DROP VIEW IF EXISTS ReturnsPerMonth;
CREATE VIEW ReturnsPerMonth
	AS
		SELECT DATE_FORMAT(Date, "%Y-%m") AS Month, COUNT(ReturnID) AS Total_Returns
		FROM Returns
		GROUP BY DATE_FORMAT(Date, "%Y-%m");

SELECT * FROM ReturnsPerMonth;

DROP VIEW IF EXISTS ProfitByMonth;
CREATE VIEW ProfitByMonth 
	AS
		SELECT SalesPerMonth.Month, SalesPerMonth.Total_Sales AS Sales, SalesPerMonth.TotalRevenueForMonth, ReturnsPerMonth.Total_Returns
			FROM SalesPerMonth
				LEFT JOIN ReturnsPerMonth
				ON SalesPerMonth.Month = ReturnsPerMonth.Month
			ORDER BY SalesPerMonth.Month ASC;    
    
SELECT * FROM ProfitByMonth;