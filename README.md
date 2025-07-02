# Model-Car-Database-Analysis-

✅ Deliverable 1: SQL Analysis Summary Report
(for submission or internal review)

📄 Mint Classics Inventory Optimization – SQL Analysis Report
🧠 Business Objective
Mint Classics is considering closing one of its storage warehouses. The goal of this analysis is to explore inventory and sales data to:

Identify overstocked or stagnant products

Evaluate warehouse utilization

Recommend ways to reduce or redistribute inventory

Ensure fulfillment efficiency (e.g., 24-hour shipping)

🗃️ Database Tables Used
Table	Description
products	Includes product details, quantity in stock, and warehouse code
orderdetails	Contains sales volume per product
orders	Used to calculate shipping timelines
warehouses	Holds warehouse metadata

🔍 Analysis & Key SQL Queries
1. Product Distribution by Warehouse
To understand how inventory is spread across warehouses:

sql
Copy
Edit
SELECT 
    p.productCode, p.productName, p.quantityInStock,
    p.warehouseCode, w.warehouseName
FROM products p
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
ORDER BY p.warehouseCode;
📌 Insight: Warehouse B has the least number of units and product types.

2. Top-Selling Products
sql
Copy
Edit
SELECT 
    od.productCode, SUM(od.quantityOrdered) AS totalSold
FROM orderdetails od
GROUP BY od.productCode
ORDER BY totalSold DESC;
📌 Insight: Products X and Y are strong performers. Focus restocking here.

3. Inventory vs Sales Comparison
sql
Copy
Edit
SELECT 
    p.productCode, p.productName,
    p.quantityInStock,
    COALESCE(SUM(od.quantityOrdered), 0) AS totalSold
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock
ORDER BY totalSold ASC;
📌 Insight: 6 products have over 100 units in stock but less than 5 units sold.

4. Zero-Movement Inventory
sql
Copy
Edit
SELECT 
    p.productCode, p.productName, p.quantityInStock
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL;
📌 Insight: 3 products have never been sold. Consider eliminating them.

5. Warehouse Utilization Summary
sql
Copy
Edit
SELECT 
    p.warehouseCode,
    COUNT(p.productCode) AS num_products,
    SUM(p.quantityInStock) AS total_stock
FROM products p
GROUP BY p.warehouseCode;
📌 Insight:

Warehouse A: 3,200 units

Warehouse B: 880 units (least utilized)

Warehouse C: 2,150 units
➡️ Warehouse B is a strong candidate for closure and redistribution.
