# 🛒 SQL Retail Sales Analysis

## 📌 Project Overview
This project focuses on analyzing retail sales data using **PostgreSQL (Psql-4)**. The dataset includes transaction details such as sale date, customer demographics, product categories, and revenue metrics. The goal is to extract key business insights using SQL queries.

## 🔧 Tools & Technologies
- **Database:** PostgreSQL (Psql-4)
- **SQL Queries:** Data Cleaning, Aggregations, Window Functions
- **Use Case:** Business Intelligence & Data Analysis

## 📂 Database Schema

```sql
CREATE DATABASE sql_sales_project_p1;

CREATE TABLE reatils_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(20),
    age INT,
    category VARCHAR(20),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

## 🔍 Data Exploration & Cleaning

### 1️⃣ Checking Sample Data
```sql
SELECT * FROM reatils_sales LIMIT 10;
```

### 2️⃣ Checking for Missing Values
```sql
SELECT * FROM reatils_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

### 3️⃣ Deleting Rows with Null Values
```sql
DELETE FROM reatils_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

## 📊 Key Business Insights

### 1️⃣ Total Number of Sales Transactions
```sql
SELECT COUNT(*) AS total_sales FROM reatils_sales;
```

### 2️⃣ Unique Customers
```sql
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM reatils_sales;
```

### 3️⃣ Unique Product Categories
```sql
SELECT DISTINCT category FROM reatils_sales;
```

## 📈 Business Queries & Insights

### 1️⃣ Sales on a Specific Date
```sql
SELECT * FROM reatils_sales WHERE sale_date = '2022-11-05';
```

### 2️⃣ High-Quantity Clothing Sales in Nov-2022
```sql
SELECT * FROM reatils_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantiy >= 4;
```

### 3️⃣ Total Sales per Category
```sql
SELECT category, SUM(total_sale) AS net_sales, COUNT(*) AS total_orders
FROM reatils_sales
GROUP BY category;
```

### 4️⃣ Average Age of Customers for 'Beauty' Category
```sql
SELECT ROUND(AVG(age), 2) AS avg_age
FROM reatils_sales
WHERE category = 'Beauty';
```

### 5️⃣ Transactions with Total Sales Greater than 1000
```sql
SELECT * FROM reatils_sales WHERE total_sale > 1000;
```

### 6️⃣ Transactions Count by Gender & Category
```sql
SELECT category, gender, COUNT(*) AS total_transaction
FROM reatils_sales
GROUP BY category, gender
ORDER BY category;
```

### 7️⃣ Best Selling Month Each Year
```sql
SELECT year, month, avg_sale
FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS year,
           EXTRACT(MONTH FROM sale_date) AS month,
           ROUND(AVG(total_sale), 1) AS avg_sale,
           RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM reatils_sales
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS T1
WHERE rank = 1;
```

### 8️⃣ Top 5 Customers by Total Sales
```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM reatils_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### 9️⃣ Unique Customer Count per Category
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customer_count
FROM reatils_sales
GROUP BY category
ORDER BY unique_customer_count DESC;
```

### 🔟 Orders Categorized by Shift (Morning, Afternoon, Evening)
```sql
WITH Hourly_sales AS (
    SELECT *,
           CASE 
               WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
               WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
               ELSE 'EVENING'
           END AS shift
    FROM reatils_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM Hourly_sales
GROUP BY shift
ORDER BY total_orders DESC;
```

---

## 🚀 Conclusion
This project demonstrates how **SQL** can be leveraged for **retail sales analysis**, from data cleaning to business insights. The queries help in understanding customer behavior, sales trends, and key revenue drivers.

📌 **Next Steps:** Implement **Power BI dashboards** for visualization and deeper insights.

💡 **Connect with me:** [LinkedIn](https://www.linkedin.com/in/akash-dixit-bbb3b5170/) | 📩 dixitakashh@gmail.com
