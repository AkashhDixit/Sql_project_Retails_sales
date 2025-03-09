---SQL RETAILS SALES ANALYSIS---P1

create database sql_sales_project_p1;

---create a sales_tables---

create table reatils_sales
(transactions_id INT PRIMARY KEY,	
 sale_date	DATE,
 sale_time	TIME,
 customer_id INT,
 gender	VARCHAR(20),
 age INT,
 category VARCHAR(20),
 quantiy INT,
 price_per_unit	FLOAT,
 cogs FLOAT,
 total_sale FLOAT
);
--------------------------------------------------------------------------------------
select * FROM reatils_sales
limit 10;

select Count(*) 
FROM reatils_sales;

select * FROM reatils_sales
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;



select Count(*) FROM reatils_sales;



delete FROM reatils_sales
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;


-----PROJECT START NOW-------

--1. How many sales are done?
select Count(*) as total_sales
from reatils_sales;

---2. HOW MANY UNIUQUE CUSTOMER WE HAVE ?

select Count(distinct customer_id) as total_sales
from reatils_sales;
---

select distinct category 
from reatils_sales;

--Data Analysis & business key Problems & Answers--


1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

select * 
from reatils_sales
where sale_date ='2022-11-05'; 


--2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 
in the month of Nov-2022**:

select 
 *
 
 from reatils_sales
 where category ='Clothing'
       And
	   To_char(sale_date,'YYYY-MM') ='2022-11'
	   AND 
	   quantiy >=4;
	   
---3. **Write a SQL query to calculate the total sales (total_sale) for each category.
	   
select category,
       sum(total_sale) as net_sales,
	   Count(*) as total_orders
from reatils_sales
group by category;

---4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**

select round(avg(age),2) as AVG_age
from reatils_sales
where category ='Beauty';


--5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

select * from reatils_sales
where total_sale >1000;

---6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

select 
      category,
	  gender,
	  count(*) as total_transaction
from reatils_sales
group by category,
	  gender
order by 1;	  


--7. **Write a SQL query to calculate the average sale for each month. Find out best selling month 
in each year**:

SELECT 
       YEAR,
	   MONTH,
	   AVG_SALE
FROM 
(
  SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    ROUND(CAST(AVG(total_sale) AS NUMERIC), 1) AS avg_sale,
	RANK () OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS RANK
FROM reatils_sales
GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS T1
where rank =1;


--8. **Write a SQL query to find the top 5 customers based on the highest total sales **

select customer_id,
        sum(total_sale) as total_sales
		from reatils_sales
		group by 1
		order by 2 desc
		limit 5;

--9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

select 
      category,
	  count(DISTINCT customer_id) as Unique_customer_count
	  from reatils_sales
	  group by category
	  order by 2 desc; 


--10.**Write a SQL query to create each shift and number of orders 
(Example Morning <12, Afternoon Between 12 & 17, Evening >17)**?

WITH Hourly_sales
As (
SELECT *,
      CASE 
	  WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'MORNING'
	  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
	  ELSE 'EVENING'
	  END AS SHIFT
FROM reatils_sales
)
select SHIFT, 
       Count(*) as total_orders
from Hourly_sales
group by shift
order by total_orders desc;



---END OF PROJECT--



