
CREATE TABLE Customers (
    CustomerID INT,
    FullName VARCHAR(100),
    Email VARCHAR(100)
);

INSERT INTO Customers VALUES
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Smith', 'bob@example.com'),
(3, 'Charlie Lee', 'charlie@example.com'),
(2, 'Bob Smith', 'bob@example.com'), -- duplicate
(1, 'Alice Johnson', 'alice@example.com'); -- duplicate


select * from Customers;

SELECT email, COUNT(*) AS count
FROM Customers
GROUP BY email
HAVING COUNT(*) > 1;

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY FullName
               ORDER BY CustomerID
           ) AS rn
    FROM Customers
)
-- select * from CTE;
DELETE FROM CTE
WHERE rn > 1;

select * from Customers;

select * into users from customers;

select * from users;


CREATE TABLE EmployeeData (
    EmployeeID INT,
    FullName VARCHAR(100),
    Department VARCHAR(50),
    JobTitle VARCHAR(100),
    Email VARCHAR(100),
    Salary DECIMAL(10, 2),
    JoiningDate DATE,
    Status VARCHAR(20)
);


---- method to remove duplicates using ROW_NUMBER (Example 2)
INSERT INTO EmployeeData VALUES
(1, 'Alice Johnson', 'HR', 'Manager', 'alice@company.com', 70000, '2020-01-15', 'Active'),
(2, 'Bob Smith', 'Finance', 'Analyst', 'bob@company.com', 65000, '2019-03-12', 'Active'),
(3, 'Charlie Lee', 'IT', 'Developer', 'charlie@company.com', 75000, '2021-07-01', 'Active'),
(4, 'David Kim', 'IT', 'Developer', 'david@company.com', 75000, '2021-07-01', 'Active'),
(1, 'Alice Johnson', 'HR', 'Manager', 'alice@company.com', 70000, '2020-01-15', 'Active'), -- duplicate
(2, 'Bob Smith', 'Finance', 'Analyst', 'bob@company.com', 65000, '2019-03-12', 'Active'), -- duplicate
(5, 'Eva White', 'Marketing', 'Executive', 'eva@company.com', 60000, '2022-05-10', 'Inactive');

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY FullName, Department, JobTitle, Email, Salary, JoiningDate, Status
               ORDER BY EmployeeID
           ) AS rn
    FROM EmployeeData
)
DELETE FROM CTE
where rn > 1;

select * from EmployeeData;

---- method to remove duplicate rows using Distinct
SELECT DISTINCT *
INTO empdata
FROM EmployeeData;

select * from empdata;