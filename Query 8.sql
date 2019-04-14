/*8. (Stored Procedure) - Display a specific customers details and all of their relevant orders to date by passing a parameter (eg: CustomerID). */
DELIMITER //
CREATE PROCEDURE CustomerDetails
(IN ID INT)
BEGIN
  SELECT Customer.CustomerName, Customer.City, Customer.Phone, Sales.SaleID, Stock.StockType, Sales.Quantity, Sales.SaleDate
  FROM Customer, Sales, Stock
  WHERE Customer.CustomerID = Sales.CustomerID AND Sales.StockID = Stock.StockID AND ID = Customer.CustomerID;
END //
DELIMITER ;

CALL CustomerDetails(4);