# 📦 Mint Classics Inventory Optimization Project

## 📝 Project Overview

Mint Classics Company is a retailer of classic model cars and vehicles. The company is considering closing one of its storage facilities and has requested data-driven insights to guide this decision. The goal of this analysis is to explore the inventory distribution across warehouses, sales trends, and product performance in order to identify opportunities for inventory reduction or reorganization — while maintaining the ability to fulfill customer orders within 24 hours.

---

## 🎯 Project Objectives

1. Explore products currently in inventory.
2. Determine important factors that may influence inventory reorganization or reduction.
3. Provide analytical insights and actionable recommendations.

---

## 🧩 Database Schema Overview

The Mint Classics database includes the following relevant tables:

- **products**: Product information including quantity in stock and warehouse location.
- **warehouses**: Storage facility data including name and capacity.
- **orderdetails**: Records of products sold in each order.
- **orders**: Order metadata including order and shipping dates.
- **customers**, **payments**, **offices**, **employees**: Additional tables available but not central to this inventory analysis.

---

## 🔍 Key Business Questions

1. **Where are items currently stored, and could a warehouse be eliminated if products were rearranged?**
2. **Do current inventory levels align with sales activity?**
3. **Are we storing items that are not selling (dead stock)?**
4. **Which products could be removed from the catalog or de-prioritized?**

---

## 💡 Methodology

### 1. Products by Warehouse

```sql
SELECT 
    p.productCode,
    p.productName,
    p.warehouseCode,
    w.warehouseName,
    p.quantityInStock
FROM products p
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
ORDER BY p.warehouseCode;

## **📌 Insight: Revealed how product stock is distributed across warehouses.**

### **2. Total Sales per Product**
```sql
SELECT 
    od.productCode,
    SUM(od.quantityOrdered) AS total_quantity_sold
FROM orderdetails od
GROUP BY od.productCode
ORDER BY total_quantity_sold DESC;

##** 📌 Insight: Identified fast- and slow-moving products.**


### 3. Inventory vs Sales
```sql
SELECT 
    p.productCode,
    p.productName,
    p.quantityInStock,
    COALESCE(SUM(od.quantityOrdered), 0) AS totalSold
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock
ORDER BY totalSold DESC;

## 📌 Insight: Highlighted overstocked items with low sales.

### 4. Dead Stock – Products With No Sales
``` sql
SELECT 
    p.productCode,
    p.productName,
    p.quantityInStock
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL;

##📌 Insight: Found products in stock but never ordered — strong candidates for removal.

```sql
SELECT 
    w.warehouseCode,
    w.warehouseName,
    COUNT(p.productCode) AS total_products,
    SUM(p.quantityInStock) AS total_units
FROM warehouses w
JOIN products p ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseCode, w.warehouseName;

##📌 Insight: Compared warehouses by product variety and volume — key for assessing closure potential.

📊 Summary of Findings
📦 Warehouse C holds the fewest items and has lower volume — a candidate for closure if products are redistributed.

🐌 Several products have high inventory but low sales, indicating potential overstocking.

❌ Products like S24_1937 and S12_1099 have zero sales — consider discontinuing or liquidating.

⏳ Time-based sales (optional analysis) show seasonal patterns, which can inform stock levels per quarter.

✅ Recommendations
Close Warehouse C:

Transfer active products to Warehouses A and B.

Validate that those warehouses have enough capacity.

Reduce Inventory for Slow-Moving Products:

Adjust reorder points and quantities.

Liquidate or discount overstocked, low-demand items.

Discontinue Dead Stock:

Remove products with no sales history to free up space and reduce holding costs.

Implement Continuous Inventory Monitoring:

Establish a quarterly product performance review.

Track inventory vs sales velocity KPIs.

🛠️ Tools Used
SQL (MySQL Workbench)

ERD Analysis for schema understanding

Exploratory Data Analysis (EDA) using SQL queries

📁 Deliverables
✅ SQL Queries (see above)

✅ Analytical insights

✅ Recommendations for action

📊 Optional: Visualizations can be created using Excel or a BI tool (e.g., Looker Studio, Tableau)

🙋 Next Steps
Meet with Ops team to validate warehouse capacity.

Run simulations on warehouse redistribution.

Integrate sales forecasts into inventory planning.

👤 Author
Yazid Ohiare
Data Analyst | Business Analyst | Inventory Optimization Specialist


