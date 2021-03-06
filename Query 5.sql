/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */

#5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. 
DROP VIEW IF EXISTS PercentageSalesGrowth;
CREATE VIEW PercentageSalesGrowth 
    AS 
        SELECT Month,
			SUM(Total) AS TotalPerMonth,
            CONCAT(CAST(ROUND(COALESCE( 100 * (TotalPerMonth-LAG(TotalPerMonth) OVER (ORDER BY 'Month' ASC)) / LAG(TotalPerMonth) 
            OVER (ORDER BY 'Month' ASC), 0), 2) AS CHAR), '%') 'Percent Change',
            ROUND(TotalPerMonth, 2) AS "Total Sales In Month" FROM (SELECT DATE_FORMAT(SaleDate, "%Y-%m") AS Month
			FROM SALES 
        GROUP BY DATE_FORMAT(SaleDate, "%Y-%m")) SALES;

# Test code 
SELECT * FROM PercentageSalesGrowth;
