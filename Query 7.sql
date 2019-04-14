/*7. (Stored Procedure) - Create a stored procedure that will display all returns, grouped by month. */
DELIMITER //
CREATE PROCEDURE Returns
()
BEGIN
  SELECT DATE_FORMAT(Date, "%Y-%m") AS Month, Returns.ReturnID, Returns.SaleID, Customer.CustomerName, Stock.StockType 
  FROM Returns, Sales, Customer, Stock
  WHERE Returns.SaleID = Sales.SaleID AND Sales.CustomerID = Customer.CustomerID AND Sales.StockID = Stock.StockID
  GROUP BY DATE_FORMAT(Date, "%Y-%m"), ReturnID;
END //
DELIMITER ;

CALL Returns();