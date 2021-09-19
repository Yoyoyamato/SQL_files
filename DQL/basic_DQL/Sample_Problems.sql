---------- Sample Problems ------
--  27) Find the oldest and most recent hire date (hire_date) in the employees table. ----
SELECT
	min(hire_date) as oldest,
	max(hire_date) as recent
FROM
	employees
 
--  28) In the order_detils table, group by order_id and find the lowest line item total as min_price, 
-- the highest line item total as max_price, the difference between these two totals as diff
-- and the count per grouping as total. 

-- Note - deriving the value is computed as so: quantity * unit_price * (1-discount). Use round() on all
-- computed values to display an integer.

SELECT 
	order_id,
	min(round(quantity * unit_price * (1-discount))) as min_price, 
	max(round(quantity * unit_price * (1-discount))) as max_price,
	max(round(quantity * unit_price * (1-discount))) - min(round(quantity * unit_price * (1-discount))) as diff,
	count(*) as total
FROM 
	order_details
GROUP BY 
	order_id


--  29) From the products table, return the product_name field,
-- the price field which is computed by multiplying the unit_price by the 
-- units_in_stock field, the units_in_stock field, and the 
-- unit_price field. Sort by the price field descending and limit to 
-- 2 results. 

-- ** NOTE - this problem is a bit of a challenge. But try separating it out.
-- First, we need to compute the average price of the entire table, and then 
-- compare the average price of the product's table to the price of each individual 
-- product in the WHERE clause and filter out those price field values 
-- that exceed the average price. Here's a hint:
-- SELECT fields_to_include
-- FROM table 
-- WHERE some_value <= ( query_to_compute_average_price  ) <--- 
 
SELECT
	product_name,
	(unit_price * units_in_stock) as price,
	units_in_stock,
	unit_price
FROM
	products
ORDER BY
	price desc
LIMIT 2



----------- Sample Problems END -----------


-- 30) In the orders table, group by employee_id and shipped_date fields where the shipped_date is
-- the maximum shipped_date of the order's table. For each grouping, return the count of rows where
-- the shipped_date field is not null as number_orders_shipped and the total sum of the freight as sum_freight.
-- Order by this total descending.
WITH maximum
AS (
	SELECT
		employee_id,
		max(shipped_date) as s_date
	FROM
		orders
	GROUP BY 
		employee_id
)
SELECT
	od.employee_id,
	od.shipped_date,
	count(*) as number_orders_shipped,
	SUM(freight) as sum_freight
FROM
	orders as od,
	maximum
WHERE 
	od.shipped_date = maximum.s_date and
	od.employee_id = maximum.employee_id and
	od.shipped_date is not NULL
GROUP BY
	od.employee_id,
	od.shipped_date
ORDER BY
	sum_freight desc
 
--  31) From the customer's table, return the company_name and contact_title field where the 
-- contact_title is not in the top two most frequent contact_title field values in the
-- customer's table

WITH frequent
AS(
	SELECT
		contact_title,
		count(*)
	FROM
		customers
	GROUP BY
		contact_title
	ORDER BY
		count(*) desc
	limit 2
)

SELECT
	company_name,
	contact_title
FROM
	customers
WHERE
	contact_title not in (SELECT contact_title FROM frequent)