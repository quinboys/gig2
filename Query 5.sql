/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */

DROP VIEW PercentageGrowth;
CREATE VIEW PercentageGrowth 
AS
	SELECT 
		DATE_FORMAT(SaleDate, "%Y-%m") as Month,
        Total,
		Total / (SELECT Total FROM Sales prev WHERE prev.Total < Total) AS Percentage
	FROM Sales;
      
      
SELECT * FROM PercentageGrowth;