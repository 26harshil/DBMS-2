CREATE TABLE Customers (
 Customer_id INT PRIMARY KEY,
 Customer_Name VARCHAR(250) NOT NULL,
 Email VARCHAR(50) UNIQUE
);
-- Create the Orders table
CREATE TABLE Orders (
 Order_id INT PRIMARY KEY,
 Customer_id INT,
 Order_date DATE NOT NULL,
 FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
);
--From the above given tables perform the following queries:
--Part – A
--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.

  create or alter procedure  pr_zerodiv
  as BEGIN
	BEGIN TRY
        PRINT CAST(10/0 AS VARCHAR)
	END TRY
	BEGIN CATCH
		PRINT 'ZERO DIVION IS NOT POSSIABLE '
	END CATCH
END
   PR_ZERODIV
--2. Try to convert string to integer and handle the error using try…catch block.
 create or alter procedure  pr_STRINGTOINT
  as BEGIN
	BEGIN TRY
        PRINT CAST('MEET' AS INTEGER)
	END TRY
	BEGIN CATCH
		PRINT 'STRING TO INTEGR IS NOT POSSIABLE '
	END CATCH
END
pr_STRINGTOINT

--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle
--exception with all error functions if any one enters string value in numbers otherwise print result.
     create or alter procedure  pr_SUM
	  @A VARCHAR(45) ,@B VARCHAR(256)
	 as BEGIN
		BEGIN TRY
			PRINT CAST(@A AS INT)+ CAST(@B AS INT)
		END TRY
		BEGIN CATCH
			PRINT 'ONE OF THE VALUE IS NOT INTEGER '
		END CATCH
    END
	PR_SUM 56,654
	PR_SUM 12,DFS
--4. Handle a Primary Key Violation while inserting data into customers table and print the error details
--such as the error message, error number, severity, and state.
   create or alter procedure  pr_pk
	 as BEGIN
		BEGIN TRY
			INSERT INTO customers VALUES(1,'SADS','SADSA')
			END TRY
		BEGIN CATCH
			PRINT 'ERROR MASSAGE'+CAST(ERROR_MESSAGE() AS NVARCHAR(10))
		    PRINT 'ERROR MASSAGE'+CAST(ERROR_STATE() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE'+CAST(ERROR_SEVERITY() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE'+CAST(ERROR_NUMBER() AS NVARCHAR(10))
		END CATCH
    END
	PR_PK
--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws
--Error like no Customer_id is available in database.
      create or alter procedure  pr_pk
	  @CID INT
	  as BEGIN
		BEGIN TRY
			IF NOT EXISTS (SELECT 1 FROM Customers WHERE Customer_id=@CID)
			BEGIN
				THROW 50001,'NO CUSTOMER ID IS AVAILBALE',1
			END
			END TRY
		BEGIN CATCH
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_MESSAGE() AS NVARCHAR(10))
		    PRINT 'ERROR MASSAGE  '+CAST(ERROR_STATE() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_SEVERITY() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_NUMBER() AS NVARCHAR(10))
		END CATCH
    END
	PR_PK 2
--Part – B
--6. Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error
--message.
	 create or alter procedure  pr_FK	  
	  as BEGIN
		BEGIN TRY
		     INSERT INTO Orders VALUES (2,5,'1990-2-21')
			BEGIN
				THROW 50001,'NO CUSTOMER ID IS AVAILBALE',1
			END
			END TRY
		BEGIN CATCH
			PRINT 'FORIGN KEY VAIOLATION EXCEPTION'
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_MESSAGE() AS NVARCHAR(10))
		    PRINT 'ERROR MASSAGE  '+CAST(ERROR_STATE() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_SEVERITY() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_NUMBER() AS NVARCHAR(10))
		END CATCH
    END
  PR_FK 
--7. Throw custom exception that throws error if the data is invalid.
  create or alter procedure  pr_CUTOM_THROW	
  @NAME VARCHAR(45)
	  as BEGIN
		BEGIN TRY
			IF LEN(@NAME) < 3
			BEGIN
				THROW 50051,'uSER NAME MUST BE GRATER THAN 3 ',1
			END
			ELSE
			BEGIN
				INSERT INTO Customers VALUES (3,@NAME,'ABC@SM.COM')
			END
			END TRY
		BEGIN CATCH
			
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_MESSAGE() AS NVARCHAR(100))
		    PRINT 'ERROR MASSAGE  '+CAST(ERROR_STATE() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_SEVERITY() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_NUMBER() AS NVARCHAR(10))
		END CATCH
    END

	pr_CUTOM_THROW 'BJ'
--8. Create a Procedure to Update Customer’s Email with Error Handling
--Part – C
--9. Create a procedure which prints the error message that “The Customer_id is already taken. Try another
----one”.
 create or alter procedure  pr_pK_IS_ALREADY_TAKEN
	  @CID INT
	  as BEGIN
		BEGIN TRY
			IF NOT EXISTS (SELECT 1 FROM Customers WHERE Customer_id=@CID)
				BEGIN
			             INSERT INTO Customers VALUES(@CID,'JASMINE','JASU@GAMIL.COM')
				END
			ELSE
			BEGIN
					THROW 50201,'NO CUSTOMER ID IS AVAILBALE',1
			END
			END TRY
		BEGIN CATCH
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_MESSAGE() AS NVARCHAR(100))
		    PRINT 'ERROR MASSAGE  '+CAST(ERROR_STATE() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_SEVERITY() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_NUMBER() AS NVARCHAR(10))
		END CATCH
    END

pr_pK_IS_ALREADY_TAKEN 2

--10. Handle Duplicate Email Insertion in Customers Table.
create or alter procedure  pr_DUPLICATE
	  @EMAIL VARCHAR(50),@CID INT,@NAME VARCHAR(69)
	  as BEGIN
		BEGIN TRY
			IF EXISTS (SELECT 1 FROM Customers WHERE Email=@EMAIL)
				BEGIN
					THROW 50201,'EMAIL IS ALREADY EXIST',1    
				END
			ELSE
			BEGIN
					    INSERT INTO Customers VALUES(@CID,@NAME,@EMAIL)
			END
			END TRY
		BEGIN CATCH
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_MESSAGE() AS NVARCHAR(100))
		    PRINT 'ERROR MASSAGE  '+CAST(ERROR_STATE() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_SEVERITY() AS NVARCHAR(10))
			PRINT 'ERROR MASSAGE  '+CAST(ERROR_NUMBER() AS NVARCHAR(10))
		END CATCH
    END
	  pr_DUPLICATE 'ZEEL@GMAIL.COM',5,MANAV

	  SELECT * FROM CUSTOMERS

