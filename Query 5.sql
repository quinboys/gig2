/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */

DROP VIEW IF EXISTS SalesTemp;
CREATE SQL SECURITY INVOKER VIEW SalesTemp
	AS
		SELECT 
			DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month,
			Sales.SaleID,
			Sales.Total
		FROM Sales
        WHERE SaleDate BETWEEN '2018-05-00 00:00:00' AND '2040-00-00 00:00:00'
		GROUP BY DATE_FORMAT(Sales.SaleDate, "%Y-%m"); 

SELECT * FROM SalesTemp;

DROP VIEW IF EXISTS PercentageGrowth;
CREATE SQL SECURITY INVOKER VIEW PercentageGrowth 
	AS
		SELECT 
			DATE_FORMAT(Sales.SaleDate, "%Y-%m") AS Month,
			Sales.SaleID,
            Sales.Total,
			CONCAT(ROUND((100 * (SELECT SalesTemp.Total 
								FROM SalesTemp 
                                WHERE SaleDate BETWEEN '2018-05-00 00:00:00' AND '2040-00-00 00:00:00' 
                                ORDER BY DATE_FORMAT(SalesTemp.Month, "%Y-%m") 
                                LIMIT 1) / Sales.Total), 2), "%") AS Growth
		
        FROM Sales, SalesTemp
		GROUP BY DATE_FORMAT(Sales.SaleDate, "%Y-%m");
    
SELECT * FROM PercentageGrowth;

DROP VIEW PercentageGrowth;
DROP VIEW SalesTemp;
    

