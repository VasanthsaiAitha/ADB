
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(100),
    address VARCHAR(255),
    contact_info VARCHAR(100));
CREATE TABLE Bank (
    bank_id INT PRIMARY KEY,
    bank_name VARCHAR(100),
    bank_location VARCHAR(255),
    contact_info VARCHAR(100));
CREATE TABLE Loan (
    loan_id INT PRIMARY KEY,
    amount DECIMAL(10, 2),
    interest_rate DECIMAL(5, 2),
    start_date DATE,
    end_date DATE,
    customer_id INT,
    bank_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (bank_id) REFERENCES Bank(bank_id)
);
CREATE TABLE Account (
    account_id INT PRIMARY KEY,
    balance DECIMAL(10, 2),
    acc_type VARCHAR(20),
    opening_date DATE,
    customer_id INT,
    bank_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (bank_id) REFERENCES Bank(bank_id)
);
INSERT INTO Customer VALUES (001,'Vasanth','513-3,Maryvill','+1 660-528-8618'); 
INSERT INTO Customer VALUES (002,'John','123 Main St','+1 123-456-7890');
INSERT INTO Customer VALUES (003,'Emily','456 Elm St','+1 987-654-3210');
INSERT INTO Customer VALUES (004,'Michael','789 Oak St','+1 555-123-4567');
INSERT INTO Customer VALUES (005,'Sarah','321 Pine St','+1 111-222-3333');
INSERT INTO Customer VALUES (006,'David','555 Maple St','+1 444-555-6666');
INSERT INTO Customer VALUES (007,'Jennifer','777 Cedar St','+1 777-888-9999');
INSERT INTO Customer VALUES (008,'Ryan','999 Walnut St','+1 999-888-7777');
INSERT INTO Customer VALUES (009,'Jessica','1010 Birch St','+1 101-202-3030');
INSERT INTO Customer VALUES (010,'Daniel','1212 Spruce St','+1 404-505-6060');


INSERT INTO Bank VALUES(101, 'State Bank of India', 'Mumbai', '022-1234-5678');
INSERT INTO Bank VALUES(102, 'ICICI Bank', 'Mumbai', '022-8765-4321');
INSERT INTO Bank VALUES(103, 'HDFC Bank', 'Mumbai', '022-9876-5432');
INSERT INTO Bank VALUES(104, 'Axis Bank', 'Mumbai', '022-3456-7890');
INSERT INTO Bank VALUES(105, 'Punjab National Bank', 'New Delhi', '011-2345-6789');
INSERT INTO Bank VALUES(106, 'Bank of Baroda', 'Vadodara', '0265-9876-5432');
INSERT INTO Bank VALUES(107, 'Canara Bank', 'Bengaluru', '080-1234-5678');
INSERT INTO Bank VALUES(108, 'Union Bank of India', 'Mumbai', '022-8765-4321');
INSERT INTO Bank VALUES(109, 'IndusInd Bank', 'Mumbai', '022-3456-7890');
INSERT INTO Bank VALUES(110, 'Kotak Mahindra Bank', 'Mumbai', '022-2345-6789');

INSERT INTO Loan VALUES (201, 5000.00, 4.5, TO_DATE('2023-01-15','YYYY-MM-DD'),TO_DATE('2023-07-15','YYYY-MM-DD'), 001, 101);
INSERT INTO Loan VALUES (202, 8000.00, 6.2, TO_DATE('2023-02-20','YYYY-MM-DD'), TO_DATE('2023-08-20','YYYY-MM-DD'), 002, 102);
INSERT INTO Loan VALUES (203, 12000.00, 7.8, TO_DATE('2023-03-25','YYYY-MM-DD'), TO_DATE('2023-09-25','YYYY-MM-DD'), 003, 103);
INSERT INTO Loan VALUES (204, 10000.00, 5.5, TO_DATE('2023-04-30','YYYY-MM-DD'), TO_DATE('2023-10-30','YYYY-MM-DD'), 001, 104);
INSERT INTO Loan VALUES (205, 15000.00, 8.3, TO_DATE('2023-05-10','YYYY-MM-DD'), TO_DATE('2023-11-10','YYYY-MM-DD'), 005, 105);
INSERT INTO Loan VALUES (206, 9000.00, 6.8, TO_DATE('2023-06-05','YYYY-MM-DD'), TO_DATE('2023-12-05','YYYY-MM-DD'), 006, 103);
INSERT INTO Loan VALUES (207, 11000.00, 6.5, TO_DATE('2023-07-20','YYYY-MM-DD'), TO_DATE('2024-01-20','YYYY-MM-DD'), 007, 101);
INSERT INTO Loan VALUES (208, 13000.00, 7.2, TO_DATE('2023-08-15','YYYY-MM-DD'), TO_DATE('2024-02-15','YYYY-MM-DD'), 008, 108);
INSERT INTO Loan VALUES (209, 14000.00, 8.0, TO_DATE('2023-09-01','YYYY-MM-DD'), TO_DATE('2024-03-01','YYYY-MM-DD'), 002, 109);
INSERT INTO Loan VALUES (210, 16000.00, 8.5, TO_DATE('2023-10-10','YYYY-MM-DD'), TO_DATE('2024-04-10','YYYY-MM-DD'), 010, 102);

INSERT INTO Account VALUES(301, 15000.00, 'Checking', TO_DATE('2023-04-30','YYYY-MM-DD'), 001, 101);
INSERT INTO Account VALUES(302, 12000.00, 'Savings', TO_DATE('2023-07-20','YYYY-MM-DD'), 002, 102);
INSERT INTO Account VALUES(303, 35000.00, 'Checking', TO_DATE('2023-10-10','YYYY-MM-DD'),  003, 103);
INSERT INTO Account VALUES(304, 30000.00, 'Current', TO_DATE('2024-01-25','YYYY-MM-DD'), 001, 104);
INSERT INTO Account VALUES(305, 35000.00, 'Current', TO_DATE('2024-04-15','YYYY-MM-DD'), 005, 105);
INSERT INTO Account VALUES(306, 5000.00, 'Checking', TO_DATE('2023-02-20','YYYY-MM-DD'), 006, 103);
INSERT INTO Account VALUES(307, 12000.00, 'Current', TO_DATE('2024-03-10','YYYY-MM-DD'), 007, 101);
INSERT INTO Account VALUES(308, 45000.00, 'Current', TO_DATE('2024-08-10','YYYY-MM-DD'), 008, 108);
INSERT INTO Account VALUES(309, 18000.00, 'Savings', TO_DATE('2023-09-01','YYYY-MM-DD'), 002, 109);
INSERT INTO Account VALUES(310, 20000.00, 'Current', TO_DATE('2023-11-15','YYYY-MM-DD'), 010, 102);

--Write a query to retrieve the total account balance, total loan amount, and number of customers from their respective tables without specifying entity types

Select sum(balance) AS total FROM Account
union 
Select sum(amount) AS total FROM Loan
union
SELECT COUNT(*) as count FROM Customer;

--Write a query to identify customers who simultaneously hold a savings account and a loan exceeding $10,000. Provide the SQL query with appropriate conditions to filter accounts and loans accordingly.

SELECT Customer.cust_name, Customer.customer_id
FROM Customer 
INNER JOIN Loan  ON Customer.customer_id = Loan.customer_id
INNER JOIN Account  ON Customer.customer_id = Account.customer_id
WHERE Loan.amount > 10000 AND Account.acc_type = 'Savings';

--Write a query to find the account IDs that are present in the 'Account' table but are not associated with any customer in the 'Customer' table. Provide the account IDs.

INSERT INTO Account VALUES(311, 00000.00, 'Current', TO_DATE('2023-11-15','YYYY-MM-DD'), NULL, NULL);

select Account.account_id FROM ACCOUNT
left JOIN Customer ON ACCOUNT.customer_id = Customer.customer_id
WHERE Customer.customer_id is NULL;

--Write a query to retrieve the account ID, balance, account type, opening date, customer name, and bank name for all accounts, including those without associated customers or banks.
SELECT 
    Account.account_id,
    Account.balance,
    Account.acc_type,
    Account.opening_date,
    COALESCE(Customer.cust_name, 'Customer not found') AS customer_name,
    COALESCE( Bank.bank_name, 'Bank not found') AS bank_name
FROM 
    Account
LEFT JOIN 
    Customer  ON Account.customer_id = Customer.customer_id
LEFT JOIN 
    Bank  ON Account.bank_id = Bank.bank_id;
    
INSERT INTO Bank VALUES(111, 'City Bank', 'Hyderbad', '011-2245-6389');
INSERT INTO Account VALUES(312, 100000.00, 'Current', TO_DATE('2023-11-15','YYYY-MM-DD'), NULL, NULL);

--Write a query to fetch customer details, account information, and corresponding bank details for accounts with balances exceeding $5000. Ensure all account and bank records are included, even if there are no corresponding customer records.
SELECT 
    COALESCE(Customer.customer_id, 0) AS customer_id,
    COALESCE(Customer.cust_name, 'No Customer') AS customer_name,
    Account.account_id,
    Account.balance,
    Account.acc_type,
    COALESCE(Bank.bank_id, 0) AS bank_id,
    COALESCE(Bank.bank_name, 'No Bank') AS bank_name,
    COALESCE(Bank.bank_location, 'No Location') AS bank_location,
    COALESCE(Bank.contact_info, 'No Contact Info') AS bank_contact_info
FROM 
    Account
LEFT JOIN 
    Customer  ON Account.customer_id = Customer.customer_id
LEFT JOIN 
    Bank  ON Account.bank_id = Bank.bank_id
WHERE 
    Account.balance > 5000;
    
--Write a query to fetch all accounts and their associated customers, including those accounts without customers, filtering only for accounts of type 'Savings'.   
SELECT
	Account.account_id,
    Account.balance,
    Account.acc_type,
	COALESCE(Customer.customer_id, 0) AS customer_id,
    COALESCE(Customer.cust_name, 'No Customer') AS customer_name
	FROM 
    Account
LEFT JOIN 
    Customer  ON Account.customer_id = Customer.customer_id
WHERE
	Account.acc_type = 'Savings';

--Write a query to retrieve the names of customers who have taken loans with an interest rate exceeding 5.0%.
SELECT
	Customer.customer_id,
	Customer.cust_name
FROM Customer
JOIN
	Loan ON Customer.customer_id = Loan.customer_id
WHERE
	Loan.interest_rate>5.0;

--Write a query to identify customers with active checking accounts who currently hold ongoing loans.
SELECT 
    Customer.customer_id, 
    Customer.cust_name
FROM 
Customer 
JOIN Account  ON Customer.customer_id = Account.customer_id
JOIN Loan ON Customer.customer_id = Loan.customer_id
WHERE  Loan.end_date > CURRENT_DATE;



--Create a sequence named 'order_id_seq' with the following properties: it should start at 1001, increment by 1 for each new value, have a maximum value of 999999999, and not cycle back to the start. Ensure that no caching is applied during the sequence generation process.
  
CREATE SEQUENCE order_id_seq
START WITH 1001
INCREMENT BY 1
MAXVALUE 999999999
NOCYCLE
NOCACHE;
   
SELECT * FROM user_sequences WHERE sequence_name = 'ORDER_ID_SEQ';