--Part – A
--1. Write a function to print "hello world".

	CREATE OR ALTER FUNCTION FN_HELLO()
		RETURNS VARCHAR(200)
	AS
	BEGIN	
	
			RETURN 'HELLO WORLD';
	END;
	
	SELECT dbo.FN_HELLO()
--2. Write a function which returns addition of two numbers.

		 CREATE OR ALTER FUNCTION FN_ADITION(
		 @A INT, @B INT
		 ) RETURNS INT
	    AS
		BEGIN
		   DECLARE @SUM INT
			SET @SUM= @A+@B
		        RETURN @SUM

		END;

			SELECT DBO.FN_ADITION(10,23)
			
--3. Write a function to check whether the given number is ODD or EVEN.

	 CREATE OR ALTER FUNCTION FN_ODDEVN(
	  @A INT
	  )RETURNS VARCHAR(20)
	  AS
	  BEGIN
		IF @A %2=0
			RETURN 'EVEN'
	
		  RETURN 'ODD'
	END;

	SELECT dbo.FN_ODDEVN(23)
--4. Write a function which returns a table with details of a person whose first name starts with B.

       CREATE OR ALTER FUNCTION FN_PERSON()
	   RETURNS TABLE
	   
	   RETURN(
				 SELECT FIRSTNAME  FROM Person
				 WHERE FIRSTNAME LIKE 'B%'
			 )

			SELECT *FROM  DBO.FN_PERSON();
	

--5. Write a function which returns a table with unique first names from the person table.

       CREATE OR ALTER FUNCTION FN_UNIQFNMAE()
	   RETURNS TABLE
	   
	   RETURN(
				 SELECT DISTINCT FIRSTNAME  FROM Person
			
			 )

			 SELECT * FROM DBO.FN_UNIQFNMAE()

--6. Write a function to print number from 1 to N. (Using while loop)

		

CREATE OR ALTER FUNCTION FN_1TON(@N INT)
 RETURNS VARCHAR(8000)
		AS
		BEGIN
			DECLARE @C INT
			DECLARE @Result VARCHAR(8000)
			SET @C = 1
			SET @Result = ''
    
			WHILE @C <= @N
			BEGIN
				SET @Result = @Result + CAST(@C AS VARCHAR(50)) + ' '
				SET @C = @C + 1
			END

			RETURN @Result
		END;

SELECT DBO.FN_1TON(10)

--7. Write a function to find the factorial of a given integer.


	CREATE OR ALTER FUNCTION FN_FACT(@N INT)
	 RETURNS INT
			AS
			BEGIN
					DECLARE @C INT
					DECLARE @FAC INT
					SET @C = 1
					SET @FAC =1 
    
				WHILE @C <= @N
				BEGIN
					SET @FAC = @FAC *@C
					SET @C = @C + 1
				END

			RETURN @FAC
		END;

		SELECT DBO.FN_FACT(5)
--Part – B
--8. Write a function to compare two integers and return the comparison result. (Using Case statement)
		 CREATE OR ALTER FUNCTION FN_comparisonRESULT(@A INT, @B INT)
		 RETURNS VARCHAR(100)
		 AS
		 BEGIN
		 DECLARE @ANS VARCHAR(50)
		 SELECT  @ANS=
			CASE
			   when @A > @B THEN 'FIRST NUMBER IS LARGEST'
			    when @B > @A THEN ' SECOND NUMBER IS LARGEST'
			 END
			
			RETURN @ANS
		END
		SELECT DBO.FN_comparisonRESULT(12,23)

--9. Write a function to print the sum of even numbers between 1 to 20.
		 CREATE OR ALTER FUNCTION FN_1TO20RESULT()
		 RETURNS INT
		 AS
		 BEGIN
			DECLARE @SUM INT, @C INT
			SET @SUM=0
			SET @C=1

			WHILE @C <=20
			BEGIN
                        IF @C %2=0
						SET @SUM= @SUM+@C
					SET @C=@C+1
			END
			RETURN @SUM
		END
		SELECT DBO.FN_1TO20RESULT()
--10. Write a function that checks if a given string is a palindrome
        	 CREATE OR ALTER FUNCTION FN_PALINDROME(
			 @N VARCHAR(500)
			 ) RETURNS VARCHAR(1000)
		 AS
		 BEGIN
			DECLARE @ANS VARCHAR(200)
			SET @ANS = REVERSE(@N)

				IF @ANS = @N
				  RETURN 'PALINDROME'
			    
			        RETURN 'NOT PALINDROME'
					

		END

		SELECT DBO.FN_PALINDROME('AAAA')
--Part – C
--11. Write a function to check whether a given number is prime or not.
CREATE OR ALTER FUNCTION FN_PRIME(@A INT)
RETURNS VARCHAR(50)
AS 
BEGIN
    DECLARE @C INT
    SET @C = 2
    
    WHILE @C <= SQRT(@A)
    BEGIN
        IF @A % @C = 0
        BEGIN
            RETURN 'not prime'
        END
        SET @C = @C + 1
    END
    RETURN 'prime number'
END

		  	     
		  	

--12. Write a function which accepts two parameters start date & end date, and returns a difference in days.
CREATE OR ALTER FUNCTION FN_DATEDIFF(@START DATE, @END DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, @START, @END)
END

--13. Write a function which accepts two parameters year & month in integer and returns total days each
--year.

CREATE OR ALTER FUNCTION FN_DAYYEAR(@Y INT , @M INT)
RETURNS INT
AS
BEGIN
		DECLARE @ANS VARCHAR(500), @D DATE,@DAY INT

		SET @ANS= CAST(@Y AS varchar)+'-'+CAST(@M AS VARCHAR )+'-1'
		SET @D = CAST(@ANS AS date)

		SET @DAY =  DAY(EOMONTH(@D))
		RETURN @DAY
END
SELECT DBO.FN_DAYYEAR(2012,2)
--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons.

CREATE OR ALTER FUNCTION fn_detail(@did INT)
RETURNS TABLE
RETURN (
    SELECT * FROM persons
    WHERE departmentID = @did
)

--15. Write a function that returns a table with details of all persons who joined after 1-1-1991.

CREATE OR ALTER FUNCTION FN_PERSON_JOININGDATE()
RETURNS TABLE
RETURN (
    SELECT FIRSTNAME FROM persons
    WHERE JOININGDATE > '1991-01-01'
)
