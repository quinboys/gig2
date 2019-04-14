/*10. (View) - Create a View that will display a breakdown of (a) sales (b) profit and (c) returns for each month of the year. */
CREATE VIEW ProfitByMonths AS
SELECT DATE_FORMAT(SaleDate, "%Y-%m"), Sales.SaleID, Customer.CustomerName, Stock.StockType, Sales.Quantity, Sales.Total
FROM Sales, Customer, Stock
WHERE Sales.CustomerID = Customer.CustomerID AND Sales.StockID = Stock.StockID
GROUP BY DATE_FORMAT(SaleDate, "%Y-%m"), Sales.SaleID;