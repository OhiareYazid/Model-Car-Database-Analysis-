/* Which products are stored in each warehouse?

1. Which products are selling frequently? Which are stagnant?

2. Can products be redistributed to fewer warehouses?

3 . Are we overstocking slow-moving items?*/

# What products are stored in each warehouse
SELECT * 
FROM products;
SELECT 
    p.productCode,
    p.productName,
    p.warehouseCode,
    w.warehouseName,
    p.quantityInStock
FROM products p
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
ORDER BY p.warehouseCode;


# What products are actually sold
SELECT 
    od.productCode,
    SUM(od.quantityOrdered) AS total_quantity_sold
FROM orderdetails od
GROUP BY od.productCode
ORDER BY total_quantity_sold DESC;


# Inventory / Sales Comparison

SELECT 
    p.productCode,
    p.productName,
    p.quantityInStock,
    COALESCE(SUM(od.quantityOrdered), 0) AS totalSold
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock
ORDER BY totalSold DESC;

# products not been sold at all

SELECT 
    p.productCode,
    p.productName,
    p.quantityInStock
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL;

#warehouse optimization
SELECT 
    w.warehouseCode,
    w.warehouseName,
    COUNT(p.productCode) AS total_products,
    SUM(p.quantityInStock) AS total_units,
    warehousePctCap
    
FROM warehouses w
JOIN products p ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseCode, w.warehouseName
ORDER BY total_units DESC;



# time based trends

SELECT 
    YEAR(o.orderDate) AS year,
    MONTH(o.orderDate) AS month,
    od.productCode,
    SUM(od.quantityOrdered) AS monthly_sales
FROM orderdetails od
JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY year, month, od.productCode
ORDER BY year, month;

