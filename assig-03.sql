Create TABLE Company(
Company_ID int PRIMARY KEY,
Name VARCHAR2(225),
Location VARCHAR2(225),
Description VARCHAR2(225));

CREATE TABLE Project (
Project_ID int PRIMARY KEY,
Name VARCHAR2(225),
Start_Date DATE,
End_date DATE,
Status VARCHAR2(225),
Company_ID int,
FOREIGN KEY (Company_ID) REFERENCES Company (Company_ID));w

Create table Employee(
Employee_ID int PRIMARY KEY,
Employee_Name varchar2(225),
Position varchar2(225),
Salary int,
Start_Date DATE,
End_date DATE,
Company_ID int,
Project_ID int,
FOREIGN KEY (Company_ID) REFERENCES Company (Company_ID),
FOREIGN KEY (Project_ID) REFERENCES Project (Project_ID));

INSERT INTO Company VALUES (1, 'Infosys', 'Hyderabad', 'it is a IT Company');
INSERT INTO Company VALUES (2, 'TCS', 'Delhi', 'it may be a Company');
INSERT INTO Company VALUES (3, 'DXC', 'Mumbai', 'A good work culture');
INSERT INTO Company VALUES (4, 'Google', 'Bangalore', 'Nice Company');
INSERT INTO Company VALUES (5, 'Wipro', 'Pune', 'good Company');

INSERT INTO Project VALUES (11,'GCP',TO_DATE('2008-11-11','YYYY/MM/DD'),TO_DATE('2028-01-01','YYYY/MM/DD'),'In Progress',1);
INSERT INTO Project VALUES (12,'AWS',TO_DATE('2009-12-20','YYYY/MM/DD'),TO_DATE('2024-11-01','YYYY/MM/DD'),'In Progress',1);
INSERT INTO Project VALUES (13,'AZURE',TO_DATE('2003-08-07','YYYY/MM/DD'),TO_DATE('2021-04-08','YYYY/MM/DD'),'Completed',2);
INSERT INTO Project VALUES (14,'IBM',TO_DATE('2007-06-25','YYYY/MM/DD'),TO_DATE('2037-11-13','YYYY/MM/DD'),'In Progress',3);
INSERT INTO Project VALUES (15,'RedHat',TO_DATE('2006-09-03','YYYY/MM/DD'),TO_DATE('2025-02-28','YYYY/MM/DD'),'In Progress',4);


INSERT INTO Employee VALUES (22,'Sai','Tech Lead',45000,TO_DATE('2010-03-11','YYYY/MM/DD'),TO_DATE('2025-08-03','YYYY/MM/DD'),1,12);
INSERT INTO Employee VALUES (23,'Rahul','System Enginneer',20000,TO_DATE('2022-09-14','YYYY/MM/DD'),TO_DATE('2028-01-03','YYYY/MM/DD'),3,15);
INSERT INTO Employee VALUES (24,'Shiva','Quality Anlist',25000,TO_DATE('2014-05-16','YYYY/MM/DD'),TO_DATE('2025-11-12','YYYY/MM/DD'),2,13);
INSERT INTO Employee VALUES (25,'Ram','QA Lead',55000,TO_DATE('2013-08-11','YYYY/MM/DD'),TO_DATE('2030-01-03','YYYY/MM/DD'),4,14);
INSERT INTO Employee VALUES (26,'Tom','Manager',145300,TO_DATE('2007-07-17','YYYY/MM/DD'),TO_DATE('2045-09-09','YYYY/MM/DD'),1,12,'yes');
INSERT INTO Employee VALUES (27,'jack','System Engineer',27000,TO_DATE('2011-09-08','YYYY/MM/DD'),TO_DATE('2076-12-15','YYYY/MM/DD'),1,11,'no');
INSERT INTO Employee VALUES (28,'mark','tech Engineer',87000,TO_DATE('2002-02-02','YYYY/MM/DD'),TO_DATE('2067-11-16','YYYY/MM/DD'),3,12,'no');
INSERT INTO Employee VALUES (21,'Vasanth','SrSystem Engineer',30000,TO_DATE('2002-11-08','YYYY-MM-DD'),TO_DATE('2023-12-15','YYYY-MM-DD'),1,11,'yes');

ALTER TABLE Employee ADD Has_A_Cabin VARCHAR2(225);

UPDATE Company 
SET Location = 'New York'
WHERE Company_ID = 1;

SELECT * FROM Employee 
INNER JOIN Project ON Employee.Project_ID = Project.Project_ID;

SELECT * 
FROM Employee, Company,Project
WHERE Employee.Company_ID = Company.Company_ID AND Employee.Project_ID = Project.Project_ID;

SELECT count(*),Project_ID FROM Employee
GROUP by Project_ID;

SELECT AVG(Salary), Company_ID FROM Employee
GROUP BY Company_ID;

select MAX (Start_Date), Company_ID
FROM Project
GROUP BY Company_ID;


SELECT * FROM Employee
WHERE SALARY = (SELECT MAX(SALARY) FROM Employee WHERE SALARY < (SELECT MAX(SALARY)FROM Employee));
 
commit;

DROP TABLE Employee;
--1st i am droping the Employee table because there are no tables that containg foreign keys from the Employee table

DROP TABLE Project;
--2nd i am deleting the project table becouse after deleting the Employee table there is no other table using its primiry as its foreign. we cant delete Company table now because its primary key acts as foregin key in project table

Drop TABLE Company;

-- At last we delete the Company table as all the tables containg its primary key as foreign key are dropped.   

ROLLBACK;
-- ROLLBACK takes us to the place where the last COMMENT as taken place. once after roll back if we and run select statement we get error that table or view does not exist

SELECT * FROM Company;

SELECT * FROM Project;

SELECT * FROM Employee;

--VARCHAR can store up to 2000 bytes of characters while VARCHAR2 can store up to 4000 bytes of characters.

--The DROP command in SQL removes the table from the database, the DELETE command removes one or more records from the table, and the TRUNCATE command removes all the rows from the existing table.

-- The aggregate functions  that we have used in the assignment are count, AVG and MAX The COUNT() function returns the number of rows that matches a specified criterion.
--The AVG() function returns the average value of a numeric column.
--The MAX() function returns the largest value of the selected column.