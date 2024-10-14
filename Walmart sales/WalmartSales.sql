create database walmart_sales;

CREATE TABLE sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);


select * from sales;

-- Time_of_Day
-- Add the time_of_day column


SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;

alter table sales add column time_of_day varchar(20);

SET SQL_SAFE_UPDATES = 0;

UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

select * from sales;

-- Day_Name
select
	Date,
    dayname(Date)
from sales;

update sales
set Day_Name = dayname(Date);
select* from sales;

-- Month_Name
select
	Date,
    monthname(Date)
from sales;

update sales
set Month_Name = monthname(Date);

select * from sales;

### Generic Question

-- 1. How many unique cities does the data have?
select count(distinct city) as unique_cities
from sales;

-- 2. In which city is each branch?
select branch , city
from sales;

### Product

-- 1. How many unique product lines does the data have?
select count(distinct product_line) as unique_line
from sales;

-- 2. What is the most common payment method?
select payment , count(*) as count
from sales
group by payment
order by count desc
limit 1; 

-- 3. What is the most selling product line?
select product_line , sum(quantity) as selling_times
from sales
group by product_line
order by selling_times
limit 1;

-- 4. What is the total revenue by month?
select month(date) as month , sum(total) as total_revenue 
from sales
group by month(date)
order by month;

-- 5. What month had the largest COGS?
select month(date) as month , sum(COGS) as total_COGS 
from sales
group by month(date)
order by total_COGS desc
limit 1;

-- 6. What product line had the largest revenue?
select product_line , sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc
limit 1;

-- 5. What is the city with the largest revenue?
select city , sum(total) as total_revenue
from sales
group by city
order by total_revenue desc
limit 1;

-- 6. What product line had the largest VAT?
select product_line , sum(tax_pct) as total_vat
from sales
group by product_line
order by total_vat desc
limit 1;

-- 7. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
select avg(quantity) as average
from sales;
select product_line,
case 
     WHEN avg(quantity) > 5.4995 THEN "Good"
     else "Bad"
end as Rating
from sales 
group by product_line ;



-- 8. Which branch sold more products than average product sold?
select branch , sum(quantity) 
from sales 
group by branch
having sum(quantity) > (select avg(quantity) from sales) 
order by sum(quantity) desc
limit 1;


-- 9. What is the most common product line by gender?
select product_line , gender,  count(*) as count
from sales
group by product_line , gender
order by count desc
limit 1; 

-- 12. What is the average rating of each product line?
select product_line , avg(rating) as avg_rating
from sales
group by product_line;

### Sales

-- 1. Number of sales made in each time of the day per weekday
select dayname(date) as weekday, hour(time) as hour, count(*) as sales_no
from sales
group by dayname(date), hour(time)
order by weekday, hour;

-- 2. Which of the customer types brings the most revenue?
select customer_type , sum(total) as total_revenue
from sales
group by customer_type
order by total_revenue desc
limit 1;

-- 3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
select city , avg(tax_pct) as avg_vat
from sales
group by city
order by avg_vat desc
limit 1;

-- 4. Which customer type pays the most in VAT?
select customer_type , sum(tax_pct) as total_vat
from sales
group by customer_type
order by total_vat desc
limit 1;


### Customer

-- 1. How many unique customer types does the data have?
select count(distinct customer_type) as unique_types
from sales;

-- 2. How many unique payment methods does the data have?
select count(distinct payment ) as unique_methods
from sales;

-- 3. What is the most common customer type?
select customer_type, count(*) as count
from sales
group by customer_type
order by count desc
limit 1;

-- 4. Which customer type buys the most?
select customer_type, sum(quantity) as total_purchase
from sales
group by customer_type
order by total_purchase desc
limit 1;

-- 5. What is the gender of most of the customers?
select gender, count(*) as count
from sales
group by gender
order by count desc
limit 1;

-- 6. What is the gender distribution per branch?
select branch , gender
from sales
group by branch, gender;

select * from sales;

-- 7. Which time of the day do customers give most ratings?
select time_of_day , count(rating) as count , avg(rating) as avg_rate
from sales
group by time_of_day;



-- 8. Which time of the day do customers give most ratings per branch?
select branch, time_of_day , count(rating) as count , avg(rating) as avg_rate
from sales
group by branch , time_of_day
order by branch, avg_rate desc;

-- 9. Which day fo the week has the best avg ratings?


--  10. Which day of the week has the best average ratings per branch?
select  day_name ,branch, count(rating) as count , avg(rating) as avg_rate
from sales
group by branch , day_name
order by day_name, avg_rate desc;
