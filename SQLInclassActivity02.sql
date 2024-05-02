drop table COUNTRY;

CREATE TABLE COUNTRY (
id int PRIMARY KEY,
name VARCHAR2(225),
population int,
area int);

INSERT INTO COUNTRY VALUES (001,'India',1437982661,1269219);
INSERT INTO COUNTRY VALUES (002,'United States',331449281,9372610);
INSERT INTO COUNTRY VALUES (003,'China',1444216107,9596961);
INSERT INTO COUNTRY VALUES (004,'Brazil',213993437,8515767);
INSERT INTO COUNTRY VALUES (005,'Russia',146748590,17098242);
INSERT INTO COUNTRY VALUES (006,'Japan',126476461,377975);
INSERT INTO COUNTRY VALUES (007,'Nigeria',211400708,923768);
INSERT INTO COUNTRY VALUES (008,'Pakistan',225199937,881913);
INSERT INTO COUNTRY VALUES (009,'Indonesia',276361783,1904569);
INSERT INTO COUNTRY VALUES (010,'Mexico',130262216,1964375);
INSERT INTO COUNTRY VALUES (011,'Canada',156309676,3934670);

drop table CITY;

CREATE TABLE CITY (
id int PRIMARY KEY,
name VARCHAR2(225),
country_id int,
population int,
rating int,
FOREIGN KEY (country_id) REFERENCES COUNTRY (id));

INSERT INTO CITY VALUES (101,'Mancherial',001,240130,5);
INSERT INTO CITY VALUES (102,'New York City',002,8336817,4);
INSERT INTO CITY VALUES (103,'Shanghai',003,24256800,2);
INSERT INTO CITY VALUES (104,'São Paulo',004,12106920,1);
INSERT INTO CITY VALUES (105,'Moscow',005,12678079,3);
INSERT INTO CITY VALUES (106,'Tokyo',006,37435191,2);
INSERT INTO CITY VALUES (107,'Lagos',007,14989300,1);
INSERT INTO CITY VALUES (108,'Karachi',008,15741406,5);
INSERT INTO CITY VALUES (109,'Jakarta',009,10982378,4);
INSERT INTO CITY VALUES (110,'Mexico City',010,9209944,1);
INSERT INTO CITY VALUES (111,'Dublin',010,9209944,3);
INSERT INTO CITY VALUES (112,'Lublin',010,9209944,3);
INSERT INTO CITY VALUES (113,'Maryvill',NULL,9209944,3);
INSERT INTO CITY VALUES (114,'Paris',09,966900041,5);


--Fetch all columns from Country table

Select * from COUNTRY;

--Fetch id and name columns from the CITY table

Select id,name from CITY;

--Fetch city name Sorted by the rating column in default ASending order

SELECT name FROM CITY ORDER BY rating ASC;

--Fetch city name Sorted by the rating column in default Decending order 

SELECT name FROM CITY ORDER BY rating DESC;

--Aliases

Select name AS City_Name from CITY;

--TABLES

Select co.name as Country_Name, ci.name as City_Name
from CITY ci
join COUNTRY co ON ci.country_id = co.id;

--Filtering The Output
-- Comparison operators

--Fetch names of city that have a rating above 3

Select name from CITY where rating >3;

--Fetch names of city that are neither Berlin nor Mardrid:

Select name from CITY where name != 'Jakarta' and name!= 'New York City';

--Text operators
--Fetch names for citys that Start with 'p' or ends with 's':

SELECT name FROM CITY WHERE name LIKE 'M%' OR name LIKE '%o';

--Fetch names of cities that starts with any latter followed by 'ublin';

SELECT name FROM CITY WHERE name LIKE '_ublin';

--Other Operators
--Fetch names of cities that have a population between 500k and 5M:

Select name from CITY where population BETWEEN 500000 AND 50000000;

--Fetch names of cities that don't miss a rating value:

Select name From CITY where rating is NOT NULL;

--Fetch names of cities that are in countries with IDS 001, 003, 005:

Select name From CITY where country_id IN ( 001, 003, 005);

--Querying Multiple Tables 
--Inner join 
Select co.name as Country_Name, ci.name as City_Name
from CITY ci
join COUNTRY co ON ci.country_id = co.id;

--Left Join 
Select co.name as Country_Name, ci.name as City_Name
from CITY ci
LEFT join COUNTRY co ON ci.country_id = co.id;

--Right Join 
Select co.name as Country_Name, ci.name as City_Name
from CITY ci
RIGHT join COUNTRY co ON ci.country_id = co.id;

--Full join
Select co.name as Country_Name, ci.name as City_Name
from CITY ci
FULL join COUNTRY co ON ci.country_id = co.id;

--Cross join
Select COUNTRY.name as Country_Name, CITY.name as City_Name
from CITY
CROSS join COUNTRY;
--OR
Select COUNTRY.name as Country_Name, CITY.name as City_Name
from COUNTRY,CITY;

--Natural join
SELECT name AS City_Name, name AS Country_Name
FROM city
NATURAL JOIN country;

--Find out the number of cities

Select Count(*) from CITY;

--Find out the number of city with non-null ratings :

Select Count(rating) from CITY;

--Find out the number of Distinctive country values:

Select Count(DISTINCT country_id ) from CITY;

--Find out the Smallest the greatest country populations :

Select MIN(population), MAX(population) from COUNTRY; 

--find out the total population of cities in respective countries 

SELECT country_id, Sum (population) from CITY GROUP BY country_id;

--Find out the average rating for Cities in respective countries if the average is above 3.0;

SELECT country_id, AVG (rating) from CITY GROUP BY country_id HAVING AVG (rating)>3.0;

--Find the cities with the same rating as Paris

SELECT name from CITY where rating =(select rating from city where name = 'Paris');

--Multiple Values 
--the Cities in countries that have a population above 20M:

SELECT name
FROM City
WHERE country_ID IN (SELECT id FROM Country WHERE population > 20000000);

--CORRELATED
--Find the cities with a population greater that the average population in country
SELECT name from CITY where city.population > (select AVG(country.population) from country); 

--or
SELECT name from CITY main_city 
where population >(select AVG(population) from CITY average_city WHERE average_city.country_id = main_city.country_id);

--Query finds countries that have at least one city
SELECT name From country where EXISTS (Select *from City Where Country_id=country.id);

Drop table CYCLING;
--SET OPERATIONS
--Union

CREATE TABLE CYCLING (
id int PRIMARY KEY, 
name VARCHAR2(225),
country VARCHAR2(225));

INSERT INTO CYCLING VALUES (01,'YK','DE');
INSERT INTO CYCLING VALUES (02,'ZG','DE');
INSERT INTO CYCLING VALUES (03,'WT','PL');

Drop table SKATING;

CREATE TABLE SKATING (
id int PRIMARY KEY, 
name VARCHAR2(225),
country VARCHAR2(225));

INSERT INTO SKATING VALUES (01,'YK','DE');
INSERT INTO SKATING VALUES (02,'DF','DE');
INSERT INTO SKATING VALUES (03,'AK','PL');

--Union
--The query displaying German cyclists together with German Skaters:
Select name from CYCLING where country = 'DE'
UNION 
Select name from SKATING where country = 'DE';

--Intersect
Select name from CYCLING where country = 'DE'
INTERSECT
Select name from SKATING where country = 'DE';

--EXCEPT
SELECT name FROM CYCLING WHERE country = 'DE'
MINUS
SELECT name FROM SKATING WHERE country = 'DE';
