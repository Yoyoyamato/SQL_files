-- AGGREGATE Functions ---

-- (21) From the movies_revenues, SELECT and find the difference between the average (AVG()) 
-- of the revenues_domestic subtracted from the renuves_international as Diff,
-- and the individual average of all the domestic and international as Domestic and International respectively
 
SELECT
	AVG(revenues_domestic) - AVG(revenues_international) as Diff,
	AVG(revenues_domestic) as Domestic,
	AVG(revenues_international) as International
FROM
	movies_revenues
 

-- 22) From the orders table, group by employee_id where the shipped_date is not null 
-- and return the count as number_of_orders, the maximum freight as m_freight.
-- Only return results where the maximum freight is larger than 800 and order
-- by the maximum freight descending

-- CHECK not null use "field IS NOT NULL"

SELECT
	employee_id,
	count(*) as number_of_orders,
	max(freight) as m_freight
FROM
	orders
WHERE
	shipped_date is not NULL
GROUP BY
	employee_id
HAVING
	max(freight) > 800
ORDER BY
	max(freight) desc


-- 23) From the products table, group by category_id and discontinued and 
-- return the sum of the unit_price mulitiplied by the units_in_stock of each
-- item as inventory_value and round it, round the average unit_price of each grouping
-- as avg_price, and count the number of items per grouping as total. Only 
-- return results with a category_id either equal to 1 or 2. Sort by category_id and discontinued
-- ascending


SELECT
	category_id,
	discontinued,
	round(sum(unit_price * units_in_stock)) as inventory_value,
	round(avg(unit_price)),
	count(*) as total
FROM
	products
WHERE
	category_id in (1, 2)
GROUP BY
	category_id,
	discontinued
ORDER BY
	category_id,
	discontinued asc


-- 24) From the order_details table, group on order_id, and return the total
-- quantity as total_units, round the sum of each item's quantity 
-- multiplied by the unit price multiplied by 1 - the discount field and call it
-- total_spending, and the total count of each grouping as total_orders. 
-- Only include in your calculation where the discount is greater than 0 and the
-- count of the order_id is equal to 3. Sort by total_spending descending.

SELECT
	order_id,
	sum(quantity) as total_units,
	round(sum(quantity * unit_price * (1 - discount))) as total_spending,
	count(*) as total_orders
FROM
	order_details
WHERE
	discount > 0
GROUP BY
	order_id
HAVING
	count(*) = 3
ORDER BY
	total_spending desc

-- 25) From customers table, group by job_title and return the count per grouping as total. 
-- To compute job_title, consider the following cases:
-- (a) when contact_title contains the word 'Sale' in it and does not contain the word 'Manager' or 'Owner' label it as "Sales"
-- (b) when the contact_title contains the word "Owner" or "Manager" then label it as 'Upper Management'
-- (c) otherwise return the contact_title
-- Sort the results by total and job_title desc

SELECT
	CASE 
		WHEN contact_title like '%Sale%' and (contact_title not like '%Manager%' or contact_title not like '%Owner%') THEN 'Sales'
		WHEN contact_title like '%Manager%' or contact_title like '%Owner%' THEN 'Upper Management'
			ELSE contact_title END as job_title,
	count(*) as total
FROM
	customers
GROUP BY
	CASE 
		WHEN contact_title like '%Sale%' and (contact_title not like '%Manager%' or contact_title not like '%Owner%') THEN 'Sales'
		WHEN contact_title like '%Manager%' or contact_title like '%Owner%' THEN 'Upper Management'
			ELSE contact_title END



-- 26) From the products table, group by supplier_id and reutrn the count of supplier_id as total and
-- if groupings of supplier_id only have a single distinct category_id, label it "Single", otherwise if it is
-- greater than label it as "Mixed" and these set of labels have the alias of cat_type. Sort by
-- cat_type and total	

SELECT
	supplier_id,
	count(supplier_id) as total,
	CASE WHEN count(distinct category_id) = 1 THEN 'Single' ELSE 'Mixed' END as cat_type
FROM
	products
GROUP BY
	supplier_id
ORDER BY
	cat_type,
	total