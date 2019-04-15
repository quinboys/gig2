/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */

/*DROP VIEW IF EXISTS TempView;
CREATE VIEW TempView 
	AS
		SELECT DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month, ROUND(SUM(Sales.Total), 2) AS Total
        FROM Sales
        GROUP BY DATE_FORMAT(Sales.SaleDate, "%Y-%m") ASC;
        
SELECT * FROM TempView;*/

DROP VIEW IF EXISTS SalesTemp;
CREATE SQL SECURITY INVOKER VIEW SalesTemp
	AS
		SELECT 
			DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month,
			Sales.SaleID,
			TempView.Total
		FROM TempView, Sales
        WHERE SaleDate BETWEEN '2018-04-00' AND '2040-00-00'
		ORDER BY Sales.SaleDate; 

SELECT * FROM SalesTemp;

DROP VIEW IF EXISTS PercentageGrowth;
CREATE SQL SECURITY INVOKER VIEW PercentageGrowth 
	AS
		SELECT 
			DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month,
			Sales.SaleID,
            Sales.Total,
            Sales.Total as tempTotal,
			CONCAT(ROUND(((Sales.Total - SalesTemp.Total) / (
				SELECT SalesTemp.Total
                FROM SalesTemp
                #WHERE SaleDate BETWEEN '2018-05-00' AND '2040-00-00' 
                ORDER BY SalesTemp.Month
                LIMIT 1)) * 100, 2), "%") AS Growth
		FROM SalesTemp
		JOIN Sales ON SalesTemp.Month=DATE_FORMAT(Sales.SaleDate,"%Y-%m")
		GROUP BY Sales.SaleDate;
        
SELECT * FROM PercentageGrowth ORDER BY Month;

DROP VIEW PercentageGrowth;
DROP VIEW SalesTemp;
    

