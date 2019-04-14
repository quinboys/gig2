/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */

CREATE FUNCTION test()
	retval := CONCAT(CAST(ROUND(IF(@last_entry = 0, "0", ((TotalSalesInMonth - @last_entry) / @last_entry) * 100), 2) AS CHAR), "%")
    RETURN retval;

/* !FIXME */

CREATE VIEW PercentageSalesGrowth
AS
SELECT Month,
       CONCAT(CAST(ROUND(IF(@last_entry = 0,
          "0",
          ((TotalSalesInMonth - @last_entry) / @last_entry) * 100), 2) AS CHAR), "%") AS "Percentage Growth In Sales",
       @last_entry := ROUND(TotalSalesInMonth, 2) AS "Total Sales In Month"       
FROM
      (SELECT @last_entry := 0) LastEntry,
      (SELECT DATE_FORMAT(SaleDate, "%Y-%m") AS Month,
       SUM(Total) AS TotalSalesInMonth
       FROM SALES
       GROUP BY DATE_FORMAT(SaleDate, "%Y-%m")) SALES;