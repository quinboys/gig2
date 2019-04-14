/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */

#SELECT Total FROM Sales prev WHERE prev.Total < Total)

#DROP VIEW PercentageGrowth;
CREATE VIEW PercentageGrowth 
AS
	SELECT 
		DATE_FORMAT(Sales.SaleDate, "%Y-%m") as Month,
        Sales.Total,
		CONCAT((COUNT(Sales.Total) / (COUNT(Sales.Total-1))), "%") AS Growth
	FROM Sales
    GROUP BY DATE_FORMAT(Sales.SaleDate, "%Y-%m");
      
      
SELECT * FROM PercentageGrowth;