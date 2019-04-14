/*4. (Stored Procedure) - Detail and total all sales for the year, group these by each month. (A Group By with RollUp) */
DELIMITER //
CREATE PROCEDURE MonthlySales
()
BEGIN
  SELECT DATE_FORMAT(SaleDate, "%Y-%m") AS Month, COUNT(SaleID) as TotalSalesForMonth, sum(cast(Total AS DECIMAL(10,2))) as TotalIncomeForMonth
  FROM Sales, Stock
  WHERE Sales.StockID = Stock.StockID
  GROUP BY DATE_FORMAT(SaleDate, "%Y-%m");
END //
DELIMITER ;

CALL MonthlySales();