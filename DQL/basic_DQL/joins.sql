-- - Inner joins are the SQL Server default. You can abbreviate the INNER JOIN clause to JOIN.
-- -Specify the columns that you want to display in your result set by including the column names in the select list.
-- -Include a WHERE clause to restrict the rows that are returned in the result set.
-- -Do not use a null value as a join condition, because null values do not evaluate equally with one another.
-- -SQL Server does not guarantee an order in the result set unless one is specified with an ORDER BY clause.
-- -You can use multiple JOIN clauses and join more than two tables in the same query.


-- 32) In the products table, return the product_name field (products) and company_name field (suppliers) 
-- by joining on the suppliers table primary key. Sort by company_name field ascending.

SELECT
	pt.product_name,
	suppliers.company_name
FROM
	products as pt
INNER JOIN
	suppliers on 
	suppliers.supplier_id = pt.supplier_id
ORDER BY
	suppliers.company_name
 

-- 33) Return the company_name (customers), order_date (orders),  contact_title (customers) for all orders placed
-- after '1998-01-01', Sort by order_date, company_name, contact_title fields all ascending.

SELECT
	customers.company_name,
	od.order_date,
	customers.contact_title
FROM
	orders as od
INNER JOIN
	customers on
	customers.customer_id = od.customer_id
WHERE
	od.order_date >= '1998-01-01'
ORDER BY
	od.order_date asc,
	customers.company_name asc,
	customers.contact_title asc


-- 34)Concantenate the first_name and last_name fields as fullname (employee), the city (employee),
-- the order_id (orders), the status which is calculated conditionally to evaluate to 'LATE' when shipped_date
-- is greater than the required_date (orders) or else evaluate to 'OK', the interval between the
-- shipped_date and required_date as 'days', and the shipped_date and required_date. Join the employee and 
-- orders table on the employees table primary key where the shipped_date is not null. Sort by status 
-- ascending and days descending. Limit to 5 results.
SELECT
	employees.first_name || ' ' || employees.last_name as fullname,
	employees.city,
	od.order_id,
	CASE WHEN od.shipped_date > od.required_date THEN 'LATE' ELSE 'OK' END as status,
	od.shipped_date - od.required_date as days,
	od.shipped_date,
	od.required_date
FROM
	orders as od
INNER JOIN 
	employees on
	employees.employee_id = od.employee_id
WHERE
	od.shipped_date is not NULL
ORDER BY
	status asc,
	days desc
LIMIT 5
	
	
-- 35) Return the top 5 employees grouped by employee_id and fullname which is the first_name and last_name 
-- concatenated (all in employees table). In these groupings, sum the difference between the shipped_date and
-- required_date in cases where the shipped_date is greater than the required_date field value and name this field
-- days_late. Sort by days_late descending and fullname ascending. Limit to 5 results.

SELECT
	employees.employee_id,
	employees.first_name || ' ' || employees.last_name as fullname,
	SUM(od.shipped_date - od.required_date) as days_late
FROM
	orders as od
INNER JOIN 
	employees on
	employees.employee_id = od.employee_id
WHERE
	od.shipped_date - od.required_date > 0
GROUP BY
	employees.employee_id,
	employees.first_name || ' ' || employees.last_name
ORDER BY
	days_late desc,
	fullname asc
LIMIT 5

