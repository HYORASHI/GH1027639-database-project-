README

Database Name: SalesDB

Description: This database is designed to manage sales data for a retail company. It includes tables for customers, employees, products, orders, and order details.

Tables:

Customers: Stores customer information, including customer ID, first name, last name, email, and phone number.
Employees: Stores employee information, including employee ID, first name, last name, email, and position.
Products: Stores product information, including product ID, product name, price, and stock level.
Orders: Stores order information, including order ID, order date, customer ID, and employee ID.
OrderDetails: Stores order detail information, including order detail ID, order ID, product ID, quantity, and price.
Indexes:

idx_customer_email: Index on the Email column in the Customers table.
idx_employee_email: Index on the Email column in the Employees table.
idx_order_customer: Index on the CustomerID column in the Orders table.
idx_order_employee: Index on the EmployeeID column in the Orders table.
idx_orderdetails_order: Index on the OrderID column in the OrderDetails table.
idx_orderdetails_product: Index on the ProductID column in the OrderDetails table.
Stored Procedure:

update_stock: Updates the stock level of a product when an order is placed.
Trigger:

Trigger on OrderDetails: Calls the update_stock stored procedure after inserting a new order detail.
Sample Data:

The database includes sample data for customers, employees, products, orders, and order details.
Queries:

A. Customer Information: Retrieves all customer information.
B. Product Stock Levels: Retrieves all product stock levels.
C. Orders and Order Details: Retrieves all order and order detail information.
D. Total Sales Amount: Calculates the total sales amount for each order.
E. Top Selling Products by Quantity: Retrieves the top 3 selling products by quantity.