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