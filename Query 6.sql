/*6. (Stored Procedure) - Create a stored procedure that will display all orders by customer and their county. */
DELIMITER //
CREATE PROCEDURE CustomerOrders
()
BEGIN
  SELECT Sales.SaleID, Sales.CustomerID, Customer.CustomerName, Customer.City
  FROM Sales, Customer
  WHERE Sales.CustomerID = Customer.CustomerID;
END //
DELIMITER ;

CALL CustomerOrders();