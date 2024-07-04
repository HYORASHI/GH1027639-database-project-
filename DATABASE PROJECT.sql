-- Create the database
CREATE DATABASE SalesDB;
GO

-- Use the database
USE SalesDB;
GO

-- Create tables
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Phone NVARCHAR(15) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Position NVARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderDate DATETIME NOT NULL,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

#Create indexes
CREATE INDEX idx_customer_email ON Customers(Email);
CREATE INDEX idx_employee_email ON Employees(Email);
CREATE INDEX idx_order_customer ON Orders(CustomerID);
CREATE INDEX idx_order_employee ON Orders(EmployeeID);
CREATE INDEX idx_orderdetails_order ON OrderDetails(OrderID);
CREATE INDEX idx_orderdetails_product ON OrderDetails(ProductID);
GO

#Create stored procedure to update stock
CREATE PROCEDURE update_stock
    @ProductID INT,
    @Quantity INT
AS
BEGIN
 UPDATE Products
 SET Stock = Stock - @Quantity
WHERE ProductID = @ProductID;
END;
GO

#Create trigger to call the stored procedure after inserting into OrderDetails
CREATE TRIGGER
ON OrderDetails
AFTER INSERT
AS
BEGIN
    DECLARE @ProductID INT;
    DECLARE @Quantity INT;

    SELECT @ProductID = ProductID, @Quantity = Quantity
    FROM inserted;

    EXEC update_stock @ProductID, @Quantity;
END;
GO

-- Insert sample data
INSERT INTO Customers (FirstName, LastName, Email, Phone) VALUES
('John', 'Doe', 'john.doe@gmail.com', '555-123-4567'),
('Jane', 'Smith', 'jane.smith@yahoo.com', '555-234-5678'),
('Li', 'Wang', 'li.wang@hotmail.com', '555-345-6789'),
('Aisha', 'Khan', 'aisha.khan@gmail.com', '555-456-7890'),
('Carlos', 'Martinez', 'carlos.martinez@yahoo.com', '555-567-8901'),
('Yuki', 'Tanaka', 'yuki.tanaka@hotmail.com', '555-678-9012'),
('Michael', 'Johnson', 'michael.johnson@gmail.com', '555-789-0123'),
('Fatima', 'Ahmed', 'fatima.ahmed@yahoo.com', '555-890-1234'),
('David', 'Gonzalez', 'david.gonzalez@hotmail.com', '555-901-2345'),
('Sofia', 'Rossi', 'sofia.rossi@gmail.com', '555-012-3456');

INSERT INTO Employees (FirstName, LastName, Email, Position) VALUES
('Alice', 'Robinson', 'alice.robinson@company.com', 'Sales Manager'),
('Ethan', 'Nguyen', 'ethan.nguyen@company.com', 'Sales Associate'),
('Maria', 'Garcia', 'maria.garcia@company.com', 'Sales Associate'),
('Ravi', 'Patel', 'ravi.patel@company.com', 'Customer Service'),
('Mei', 'Zhang', 'mei.zhang@company.com', 'Sales Manager'),
('Adele', 'Dubois', 'adele.dubois@company.com', 'Sales Associate'),
('Hannah', 'Kim', 'hannah.kim@company.com', 'Customer Service'),
('James', 'Lopez', 'james.lopez@company.com', 'Sales Associate'),
('Lucas', 'Smith', 'lucas.smith@company.com', 'Sales Manager'),
('Natalie', 'Wilson', 'natalie.wilson@company.com', 'Customer Service');

INSERT INTO Products (ProductName, Price, Stock) VALUES
('PlayStation 5', 499.99, 50),
('Xbox Series X', 499.99, 30),
('Nintendo Switch', 299.99, 100),
('PS5 DualSense Controller', 69.99, 200),
('Xbox Wireless Controller', 59.99, 150),
('Nintendo Switch Pro Controller', 69.99, 120),
('PlayStation Plus Subscription', 59.99, 500),
('Xbox Game Pass', 14.99, 400),
('Nintendo Switch Online', 19.99, 350),
('PlayStation 5 Game: Demons Souls', 69.99, 75);

-- Randomized and realistic order dates
INSERT INTO Orders (OrderDate, CustomerID, EmployeeID)
VALUES
('2023-01-05', 1, 1),
('2023-01-17', 2, 2),
('2023-02-03', 3, 3),
('2023-02-14', 4, 4),
('2023-03-01', 5, 5),
('2023-03-15', 6, 6),
('2023-03-30', 7, 7),
('2023-04-12', 8, 8),
('2023-04-25', 9, 9),
('2023-05-10', 10, 10);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 1, 499.99),
(1, 4, 2, 69.99),
(2, 2, 1, 499.99),
(2, 5, 1, 59.99),
(3, 3, 1, 299.99),
(3, 6, 2, 69.99),
(4, 1, 1, 499.99),
(4, 7, 1, 59.99),
(5, 8, 2, 14.99),
(5, 9, 3, 19.99),
(6, 10, 1, 69.99),
(6, 3, 1, 299.99),
(7, 2, 1, 499.99),
(7, 5, 2, 59.99),
(8, 4, 1, 69.99),
(8, 6, 1, 69.99),
(9, 1, 1, 499.99),
(9, 7, 1, 59.99),
(10, 3, 1, 299.99),
(10, 10, 2, 69.99);
GO

-- Queries

-- A. Customer Information
SELECT * FROM Customers;
GO

-- B. Product Stock Levels
SELECT ProductName, Stock FROM Products;
GO

-- C. Orders and Order Details
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName, e.FirstName AS EmployeeFirstName, e.LastName AS EmployeeLastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID;
GO

SELECT od.OrderID, p.ProductName, od.Quantity, od.Price
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID;
GO

-- D. Total Sales Amount
SELECT o.OrderID, SUM(od.Quantity * od.Price) AS TotalAmount
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID;
GO

-- E. Top Selling Products by Quantity
SELECT TOP 3 p.ProductName, SUM(od.Quantity) AS TotalSold
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalSold DESC;
GO
