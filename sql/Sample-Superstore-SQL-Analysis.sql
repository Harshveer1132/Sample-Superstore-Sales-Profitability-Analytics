
/*
Project: Sample Superstore Sales & Profitability Analysis
Purpose: Analyze sales, profit, customers, products, regions,
         discounts, shipping modes, monthly trends, and returns.
Database: Sample Superstore
Tool: MySQL

Author: Harshveer

*/

-- Q1. Overall Sales, Profit, and Quantity

SELECT
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit,
SUM(Quantity) AS total_quantity
FROM orders;

-- Q2. Sales and Profit by Product Category

SELECT Category,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM orders
GROUP BY Category
ORDER BY total_sales DESC;

-- Q3. Sales and Profit by Sub-Category

SELECT Category,  `Sub-Category`,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM orders
GROUP BY Category, `Sub-Category`
ORDER BY total_profit DESC;

-- Q4. Sales and Profit by Region

SELECT Region,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM orders
GROUP BY Region
ORDER BY total_sales DESC;

-- Q5. Sales and Profit by State

SELECT State,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM orders
GROUP BY State
ORDER BY total_profit DESC;

-- Q6. Sales and Profit by Shipping Mode

SELECT `Ship Mode`,
COUNT(DISTINCT `Order ID`) AS total_orders,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM orders
GROUP BY `Ship Mode`
ORDER BY total_profit DESC;

-- Q7. Discount Analysis and Profitability

select discount,
count(*)  as total_orders,
round(sum(sales),2) as total_sales, 
round(sum(profit),2) as total_profit, 
round(avg(sales),2) as avg_profit_per_record
from orders
group by discount
order by discount;

-- Q8. Sales and Profit by Customer Segment

SELECT Segment,
COUNT(DISTINCT `Order ID`) AS total_orders,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM orders
GROUP BY Segment
ORDER BY total_profit DESC;

-- Q9. Top 10 Customers by Sales

SELECT `Customer ID`, `Customer Name`,
COUNT(DISTINCT `Order ID`) AS total_orders,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM orders
GROUP BY `Customer ID`, `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

-- Q10. Monthly Sales and Profit Trends

SELECT
YEAR(`Order Date`) AS order_year,
MONTH(`Order Date`) AS order_month,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM orders
GROUP BY
YEAR(`Order Date`),
MONTH(`Order Date`)
ORDER BY
order_year,
order_month;

-- Q11. Returned Orders Analysis

SELECT CASE
WHEN r.`Order ID` IS NOT NULL THEN 'Returned'
ELSE 'Not Returned'
END AS return_status,
COUNT(DISTINCT o.`Order ID`) AS total_orders
FROM orders o
LEFT JOIN (SELECT DISTINCT `Order ID`FROM returns) r
ON o.`Order ID` = r.`Order ID`
GROUP BY return_status;

-- Q12. Average Discount by Sub-Category

SELECT `Sub-Category`,
ROUND(AVG(Discount) * 100, 2) AS avg_discount_pct,
ROUND(SUM(Profit), 2) AS total_profit
FROM orders
GROUP BY `Sub-Category`
ORDER BY avg_discount_pct DESC;


