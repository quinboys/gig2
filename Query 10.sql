/*10. (View) - Create a View that will display a breakdown of (a) sales (b) profit and (c) returns for each month of the year. */
/*DROP VIEW IF EXISTS ProfitByMonth;
CREATE VIEW ProfitByMonth AS
SELECT DATE_FORMAT(SaleDate, "%Y-%m") as Month , Sales.SaleID, Customer.CustomerName, Stock.StockType, Sales.Quantity, Sales.Total
FROM Sales, Customer, Stock
WHERE Sales.CustomerID = Customer.CustomerID AND Sales.StockID = Stock.StockID
GROUP BY DATE_FORMAT(SaleDate, "%Y-%m"), Sales.SaleID;

SELECT * FROM ProfitByMonth;*/

DROP VIEW IF EXISTS SalesPerMonth;
CREATE VIEW SalesPerMonth AS
SELECT DATE_FORMAT(SaleDate, "%Y-%m") AS Month, COUNT(SaleID) AS Total_Sales,
Round(SUM(Total),2) AS TotalRevenueForMonth
FROM Sales
GROUP BY DATE_FORMAT(SaleDate, "%Y-%m");

SELECT * FROM SalesPerMonth;

DROP VIEW IF EXISTS ReturnsPerMonth;
CREATE VIEW RturnsPerMonth
SELECT DATE_FORMAT(Date, "%Y-%m") AS Month, COUNT(ReturnID) AS Total_Returns
FROM Returns
GROUP BY DATE_FORMAT(Date, "%Y-%m");

SELECT * FROM ReturnsPerMonth;

/*DROP VIEW IF EXISTS WeeklyStatistic;
CREATE VIEW WeeklyStatistic AS
SELECT * FROM Sales 
WHERE SaleDate between CAST('2018-04-01' AS DATE) and CAST('2018-04-30' AS DATE);

SELECT * FROM WeeklyStatistic;

SELECT * FROM Sales;/*
