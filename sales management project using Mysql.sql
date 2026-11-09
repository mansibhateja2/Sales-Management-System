CREATE DATABASE sales_management;
USE sales_management;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    Phone VARCHAR(15)
);

INSERT INTO Customers
VALUES
(1, 'Rahul Sharma', 'Delhi', '9876543210'),
(2, 'Priya Singh', 'Mumbai', '9876543211'),
(3, 'Amit Kumar', 'Bangalore', '9876543212'),
(4, 'Neha Gupta', 'Delhi', '9876543213'),
(5, 'Rohan Mehta', 'Pune', '9876543214');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products
VALUES
(101, 'Laptop', 'Electronics', 55000, 20),
(102, 'Mouse', 'Electronics', 800, 100),
(103, 'Keyboard', 'Electronics', 1500, 75),
(104, 'Office Chair', 'Furniture', 7500, 30),
(105, 'Desk', 'Furniture', 12000, 15),
(106, 'Notebook', 'Stationery', 100, 200);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,

    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID),

    FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
);

INSERT INTO Orders
VALUES
(1001, 1, 101, '2026-01-05', 1),
(1002, 2, 102, '2026-01-07', 3),
(1003, 3, 104, '2026-01-10', 2),
(1004, 4, 103, '2026-01-15', 2),
(1005, 5, 106, '2026-01-20', 10),
(1006, 1, 105, '2026-02-05', 1),
(1007, 2, 101, '2026-02-10', 1),
(1008, 3, 102, '2026-02-15', 5);


CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    PaymentMethod VARCHAR(30),

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID)
);

INSERT INTO Payments
VALUES
(1, 1001, '2026-01-05', 55000, 'Card'),
(2, 1002, '2026-01-07', 2400, 'UPI'),
(3, 1003, '2026-01-10', 15000, 'Cash'),
(4, 1004, '2026-01-15', 3000, 'Card'),
(5, 1005, '2026-01-20', 1000, 'UPI'),
(6, 1006, '2026-02-05', 12000, 'Card'),
(7, 1007, '2026-02-10', 55000, 'UPI'),
(8, 1008, '2026-02-15', 4000, 'Cash');

-- TOTAL_REVENUE :

SELECT SUM(o.Quantity * p.Price) AS TotalRevenue
FROM Orders o
JOIN Products p
ON o.ProductID = p.ProductID;
 
 -- TOTAL_ORDERS:
 
SELECT COUNT(*) AS TotalOrders
FROM Orders;

-- TOTAL_QUANTITY_SOLD:

SELECT SUM(Quantity) AS TotalQuantity
FROM Orders;

-- SALES_BY_PRODUCT:

 SELECT
    p.ProductName,
    SUM(o.Quantity) AS QuantitySold,
    SUM(o.Quantity * p.Price) AS Revenue
FROM Orders o
JOIN Products p
ON o.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY Revenue DESC;   

-- SALES_BY_CATEGORY:

SELECT
    p.Category,
    SUM(o.Quantity * p.Price) AS Revenue
FROM Orders o
JOIN Products p
ON o.ProductID = p.ProductID
GROUP BY p.Category;

-- SALES_BY_CITY:

SELECT
    c.City,
    SUM(o.Quantity * p.Price) AS Revenue
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Products p
ON o.ProductID = p.ProductID
GROUP BY c.City;

-- MONTHLY_REVENUE:

SELECT
    MONTH(OrderDate) AS Month,
    SUM(o.Quantity * p.Price) AS Revenue
FROM Orders o
JOIN Products p
ON o.ProductID = p.ProductID
GROUP BY MONTH(OrderDate)
ORDER BY Month;



