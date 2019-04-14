/*3. (View) - Create a View of all stock (grouped by the supplier) */
CREATE VIEW SupplierStock AS
SELECT Stock.SupplierID, Supplier.CompanyName, Stock.StockID,  Stock.StockType AS Product
FROM Stock, Supplier
WHERE Stock.SupplierID = Supplier.SupplierID
GROUP BY Stock.SupplierID, Supplier.CompanyName, Stock.StockID;

SELECT * FROM SupplierStock;