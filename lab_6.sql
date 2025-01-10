
-- Create the Products table
CREATE TABLE Products (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);

-- Insert data into the Products table
INSERT INTO Products (Product_id, Product_Name, Price) VALUES
(1, 'Smartphone', 35000),
(2, 'Laptop', 65000),
(3, 'Headphones', 5500),
(4, 'Television', 85000),
(5, 'Gaming Console', 32000);
--Part - A
SELECT * FROM Products
--1. Create a cursor Product_Cursor to fetch all the rows from a products table.
Declare @Product_id INT,@Product_Name VARCHAR(50), @Price DECIMAL(8,2)

Declare cr_all_Detail Cursor
for
	select * from Products

open cr_all_Detail

fetch next FROM cr_all_Detail INTO  @Product_id,@Product_Name,@Price

WHILE @@FETCH_STATUS=0

 BEGIN
  PRINT  CAST(@Product_id AS VARCHAR(50))+ ' '+@Product_Name+ ' ' +CAST(@Price AS VARCHAR(50))

  fetch next FROM cr_all_Detail INTO  @Product_id,@Product_Name,@Price
 END;
 
 CLOSE cr_all_Detail
 DEALLOCATE cr_all_Detail

--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.
--(Example: 1_Smartphone)

DECLARE @PID VARCHAR(50), @PNAME VARCHAR(50)

DECLARE CR_PRNAME CURSOR
FOR		

	SELECT Product_id,Product_Name FROM Products

OPEN CR_PRNAME

FETCH NEXT FROM CR_PRNAME INTO @PID,@PNAME

WHILE @@FETCH_STATUS=0
BEGIN
        PRINT '_'+CAST(@PID AS VARCHAR(50)) +'_'++ @PNAME

		FETCH NEXT FROM CR_PRNAME INTO @PID,@PNAME
END
CLOSE CR_PRNAME
DEALLOCATE CR_PRNAME
--3. Create a Cursor to Find and Display Products Above Price 30,000.

DECLARE @PNA VARCHAR (50)
DECLARE CR_PRODUCT CURSOR
FOR
 SELECT  Product_Name FROM Products
 WHERE PRICE >3000

OPEN CR_PRODUCT

FETCH NEXT FROM CR_PRODUCT INTO @PNA

WHILE @@FETCH_STATUS=0
BEGIN
	PRINT @PNA+ ' ' 
	
		FETCH NEXT FROM CR_PRODUCT INTO @PNA
END
CLOSE CR_PRODUCT
DEALLOCATE CR_PRODUCT
--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.
DECLARE @PIDS INT

DECLARE CR_DELETE CURSOR
FOR 
	SELECT  Product_id FROM Products

OPEN CR_DELETE

FETCH NEXT FROM CR_DELETE  INTO @PIDS
 WHILE @@FETCH_STATUS=0
 BEGIN 
    DELETE FROM Products 
	WHERE Product_id=@PIDS

	FETCH NEXT FROM CR_DELETE  INTO @PIDS
END
CLOSE CR_DELETE
DEALLOCATE CR_DELETE

--Part – B
--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases
--the price by 10%.
DECLARE @PRICES DECIMAL(8,2) , @PNAMES VARCHAR(50) , @PIDES  INT

DECLARE Product_CursorUpdate CURSOR
FOR
	SELECT  Product_Name,Product_id,Price 
	FROM Products

OPEN Product_CursorUpdate
FETCH NEXT FROM Product_CursorUpdate INTO @PNAMES,@PIDES,@PRICES

WHILE @@FETCH_STATUS=0
BEGIN
    
	  UPDATE Products
	  SET Price= @PRICES+ @PRICES * 0.1 
	  WHERE Product_id=@PIDES

	  PRINT CAST(@PRICES AS VARCHAR)+' '+ @PNAMES+' '+ CAST(@PIDES AS VARCHAR) 
	  
	  FETCH NEXT FROM Product_CursorUpdate INTO @PNAMES,@PIDES,@PRICES

END
CLOSE Product_CursorUpdate
DEALLOCATE Product_CursorUpdate
--6. Create a Cursor to Rounds the price of each product to the nearest whole number.
DECLARE @PRICES DECIMAL(8,2) , @PNAMES VARCHAR(50) , @PIDES  INT

DECLARE Product_CursorUpdate CURSOR
FOR
	SELECT  Product_Name,Product_id,Price 
	FROM Products

OPEN Product_CursorUpdate
FETCH NEXT FROM Product_CursorUpdate INTO @PNAMES,@PIDES,@PRICES

WHILE @@FETCH_STATUS=0
BEGIN
    
	  UPDATE Products
	  SET Price=ROUND(@PRICES,0)
	  WHERE Product_id=@PIDES

	  PRINT CAST(@PRICES AS VARCHAR)+' '+ @PNAMES+' '+ CAST(@PIDES AS VARCHAR) 
	  
	  FETCH NEXT FROM Product_CursorUpdate INTO @PNAMES,@PIDES,@PRICES

END
CLOSE Product_CursorUpdate
DEALLOCATE Product_CursorUpdate
--Part – C
--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop”

--(Note: Create NewProducts table first with same fields as Products table)

CREATE TABLE NewProducts (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);

DECLARE @PRICES DECIMAL(8,2) , @PNAMES VARCHAR(50) , @PIDES  INT

DECLARE Product_LAPTOP CURSOR
FOR
	SELECT  Product_Name,Product_id,Price 
	FROM Products
	WHERE Product_Name='LAPTOP'

OPEN Product_LAPTOP
FETCH NEXT FROM Product_LAPTOP INTO @PNAMES,@PIDES,@PRICES

WHILE @@FETCH_STATUS=0
BEGIN
    
	 INSERT INTO NewProducts VALUES(@PIDES,@PNAMES,@PRICES)

	  PRINT CAST(@PRICES AS VARCHAR)+' '+ @PNAMES+' '+ CAST(@PIDES AS VARCHAR) 
	  
	  FETCH NEXT FROM Product_LAPTOP INTO @PNAMES,@PIDES,@PRICES

END
CLOSE Product_LAPTOP
DEALLOCATE Product_LAPTOP


--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products
--with a price above 50000 to an archive table, removing them from the original Products table


CREATE TABLE New_Products (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);

DECLARE @PRICES DECIMAL(8,2) , @PNAMES VARCHAR(50) , @PIDES  INT

DECLARE Product_HIGH CURSOR
FOR
	SELECT  Product_Name,Product_id,Price 
	FROM Products
	WHERE Price >5000

OPEN Product_HIGH
FETCH NEXT FROM Product_HIGH INTO @PNAMES,@PIDES,@PRICES

WHILE @@FETCH_STATUS=0
BEGIN
    
	 INSERT INTO New_Products VALUES(@PIDES,@PNAMES,@PRICES)
	 delete Products
	 where Product_id=@pid

	  PRINT CAST(@PRICES AS VARCHAR)+' '+ @PNAMES+' '+ CAST(@PIDES AS VARCHAR) 
	  
	  FETCH NEXT FROM Product_LAPTOP INTO @PNAMES,@PIDES,@PRICES

END
CLOSE Product_HIGH
DEALLOCATE Product_HIGH
