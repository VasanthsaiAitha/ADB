CREATE TABLE Product(
Product_Code int PRIMARY KEY,
Product_Name VARCHAR2(225),
Price_Per_Unit int,
CostPrice_per_unit int,
Profit_Per_Unit,
Quantity_In_Stock int)

CREATE TABLE Location(
Location_ID int PRIMARY KEY,
Country VARCHAR2(225),
Statee VARCHAR2(225),
City VARCHAR2(225) ,
Street VARCHAR2(225),
Zipcode int)

CREATE TABLE Timee (
Time_ID int PRIMARY KEY,
YEAR int,
Quarter int,
Monthh int,
dayy int,
HOURr int,
minn int,
SECONDd int)

CREATE TABLE Sales(
Sales_ID int PRIMARY KEY,
Product_Code int ,
Location_ID int ,
Time_ID int,
Units_Sold int,
Dollars_Earned int,
FOREIGN KEY (Product_Code) REFERENCES Product(Product_Code),
FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID),
FOREIGN KEY (Time_ID) REFERENCES Timee(Time_ID))
