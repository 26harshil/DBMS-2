-- Creating PersonInfo Table
CREATE TABLE PersonInfo (
 PersonID INT PRIMARY KEY,
 PersonName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8,2) NOT NULL,
 JoiningDate DATETIME NULL,
 City VARCHAR(100) NOT NULL,
 Age INT NULL,
 BirthDate DATETIME NOT NULL
);
INSERT INTO PersonInfo (PersonID, PersonName, Salary, JoiningDate, City, Age, BirthDate) VALUES
(1, 'Amit Patel', 45000.00, '2023-01-15 09:00:00', 'Rajkot', 30, '1995-10-20 00:00:00'),
(2, 'Balbir Singh', 55000.50, '2024-06-12 10:15:00', 'Ahmedabad', 28, '1996-03-14 00:00:00'),
(3, 'Chitra Desai', 60000.75, '2022-03-08 08:30:00', 'Vadodara', 35, '1989-11-25 00:00:00'),
(4, 'Dinesh Mehta', 48000.90, '2023-11-05 09:45:00', 'Surat', 42, '1981-07-10 00:00:00'),
(5, 'Esha Rathi', 52000.30, '2023-09-23 11:00:00', 'Jamnagar', 25, '1999-06-30 00:00:00');

-- Creating PersonLog Table
CREATE TABLE PersonLog (
 PLogID INT PRIMARY KEY IDENTITY(1,1),
 PersonID INT NOT NULL,
 PersonName VARCHAR(250) NOT NULL,
 Operation VARCHAR(50) NOT NULL,
 UpdateDate DATETIME NOT NULL,
);

DROP TABLE PersonLog

DROP TABLE PersonInfo

--Part – A
--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display
--a message “Record is Affected.”

		CREATE OR ALTER TRIGGER TR_INSERT
		ON PERSONINFO
		AFTER INSERT, UPDATE,DELETE
		AS
		BEGIN
		      PRINT 'Record is Affected'
		END;
--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that,
--log all operations performed on the person table into PersonLog.
            
		CREATE OR ALTER TRIGGER TR_INSERT
		ON PERSONINFO
		AFTER INSERT
		AS
		BEGIN
				DECLARE @PID INT, @PNAME VARCHAR(50)
		        SELECT @PID=PersonID, @PNAME=PersonName FROM inserted

			       INSERT INTO PersonLog VALUES(@PID,@PNAME,'INSERT',GETDATE())
		END;
	     
		CREATE OR ALTER TRIGGER TR_UPD
		ON PERSONINFO
		AFTER UPDATE
		AS
		BEGIN
				DECLARE @PID INT, @PNAME VARCHAR(50)
		        SELECT @PID=PersonID, @PNAME=PersonName FROM DELETED

			       INSERT INTO PersonLog VALUES(@PID,@PNAME,'UPDATED',GETDATE())
		END;

		     
		CREATE OR ALTER TRIGGER TR_DEL
		ON PERSONINFO
		AFTER DELETE
		AS
		BEGIN
				DECLARE @PID INT, @PNAME VARCHAR(50)
		        SELECT @PID=PersonID, @PNAME=PersonName FROM DELETED

			       INSERT INTO PersonLog VALUES(@PID,@PNAME,'DELETE',GETDATE())
		END;
--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo
--table. For that, log all operations performed on the person table into PersonLog.

			CREATE OR ALTER TRIGGER TR_INSINSERT
			ON PERSONINFO
			INSTEAD OF INSERT
			AS
			BEGIN
				  DECLARE @PID INT, @PNAME VARCHAR(50)

				  SELECT  @PID=PersonID, @PNAME=PersonName FROM inserted

				  INSERT INTO PersonLog VALUES(@PID,@PNAME,'INSERT',GETDATE())

			END;
			CREATE OR ALTER TRIGGER TR_INSINSERT
			ON PERSONINFO
			INSTEAD OF UPDATE
			AS
			BEGIN
				  DECLARE @PID INT, @PNAME VARCHAR(50)

				  SELECT  @PID=PersonID, @PNAME=PersonName FROM inserted

				  INSERT INTO PersonLog VALUES(@PID,@PNAME,'UPDATE',GETDATE())

			END;
			CREATE OR ALTER TRIGGER TR_INSINSERT
			ON PERSONINFO
			INSTEAD OF DELETE
			AS
			BEGIN
				  DECLARE @PID INT, @PNAME VARCHAR(50)

				  SELECT  @PID=PersonID, @PNAME=PersonName FROM inserted

				  INSERT INTO PersonLog VALUES(@PID,@PNAME,'DELETE',GETDATE())

			END;

--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into
--uppercase whenever the record is inserted.
           
			CREATE OR ALTER TRIGGER TR_INSINSERT
			ON PERSONINFO
		AFTER INSERT
			AS
			BEGIN
					  DECLARE @PID INT, @PNAME VARCHAR(50),@SAL DECIMAL(8,2),@JOININGDATE DATETIME,@CITY VARCHAR(50),@AGE INT, @DOB DATETIME

					  SELECT  @PID=PersonID, @PNAME=PersonName FROM inserted

					UPDATE PersonInfo
					SET PersonName=UPPER(@PNAME)
					WHERE PersonID=@PID

			END;
			INSERT INTO PersonInfo VALUES(125,'HAshvi',65464,'2001-1-1','RAJKOT',18,'2000-3-6')

			SELECT * FROM PersonInfo
			
			SELECT * FROM PersonLog

--5. Create trigger that prevent duplicate entries of person name on PersonInfo table.

  create or alter trigger tr_dup
 on personinfo
 INSTEAD OF  INSERT 
 AS
 BEGIN
	DECLARE @PID INT, @PNAME VARCHAR(50)
	
	INSERT INTO PersonInfo (PersonID,PersonName,SALARAY,JOINGINDDATE,CITY,AGE,BIRTHDATE) 
	 SELECT PersonID,PersonName,SALARAY,JOINGINDDATE,CITY,AGE,BIRTHDATE FROM PersonInfo
	 WHERE  PersonName NOT IN ( SELECT PersonName FROM PersonInfo )
 END; 
--6. Create trigger that prevent Age below 18 years.
   create or alter trigger tr_AGE
   ON PERSONINFO
   INSTEAD OF INSERT
   AS
   BEGIN 
   DECLARE @PID INT, @PNAME VARCHAR(50)

	INSERT INTO PersonInfo (PersonID,PersonName,SALARAY,JOINGINDDATE,CITY,AGE,BIRTHDATE)
	SELECT PersonID,PersonName,SALARAY,JOINGINDDATE,CITY,AGE,BIRTHDATE
	FROM PERSONINFO
	WHERE AGE >18


   END;
--Part – B
--7. Create a trigger that fires on INSERT operation on person table, which calculates the age and update
--that age in Person table.
		 CREATE OR ALTER TRIGGER TR_UPDATES
		 ON PERSONINFO
		 AFTER INSERT
		 AS
		 BEGIN
		    DECLARE @PID INT , @DOB DATETIME
			
			SELECT @PID=PERSONID,@DOB=BIRTHDATE FROM inserted

			UPDATE PersonINFO
			SET AGE=DATEDIFF(Y,@DOB,GETDATE());
			WHERE PERSONID =@PID
		 END;
--8. Create a Trigger to Limit Salary Decrease by a 10%.
		 CREATE OR ALTER TRIGGER TR_salryDecrese_10
		 ON PERSONINFO
		 INSTEAD OF  Update
		 AS
		 BEGIN
		    DECLARE @PID INT ,@OLDSAL dECIMAL(8,2),@NEWSAL dECIMAL(8,2)
			
			SELECT @PID=PERSONID,@NEWSAL=Salary FROM inserted
			SELECT @OLDSAL=SALARY FROM deleted

			if @NEWSAL  > @OLDSAL*0.9  
			begin
				update PERSONINFO
				set SALARY=@NEWSAL
				where PERSONID=@PID
			end;
	

		 END;
		 UPDATE PERSONINFO
		 SET SALARY=7000
		 WHERE PersonName='Amit Patel'
		 SELECT * FROM PERSONINFO


--Part – C
--9. Create Trigger to Automatically Update JoiningDate to Current Date on INSERT if JoiningDate is NULL
--during an INSERT.
		CREATE OR ALTER TRIGGER TR_UPDATES
		 ON PERSONINFO
		 AFTER UPDATE
		 AS
		 BEGIN
		    DECLARE @PID INT , @JDATE DATETIME
			
			SELECT @PID=PERSONID,@JDATE= JOININGDATE FROM inserted
			WHERE JoiningDate is NULL

			UPDATE PersonINFO
			SET JoiningDate=GETDATE()
			WHERE PERSONID =@PID
		 END;
--10. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints
--‘Record deleted successfully from PersonLog’.

        CREATE OR ALTER TRIGGER TR_DELETE_FROM_PERSONiNFO
		 ON PersonLog
		 AFTER DELETE
		 AS
		 BEGIN
		    DECLARE @PID INT 
			
			SELECT @PID=PERSONID FROM deleted
		

			PRINT 'RECORD DELETED SUCCESSFULLY FROM PERSONLOG'
		 END

		 DELETE PersonLog
		 WHERE PersonName='Amit Patel'



