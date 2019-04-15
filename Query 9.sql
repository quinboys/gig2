/*9. (Trigger) - Create a Trigger that will populate a ‘history table’ once a customers contact details have been updated. */
DELIMITER $$
DROP TRIGGER IF EXISTS History_update;
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

/* TRIGGER TEST CODE */

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