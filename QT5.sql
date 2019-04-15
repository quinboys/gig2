DROP VIEW IF EXISTS PercentageSalesGrowth;
CREATE VIEW PercentageSalesGrowth 
	AS 
		SELECT 
			SUM(Total) AS TotalPerMonth,
			ROUND(TotalPerMonth, 2) AS "Total Sales In Month",
            CONCAT(CAST(ROUND(COALESCE( 100 * (TotalPerMonth-LAG(TotalPerMonth) WHERE (ORDER BY 'Month' ASC)) / LAG(TotalPerMonth) OVER (ORDER BY 'Month' ASC), 0), 2) AS CHAR), '%') 'Percent Change'
        FROM SALES 
        GROUP BY DATE_FORMAT(SaleDate, "%Y-%m")) SALES;

/* Test code */ 
SELECT * FROM PercentageSalesGrowth;