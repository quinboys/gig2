

DROP VIEW IF EXISTS TempView;
CREATE VIEW TempView 
	AS
		SELECT DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month, ROUND(SUM(Sales.Total), 2) AS Total
        FROM Sales
        GROUP BY DATE_FORMAT(Sales.SaleDate, "%Y-%m") ASC;
        
SELECT * FROM TempView;

DROP VIEW IF EXISTS SalesTemp;
CREATE VIEW SalesTemp 
	AS
		SELECT TempView.Month, TempView.Total
        FROM TempView, Sales
        GROUP BY DATE_FORMAT(TempView.Month, "%Y-%m") ASC;
        
SELECT * FROM SalesTemp;