-- Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);

--Part – A
--1. Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures.

      create or alter procedure pr_DEPT_INSERT
	   @DNAME VARCHAR(50),
	   @DID INT
     AS 
	 BEGIN
	   INSERT INTO  Department VALUES(@DID,@DNAME)
	 END



	 EXEC PR_Department_insert  1 ,'ADMIN'
	  EXEC PR_Department_insert  2 ,'IT'
	   EXEC PR_Department_insert  3 ,'HR'
	    EXEC PR_Department_insert  4 ,'ACCOUNT'

	 ________________________________________________
	 
      create or alter procedure pr_DESI_INSERT
	   @DNAME VARCHAR(50),
	   @DID INT
     AS 
	 BEGIN
	   INSERT INTO  Designation VALUES(@DID,@DNAME)

	 END


	 
		SELECT *FROM Department

		EXEC PR_Designation_insert 11,'JOBBER'
			EXEC PR_Designation_insert 12,'WELDER'
				EXEC PR_Designation_insert 13,'CLERK'
					EXEC PR_Designation_insert 14,'MANAGER'
						EXEC PR_Designation_insert 15,'CEO'

	 ______________________________________________
	 
      create or alter procedure pr_PERSON_INSERT
	 
	   @FNAME VARCHAR(50),
	    @LNAME VARCHAR(50),
		@SAL DECIMAL(8,2),
		@JOINDATE dATETIME,
		@DID INT,
		@DESID INT
	   
     AS 
	 BEGIN
	   INSERT INTO  Person VALUES(@FNAME,@LNAME,@SAL,@JOINDATE,@DID,@DESID)
	 END




	 EXEC  pr_PERSON_INSERT 'RAHUL','ANSHU',56000,'1990-01-01',1,12
	  EXEC  pr_PERSON_INSERT 'HARDIK','HINSHU',18000,'1990-09-25',2,11
	   EXEC  pr_PERSON_INSERT'BHAVIN','KAMANI',25000,'1991-05-14',NULL,11
	    EXEC  pr_PERSON_INSERT 'BHOOMI','PATEL',39000,'2014-02-20',1,13
		 EXEC pr_PERSON_INSERT 'ROHIT','RAJGOR',17000,'1990-07-23',2,15
		  EXEC  pr_PERSON_INSERT 'PRIYA','MEHTA',25000,'1990-10-18',2,NULL
		  EXEC  pr_PERSON_INSERT 'NEHA','TRIVEDI',18000,'2014-02-20',3,15



	 SELECT * FROM Person

	 ----------------------------UPDATE-------------
 create or alter procedure pr_DEPT_UPDATE
	   @DNAME VARCHAR(50),
	   @DID INT
     AS 
	 BEGIN
	  UPDATE Department
	  SET DepartmentName=@DNAME
	  WHERE DepartmentID=@DID

	 END

	 --____   DESI_________________
   create or alter procedure pr_DESI_UPDATE
	   @DNAME VARCHAR(50),
	   @DID INT
     AS 
	 BEGIN
	  UPDATE Designation
	  SET DesignationName=@DNAME
	  WHERE DesignationID=@DID

	 END




	 --_________PERSON______________
	  create or alter procedure pr_PERSON_UPDATE
	    @PID INT,
		@FNAME VARCHAR(50),
	    @LNAME VARCHAR(50),
		@SAL DECIMAL(8,2),
		@JOINDATE dATETIME,
		@DID INT,
		@DESID INT
		
	   
     AS 
	 BEGIN
		 UPDATE Person
		 SET 
			  FirstName=@FNAME,
			   LastName=@LNAME,
				Salary=@SAL,
				 JoiningDate=@JOINDATE,
				  DepartmentID=@DID,
				   DesignationID=@DESID
		 WHERE PersonID=@PID

	 END


	 -----------------DELETE---------------


		 create or alter procedure pr_DEPT_DELETE
			@DID INT
		 AS 
		 BEGIN

			  DELETE  FROM Department
			  WHERE DepartmentID=@DID

		 END
------------------DESI--------------

		create or alter procedure pr_DESI_DELETE
			@DESID INT
		 AS 
		 BEGIN

			  DELETE  FROM Department
			  WHERE DepartmentID=@DESID

		 END


------------PERSON-----------------------------

		create or alter procedure pr_DEPT_DELETE
			@PID INT
		 AS 
		 BEGIN

			  DELETE  FROM Person
			  WHERE DepartmentID=@PID

		 END
		
--2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY

         create or alter procedure pr_PERSON_DELETE
			@PID INT
		 AS 
		 BEGIN
			 SELECT* FROM Person
			 WHERE  PersonID=@PID

		 END


		 create or alter procedure pr_PERSON_DELETE
			@DESIID INT
		 AS 
		 BEGIN
			 SELECT* FROM Designation
			 WHERE  DesignationID=@DESIID

		 END


		 create or alter procedure pr_PERSON_DELETE
			@DID INT
		 AS 
		 BEGIN
			 SELECT* FROM Department
			 WHERE  DepartmentID=@DID

		 END
  
--3. Department, Designation & Person Table’s (If foreign key is available then do write join and take

     CREATE OR ALTER PROCEDURE PR_DEPT_PK

	 AS  
	 BEGIN

	  SELECT * FROM Department
	END

	
     CREATE OR ALTER PROCEDURE PR_DESI_PK

	 AS  
	 BEGIN

	  SELECT * FROM Designation
	END

	
     CREATE OR ALTER PROCEDURE PR_PERSON_PK

	 AS  
	 BEGIN

	  SELECT Person.*
	  FROM Person
		  JOIN Designation 
		  ON Person.DesignationID=Designation.DesignationID
		  JOIN Department
		  ON Department.DepartmentID=Person.DepartmentID
	END





--columns on select list)
--4. Create a Procedure that shows details of the first 3 persons.

  	 create or alter procedure pr_DEPT_TOP
		
		 AS 
		 BEGIN
			 SELECT TOP 3 *  FROM Department
			 

		 END


		 EXEC pr_DEPT_TOP





		 create or alter procedure pr_DESI_TOP
		
		 AS 
		 BEGIN
			 SELECT TOP 3 *  FROM Designation
			 

		 END


		 EXEC pr_DESI_TOP




		 create or alter procedure pr_PERSON_TOP
		
		 AS 
		 BEGIN
			 SELECT TOP 3 *  FROM Person
		
		 END


		 EXEC pr_PERSON_TOP



--Part – B
--5. Create a Procedure that takes the department name as input and returns a table with all workers
--working in that department.

  CREATE  PROCEDURE PR_DEPTNAMERETURN
		@DNAME VARCHAR(50)
	AS
   BEGIN
     
		 SELECT *
		 FROM Department
		 JOIN Person
		 ON Department.DepartmentID = Person.DepartmentID
		 WHERE  Department.DepartmentName=@DNAME
	END

	EXEC PR_DEPTNAMERETURN 'HR'

--6. Create Procedure that takes department name & designation name as input and returns a table with
--worker’s first name, salary, joining date & department name.
   CREATE OR ALTER  PROCEDURE PR_DEPT_DESI
		@DNAME VARCHAR(50),
		@DESINAME VARCHAR(50)
	AS
	BEGIN
		   SELECT Person.FirstName,Person.Salary,Person.JoiningDate, Department.DepartmentName
		   FROM Person
		   JOIN Department
		   ON Person.DepartmentID=Department.DepartmentID
		   JOIN Designation
		   ON Person.DesignationID=Designation.DesignationID
		   WHERE 
			   Designation.DesignationName=@DESINAME
			   AND 
			   Department.DepartmentName=@DNAME
	   END

	   PR_DEPT_DESI 'HR' ,'MANAGER'
--7. Create a Procedure that takes the first name as an input parameter and display all the details of the
--worker with their department & designation name.
--8. Create Procedure which displays department wise maximum, minimum & total salaries.
--9. Create Procedure which displays designation wise average & total salaries.
--Part – C
--10. Create Procedure that Accepts Department Name and Returns Person Count.
--11. Create a procedure that takes a salary value as input and returns all workers with a salary greater than
--input salary value along with their department and designation details.
--12. Create a procedure to find the department(s) with the highest total salary among all departments.
--13. Create a procedure that takes a designation name as input and returns a list of all workers under that
--designation who joined within the last 10 years, along with their department.
--14. Create a procedure to list the number of workers in each department who do not have a designation
--assigned.
--15. Create a procedure to retrieve the details of workers in departments where the average salary is above
--12000.
