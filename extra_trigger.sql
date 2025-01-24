CREATE TABLE EMPLOYEEDETAILS
(
	EmployeeID Int Primary Key,
	EmployeeName Varchar(100) Not Null,
	ContactNo Varchar(100) Not Null,
	Department Varchar(100) Not Null,
	Salary Decimal(10,2) Not Null,
	JoiningDate DateTime Null
)
INSERT INTO EMPLOYEEDETAILS (EmployeeID, EmployeeName, ContactNo, Department, Salary, JoiningDate) VALUES
(1, 'Falguni Shah', '9876543210', 'IT', 75000.00, '2021-02-15 10:00:00'),
(2, 'Gaurav Sharma', '9123456789', 'HR', 68000.50, '2022-07-18 09:30:00'),
(3, 'Harish Mehta', '8987654321', 'Finance', 79000.75, '2023-08-23 08:45:00'),
(4, 'Indrani Das', '9023456781', 'Marketing', 71000.90, '2021-11-12 10:45:00'),
(5, 'Jayesh Solanki', '9898765432', 'Sales', 76000.30, '2022-01-20 11:15:00');

select * from  EMPLOYEEDETAILS

INSERT INTO EMPLOYEEDETAILS (EmployeeID, EmployeeName, ContactNo, Department, Salary, JoiningDate) VALUES
(1431, 'Falguni Shah', '98765433210', 'IT', 75000.00, '2021-02-15 10:00:00')

CREATE TABLE EmployeeLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    EmployeeName VARCHAR(100) NOT NULL,
    ActionPerformed VARCHAR(100) NOT NULL,
    ActionDate DATETIME NOT NULL
);

----afTER
--1)	Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to display the message "Employee record inserted",
 --"Employee record updated", "Employee record deleted"
             CREATE OR ALTER TRIGGER TR_EMPLOYEE
			 ON EMPLOYEEDETAILS
			 AFTER INSERT,UPDATE, DELETE
			 AS
			 BEGIN	
			       PRINT 'Employee record inserted'
			 END;
			  CREATE OR ALTER TRIGGER TR_EMPLOYEE
			 ON EMPLOYEEDETAILS
			 AFTER UPDATE
			 AS
			 BEGIN	
			       PRINT 'Employee record UPDATED'
			 END;
			  CREATE OR ALTER TRIGGER TR_EMPLOYEE
			 ON EMPLOYEEDETAILS
			 AFTER  DELETE
			 AS
			 BEGIN	
			       PRINT 'Employee record DELETED'
			 END;
--2)	Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to log all
--operations into the EmployeeLog table.
			CREATE OR ALTER TRIGGER TR_EMPLOYEE
			 ON EMPLOYEEDETAILS
			 AFTER INSERT
			 AS
			 BEGIN	
			        DECLARE @ID INT , @NAME VARCHAR(100)

					SELECT @ID=EmployeeID,@NAME=EmployeeName FROM inserted
			       INSERT INTO EmployeeDetails VALUES(@ID,@NAME,'DATA IS INSERTED',GETDATE())
			 END;
			 CREATE OR ALTER TRIGGER TR_EMPLOYEE
			 ON EMPLOYEEDETAILS
			 AFTER INSERT
			 AS
			 BEGIN	
			        DECLARE @ID INT , @NAME VARCHAR(100)

					SELECT @ID=EmployeeID,@NAME=EmployeeName FROM inserted
			       INSERT INTO EmployeeDetails VALUES(@ID,@NAME,'DATA IS INSERTED',GETDATE())
			 END;

			 CREATE OR ALTER TRIGGER TR_EMPLOYEE
			 ON EMPLOYEEDETAILS
			 AFTER UPDATE
			 AS
			 BEGIN	
			        DECLARE @ID INT , @NAME VARCHAR(100)

					SELECT @ID=EmployeeID,@NAME=EmployeeName FROM inserted
			       INSERT INTO EmployeeDetails VALUES(@ID,@NAME,'DATA IS UPDATE',GETDATE())
			 END;

			 CREATE OR ALTER TRIGGER TR_EMPLOYEE
			 ON EMPLOYEEDETAILS
			 AFTER DELETE
			 AS
			 BEGIN	
			        DECLARE @ID INT , @NAME VARCHAR(100)

					SELECT @ID=EmployeeID,@NAME=EmployeeName FROM inserted
			       INSERT INTO EmployeeDetails VALUES(@ID,@NAME,'DATA IS DELETE',GETDATE())
			 END;


--3)Create a trigger that fires AFTER INSERT to automatically calculate the joining bonus (10% of the salary)
--for new employees and update a bonus column in the EmployeeDetails table.
             
			 CREATE OR ALTER TRIGGER TR_EM
			 ON EMPLOYEEDETAILS
			 AFTER INSERT
			 AS
			 BEGIN	
			        DECLARE @ID INT , @NAME VARCHAR(100),@SAL DECIMAL(8,2)

					SELECT @ID=EmployeeID,@SAL=Salary FROM inserted

					UPDATE EMPLOYEEDETAILS
					SET Salary = @SAL+@SAL*0.1
					WHERE EmployeeID=@ID
			 END;
--4)	Create a trigger to ensure that the JoiningDate is automatically set to the current date
--if it is NULL during an INSERT operation.
		CREATE OR ALTER TRIGGER TR_UPDATES
		 ON EMPLOYEEDETAILS
		 AFTER UPDATE
		 AS
		 BEGIN
		    DECLARE @PID INT , @JDATE DATETIME
			
			SELECT @PID=EmployeeID,@JDATE=JoiningDate FROM inserted
			WHERE JoiningDate is NULL

			UPDATE EMPLOYEEDETAILS
			SET JoiningDate=GETDATE()
			WHERE EmployeeID =@PID
		 END;

--5)	Create a trigger that ensure that ContactNo is valid during insert (Like ContactNo length is 10)
		 CREATE OR ALTER TRIGGER TR_contact
		 ON EMPLOYEEDETAILS
		 AFTER insert
		 AS
		 BEGIN
		    DECLARE @PID INT , @cno varchar(100)
			
			SELECT @PID=EmployeeID,@cno=ContactNo FROM inserted
			where len(ContactNo) <> 10

			delete EMPLOYEEDETAILS
			where EmployeeID=@PID
			
		 END;

--Instead of Trigger
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    MovieTitle VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    Rating DECIMAL(3, 1) NOT NULL,
    Duration INT NOT NULL
);

CREATE TABLE MoviesLog
(
	LogID INT PRIMARY KEY IDENTITY(1,1),
	MovieID INT NOT NULL,
	MovieTitle VARCHAR(255) NOT NULL,
	ActionPerformed VARCHAR(100) NOT NULL,
	ActionDate	DATETIME  NOT NULL
);

--1.	Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Movies table. For that, 
--log all operations performed on the Movies table into MoviesLog.
        CREATE OR ALTER TRIGGER TR_MOVIEINSERT
		ON Movies
		INSTEAD OF  INSERT
		AS
		BEGIN
				DECLARE @ID INT, @NAME VARCHAR(50)
		        SELECT @ID=MovieID, @NAME=MovieTitle  FROM inserted

			       INSERT INTO PersonLog VALUES(@ID,@NAME,'INSERT THE DATA',GETDATE())
		END;
	     
		    CREATE OR ALTER TRIGGER TR_MOVIEINSERT
		ON Movies
		INSTEAD OF  UPDATE
		AS
		BEGIN
				DECLARE @ID INT, @NAME VARCHAR(50)
		        SELECT @ID=MovieID, @NAME=MovieTitle  FROM inserted

			       INSERT INTO PersonLog VALUES(@ID,@NAME,'UPDATE THE DATA',GETDATE())
		END;


	  CREATE OR ALTER TRIGGER TR_MOVIEINSERT
		ON Movies
		INSTEAD OF  DELETE
		AS
		BEGIN
				DECLARE @ID INT, @NAME VARCHAR(50)
		        SELECT @ID=MovieID, @NAME=MovieTitle  FROM deleted

			       INSERT INTO PersonLog VALUES(@ID,@NAME,'DELETE THE DATA',GETDATE())
		END;
--2.	Create a trigger that only allows to insert movies for which Rating is greater than 5.5 .
      CREATE OR ALTER TRIGGER TR_MOVIEINSERT
		ON Movies
		INSTEAD OF  INSERT
		AS
		BEGIN
				DECLARE @ID INT, @NAME VARCHAR(50),@RATE DECIMAL(8,2) ,@MovieIDMovieTitle VARCHAR(100),@ReleaseYear DATETIME ,@Genre VARCHAR(100),@Rating	DECIMAL(3,1),@Duration INT
				SELECT @ID = ID, 
       @NAME = NAME,
       @RATE = RATING,
       @MovieIDMovieTitle = MovieTitle,
       @ReleaseYear = ReleaseYear,
       @Genre = Genre,
       @Rating = Rating,
       @Duration = Duration
FROM Inserted;
                     IF @RATE >5.5
					 BEGIN
					  INSERT INTO PersonLog VALUES(@ID,@NAME,'DELETE THE DATA',GETDATE())
					 END;
			      
		END;
 

--3.	Create trigger that prevent duplicate 'MovieTitle' of Movies table and log details of it in MoviesLog table.

     CREATE OR ALTER TRIGGER 

--4.	Create trigger that prevents to insert pre-release movies.

--5.	Develop a trigger to ensure that the Duration of a movie cannot be updated to a value greater than 120 minutes (2 hours) to prevent unrealistic entries.
