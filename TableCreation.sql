DROP DATABASE Data_Mart;
CREATE DATABASE Data_Mart;
USE Data_Mart;

create table Payment (
	PaymentID INT,
	PaymentType VARCHAR(50),
	Charge INT,
    CONSTRAINT PAYMENT_PRIMARY_KEY PRIMARY KEY (PaymentID)
);

/*Filling data into Payments*/
insert into Payment values (1, 'Cash', 0);
insert into Payment values (2, 'Debit Card', 1);
insert into Payment values (3, 'Credit Card', 1);
insert into Payment values (4, 'Check', 0);

create table Supplier (
	SupplierID INT AUTO_INCREMENT,
	CompanyName VARCHAR(50),
	CEO VARCHAR(50),
	Phone VARCHAR(50),
	Email VARCHAR(50),
	Location VARCHAR(50),
    CONSTRAINT SUPPLIER_PRIMARY_KEY PRIMARY KEY (SupplierID)
);

/*Filling data into Suppliers*/
insert into Supplier values (1, 'Mynte', 'Lemuel Smolan', '706-399-1297', 'lsmolan0@nyu.edu', 'Koanara');
insert into Supplier values (2, 'Wordpedia', 'Bunnie Clooney', '889-114-3510', 'bclooney1@gmpg.org', 'Dayong');
insert into Supplier values (3, 'Skyndu', 'Gertrudis Dobbson', '791-756-5180', 'gdobbson2@plala.or.jp', 'Wola Sernicka');
insert into Supplier values (4, 'Oodoo', 'Humfried Martinson', '772-354-7773', 'hmartinson3@blogger.com', 'Gustavsberg');
insert into Supplier values (5, 'Oyondu', 'Clyve Sleany', '840-250-7955', 'csleany4@home.pl', 'Mukō');
insert into Supplier values (6, 'Ntags', 'Sallee Hendonson', '670-695-1050', 'shendonson5@csmonitor.com', 'Lidköping');
insert into Supplier values (7, 'Zava', 'Nobe Champe', '791-330-1537', 'nchampe6@g.co', 'Pingqiao');
insert into Supplier values (8, 'Photospace', 'Reid Randal', '822-919-6734', 'rrandal7@fema.gov', 'Santiago');
insert into Supplier values (9, 'Tagpad', 'Ailbert Merman', '202-767-8370', 'amerman8@va.gov', 'Talpe');
insert into Supplier values (10, 'Livetube', 'Alaine Doogue', '551-397-0659', 'adoogue9@mit.edu', 'Jaga');

create table Customer (
	CustomerID INT AUTO_INCREMENT,
	CustomerName VARCHAR(50),
	City VARCHAR(50),
	Phone VARCHAR(50),
	Email VARCHAR(50),
    CONSTRAINT CUSTOMER_PRIMARY_KEY PRIMARY KEY (CustomerID)
);

/*Filling data into Customers*/
insert into Customer values (1, 'Lazzy', 'Irving', '214-570-5865', 'jpaver0@multiply.com');
insert into Customer values (2, 'Kazu', 'Guan’e', '108-784-0493', 'bgawthrope1@europa.eu');
insert into Customer values (3, 'Trilia', 'Jabungsisir', '730-133-1753', 'mrix2@addthis.com');
insert into Customer values (4, 'Topicware', 'Stockholm', '151-114-5507', 'lwhelpdale3@yellowpages.com');
insert into Customer values (5, 'Jabbersphere', 'Belas', '477-257-3330', 'gbranca4@clickbank.net');
insert into Customer values (6, 'Blogtag', 'Žacléř', '736-340-4668', 'mbillborough5@example.com');
insert into Customer values (7, 'Kamba', 'Jinchang', '778-722-7892', 'volliff6@paginegialle.it');
insert into Customer values (8, 'Topicshots', 'Yizhivtsi', '664-349-6115', 'tchampionnet7@topsy.com');
insert into Customer values (9, 'Nlounge', 'Tambillo', '113-895-8345', 'ebonass8@bloomberg.com');
insert into Customer values (10, 'Cogilith', 'Sampaloc', '697-957-3623', 'gmccorry9@fotki.com');
insert into Customer values (11, 'Photobug', 'Ergong', '934-879-3933', 'pvreedea@slashdot.org');
insert into Customer values (12, 'Mita', 'Uppsala', '453-488-0381', 'ggianneschib@adobe.com');

create table History (
	UpdateID INT AUTO_INCREMENT,
	CustomerID INT,
	OldNumber VARCHAR(50),
	OldEmail VARCHAR(50),
	UpdateDate DATE,
    CONSTRAINT HISTORY_PRIMARY_KEY PRIMARY KEY (UpdateID),
    CONSTRAINT History_FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
);

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

/*Filling some data into History*/
insert into History (UpdateID, CustomerID, OldNumber, OldEmail, UpdateDate) values (1, 5, '218-684-3947', 'nbromage0@mac.com', '2019-01-05');
insert into History (UpdateID, CustomerID, OldNumber, OldEmail, UpdateDate) values (2, 3, '929-454-1653', 'bchanson1@blogtalkradio.com', '2019-03-17');
insert into History (UpdateID, CustomerID, OldNumber, OldEmail, UpdateDate) values (3, 9, '841-395-6086', 'jsommersett2@com.com', '2018-05-14');
insert into History (UpdateID, CustomerID, OldNumber, OldEmail, UpdateDate) values (4, 7, '484-851-0774', 'dcicchinelli3@exblog.jp', '2018-12-23');
insert into History (UpdateID, CustomerID, OldNumber, OldEmail, UpdateDate) values (5, 8, '258-980-3653', 'dfurmagier4@bing.com', '2018-07-04');
insert into History (UpdateID, CustomerID, OldNumber, OldEmail, UpdateDate) values (6, 5, '968-821-2623', 'rlehr5@msn.com', '2019-02-21');
insert into History (UpdateID, CustomerID, OldNumber, OldEmail, UpdateDate) values (7, 4, '374-200-4507', 'dschimaschke6@wired.com', '2019-02-24');
insert into History (UpdateID, CustomerID, OldNumber, OldEmail, UpdateDate) values (8, 4, '655-393-3708', 'vcovet7@apache.org', '2018-05-12');
insert into History (UpdateID, CustomerID, OldNumber, OldEmail, UpdateDate) values (9, 7, '501-702-5138', 'amarley8@sciencedirect.com', '2019-03-01');
insert into History (UpdateID, CustomerID, OldNumber, OldEmail, UpdateDate) values (10, 9, '706-140-8143', 'rtoleman9@taobao.com', '2018-06-19');

create table Stock (
	StockID INT AUTO_INCREMENT,
	SupplierID INT,
	StockType VARCHAR(50),
	Quantity INT,
	Price VARCHAR(50),
    CONSTRAINT STOCK_PRIMARY_KEY PRIMARY KEY (StockID),
    CONSTRAINT Stock_FK_SupplierID FOREIGN KEY (SupplierID) REFERENCES Supplier (SupplierID)
);

/*Filling data into Stock*/
insert into Stock values (1, 4, 'Shoes', 10169, '21.55');
insert into Stock values (2, 10, 'Sports', 10273, '20.07');
insert into Stock values (3, 10, 'Health', 10791, '60.00');
insert into Stock values (4, 4, 'Outdoors', 12199, '95.59');
insert into Stock values (5, 1, 'Beauty', 10531, '37.68');
insert into Stock values (6, 9, 'Games', 12892, '27.18');
insert into Stock values (7, 3, 'Books', 11301, '27.53');
insert into Stock values (8, 9, 'Garden', 11998, '48.03');
insert into Stock values (9, 8, 'Baby', 10141, '44.14');
insert into Stock values (10, 8, 'Garden', 12932, '38.51');
insert into Stock values (11, 3, 'Baby', 12907, '63.40');
insert into Stock values (12, 1, 'Kids', 12869, '20.32');
insert into Stock values (13, 7, 'Games', 10939, '23.77');
insert into Stock values (14, 6, 'Grocery', 11700, '56.21');
insert into Stock values (15, 8, 'Health', 12924, '68.65');

create table Sales (
	SaleID INT AUTO_INCREMENT,
	CustomerID INT,
	StockID INT,
	PaymentID INT,
	SaleDate DATE,
	Quantity INT,
	VAT VARCHAR(50),
	Total VARCHAR(50),
    CONSTRAINT Sales_PRIMARY_KEY PRIMARY KEY (SaleID),
    CONSTRAINT Sales_FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
    CONSTRAINT Sales_FK_StockID FOREIGN KEY (StockID) REFERENCES Stock (StockID),
    CONSTRAINT Sales_FK_PaymentID FOREIGN KEY (PaymentID) REFERENCES Payment (PaymentID)
);

/*2. Trigger to update Stock quantity upon new entries in the sales table.*/
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

/*Adding Sales to the Sales table*/
insert into Sales values (1, 11, 15, 3, '2018-04-12', 98, '2.34', '310.64');
insert into Sales values (2, 10, 14, 4, '2018-11-29', 182, '3.94', '1365.51');
insert into Sales values (3, 4, 3, 4, '2018-05-02', 81, '3.16', '2160.62');
insert into Sales values (4, 11, 3, 2, '2018-09-27', 210, '4.98', '1540.71');
insert into Sales values (5, 4, 6, 2, '2018-10-08', 28, '4.73', '2024.90');
insert into Sales values (6, 6, 8, 3, '2018-06-27', 34, '4.45', '1087.89');
insert into Sales values (7, 8, 7, 2, '2018-08-04', 132, '2.34', '1030.54');
insert into Sales values (8, 8, 3, 4, '2019-02-10', 201, '4.18', '620.86');
insert into Sales values (9, 9, 11, 1, '2018-05-16', 169, '2.42', '530.43');
insert into Sales values (10, 3, 6, 3, '2018-04-01', 43, '4.90', '473.81');
insert into Sales values (11, 1, 6, 3, '2018-05-28', 154, '2.77', '372.77');
insert into Sales values (12, 7, 13, 4, '2018-05-30', 203, '2.05', '1628.58');
insert into Sales values (13, 6, 4, 1, '2018-06-14', 64, '3.90', '587.51');
insert into Sales values (14, 5, 5, 4, '2018-07-26', 121, '3.75', '2314.54');
insert into Sales values (15, 8, 1, 4, '2019-03-13', 229, '2.62', '2363.80');
insert into Sales values (16, 8, 7, 2, '2018-04-09', 248, '4.53', '1672.62');
insert into Sales values (17, 11, 3, 4, '2019-03-13', 227, '3.90', '1717.12');
insert into Sales values (18, 8, 15, 4, '2018-09-19', 158, '3.74', '290.63');
insert into Sales values (19, 2, 14, 3, '2018-04-19', 69, '2.34', '1477.49');
insert into Sales values (20, 6, 4, 4, '2018-07-20', 179, '3.03', '1561.10');
insert into Sales values (21, 5, 14, 3, '2018-05-11', 117, '2.83', '635.50');
insert into Sales values (22, 2, 14, 4, '2018-12-10', 189, '4.62', '1907.73');
insert into Sales values (23, 12, 4, 2, '2018-06-24', 213, '4.18', '718.67');
insert into Sales values (24, 4, 8, 1, '2018-04-21', 118, '2.22', '806.98');
insert into Sales values (25, 9, 5, 3, '2019-03-15', 76, '4.89', '1287.94');

create table Returns (
	ReturnID INT AUTO_INCREMENT,
	SaleID INT,
	Date DATE,
    CONSTRAINT Returns_PRIMARY_KEY PRIMARY KEY (ReturnID),
    CONSTRAINT Returns_FK_SaleID FOREIGN KEY (SaleID) REFERENCES Sales (SaleID)
);

/*Adding some returns to the Returns table*/
insert into Returns values (1, 11, '2018-10-20');
insert into Returns values (2, 5, '2018-10-14');
insert into Returns values (3, 1, '2019-01-22');
insert into Returns values (4, 1, '2019-03-21');
insert into Returns values (5, 23, '2019-02-17');
insert into Returns values (6, 13, '2018-10-30');
insert into Returns values (7, 19, '2018-12-25');
insert into Returns values (8, 14, '2018-12-01');
insert into Returns values (9, 24, '2018-11-27');
insert into Returns values (10, 16, '2019-02-07');