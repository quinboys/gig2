/*1. (View) - Show all transactions for ANY given week (you decide the dates). */
CREATE VIEW WeeklyStatistic AS
SELECT * FROM Sales 
WHERE SaleDate between CAST('2019-03-11' AS DATE) and CAST('2019-03-18' AS DATE);

/*2. (Trigger) - Create a Trigger that updates stock levels once a sale takes place. */
DELIMITER $$
CREATE TRIGGER Stock_update
    BEFORE INSERT ON Sales
    FOR EACH ROW
    BEGIN

    UPDATE Stock SET
    Quantity = Quantity - NEW.Quantity,
    StockID = StockID;
END$$
DELIMITER ;

/*Below is the code to test if the StockLevels_update trigger is working.*/
/*
SELECT * FROM Stock WHERE StockID = 1;

insert into Sales values (47, 2, 1, 4, '2018-10-27', 1000, '2.74', '176.56');

SELECT * FROM Stock WHERE StockID = 1 ;
*/

/*3. (View) - Create a View of all stock (grouped by the supplier) */
CREATE VIEW SupplierStock AS
SELECT Stock.SupplierID, Supplier.CompanyName, Stock.StockID,  Stock.StockType AS Product
FROM Stock, Supplier
WHERE Stock.SupplierID = Supplier.SupplierID
GROUP BY Stock.SupplierID, Supplier.CompanyName, Stock.StockID;


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

/*5. (View) - Display the growth in sales (as a percentage) for your business, from the 1st month of opening until the end of the year. */
CREATE VIEW MontlyGrowthStatistic AS
SELECT *
FROM Finance
GROUP BY Finance.LogID;


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

/*7. (Stored Procedure) - Create a stored procedure that will display all returns, grouped by month. */
DELIMITER //
CREATE PROCEDURE Returns
()
BEGIN
  SELECT DATE_FORMAT(Date, "%Y-%m"), Returns.ReturnID, Returns.SaleID, Customer.CustomerName, Stock.StockType 
  FROM Returns, Sales, Customer, Stock
  WHERE Returns.SaleID = Sales.SaleID AND Sales.CustomerID = Customer.CustomerID AND Sales.StockID = Stock.StockID
  GROUP BY DATE_FORMAT(Date, "%Y-%m"), ReturnID;
END //
DELIMITER ;

CALL Returns();

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


/*9. (Trigger) - Create a Trigger that will populate a ‘history table’ once a customers contact details have been updated. */
DELIMITER $$
CREATE TRIGGER History_update
    AFTER UPDATE ON Customer
    FOR EACH ROW
    BEGIN

    INSERT INTO History SET
    OldNumber = OLD.Phone,
    OldEmail = OLD.Email,
    CustomerID = OLD.CustomerID,
    UpdateDate = CURDATE();
END$$
DELIMITER ;

/* TRIGGER TEST CODE

SELECT * FROM History;
SELECT * FROM Customer;

update Customer
set Email = 'NEW@EMAIL.COM'
where CustomerID = 2;

update Customer
set Phone = '+44 NEW PHONE NUMBER 1'
where CustomerID = 1;

SELECT * FROM History;
SELECT * FROM Customer;

*/

/*10. (View) - Create a View that will display a breakdown of (a) sales (b) profit and (c) returns for each month of the year. */
CREATE VIEW ProfitByMonths AS
SELECT DATE_FORMAT(SaleDate, "%Y-%m"), Sales.SaleID, Customer.CustomerName, Stock.StockType, Sales.Quantity, Sales.Total
FROM Sales, Customer, Stock
WHERE Sales.CustomerID = Customer.CustomerID AND Sales.StockID = Stock.StockID
GROUP BY DATE_FORMAT(SaleDate, "%Y-%m"), Sales.SaleID;